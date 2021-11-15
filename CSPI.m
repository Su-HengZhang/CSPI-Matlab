close all;
clear, clc;

%%
% He-Ne laser wavelength is 632.8e-6 mm
lambda=632.8e-6;

% the focal length of the front lens of the 4f system is 300 mm
focal_lens=300;

% the effective aperture diameter in our experiments
dia_eff=40;

% the cutoff frequency of the 4f system
freq_cut=dia_eff/(2*lambda*focal_lens);

% the LCoS pixel pitch is 8e-3 mm
del_lcos = 8e-3;

% set the sampling points of each LCoS pixel pitch
samp=8;

% the numerical calculation of sampling interval (mm)
del_samp=del_lcos/samp;


%%
% set Hadamard matrix order
N=4;

% set the imaging region size
N_im=128;

% set digital zoom
digzoom=N_im/N;

% generate Walsh-Hadamard matrix
H=N*fwht(eye(N));

% set frequency coordinate list ul,vl
% the real frequency is ul-1, vl-1
ul=1:N;
vl=1:N;

%%
% sampling point in the imaging region
Ns=N_im*samp;

% load the sampled taget image
load("usaf1k.mat");
f_org=pad2center(usaf1k,2*Ns, 2*Ns);

%%
% the frequency interval of the discrete Fourier transform
del_f=1/(del_samp*Ns*2);

% the dimensionless cutoff frequency
Dc=freq_cut/del_f;

%%
% set measurement parameter
%phi=angle(sum(f_org(:)));
phi=pi/4;

% the total number of Hadamard basis matrix
Tnum=N^2;

% 4 step phase shift
kl=(0:3);

% initialize basis scan measurement data array
mdata=zeros(Tnum,4);

%%
% one pixel of basis pattern 
ones_samp_dz=ones(samp*digzoom);

% ideal low pass filter of the 4f system
lp4f=lpfilter('ideal',Ns*2,Ns*2,Dc);

%%
Cnum=1;
fprintf('Hadamard base scan measurement begin:\n');
fprintf('Total basis pattern number is %d\n',Tnum);
% begin time
timbeg=datestr(now,'yyyymmddTHHMMSS');
for v=vl
    for u=ul
        P=H(u,:)'*H(v,:);
        P=kron(P,ones_samp_dz);
        P=pad2centerx2(P,Ns);
        for k=kl
            Pk=P*exp(1j*pi*k/2);
            Ek=Pk+exp(-1j*phi);
            Ek=system4filter(Ek,lp4f);
            Ek_sum=sum(sum(Ek.*f_org));
            Ik_sum=abs(Ek_sum)^2;
            mdata(Cnum,k+1)=Ik_sum;
        end
        fprintf('Current basis pattern No. is %d\n',Cnum);
        Cnum=Cnum+1;
    end
end
% end time
timend=datestr(now,'yyyymmddTHHMMSS');
%%
% recover image
mdata_re=mdata(:,1)-mdata(:,3);
mdata_im=mdata(:,4)-mdata(:,2);

mdata_re=reshape(mdata_re,N,N);
mdata_im=reshape(mdata_im,N,N);

F_rec=mdata_re+1j*mdata_im;
F_rec=F_rec/(2*sqrt(abs(F_rec(1,1))));
f_rec=(H*F_rec*H)/N^2;

% save data
% filename=[timbeg,'_',timend,'_N',num2str(N),'_Ideal','.mat'];
% save(filename,'mdata_re','mdata_im','f_rec');

% show recove image
f_rec_re=real(f_rec);
f_rec_im=imag(f_rec);
f_rec_abs=abs(f_rec);
f_rec_ang=angle(f_rec);

figure;
subplot(2,2,1),imshow(f_rec_re,[]),title('Real part');
subplot(2,2,2),imshow(f_rec_im,[]),title('Imag part');
subplot(2,2,3),imshow(f_rec_abs,[]),title('Amplitude');
subplot(2,2,4),imshow(f_rec_ang,[]),title('Phase');
