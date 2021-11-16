close all;
clear, clc;

%%
% He-Ne laser wavelength is 632.8e-6 mm
lambda=632.8e-6;

% the focal length of the front lens of the 4f system is 300 mm
focal_lens=300;

% the effective aperture diameter in our experiments
dia_eff=40*1;

% the cutoff frequency of the 4f system
freq_cut=dia_eff/(2*lambda*focal_lens);

% the LCoS pixel pitch is 8e-3 mm
del_lcos = 8e-3;

% set the sampling points of each LCoS pixel pitch
samp=16;

% the numerical calculation of sampling interval (mm)
del_samp=del_lcos/samp;

%%
% set Hadamard matrix order
N=8;

% generate Walsh-Hadamard matrix
H=N*fwht(eye(N));

% set frequency coordinate u,v
% the real frequency is u-1, vl-1
u=N/2;
v=N;

%%
% set digital zoom
digzoom=1;

% sampling point
Ns=N*samp*digzoom;

% the frequency interval of the discrete Fourier transform
del_f=1/(del_samp*Ns*2);

% the dimensionless cutoff frequency
Dc=freq_cut/del_f;

%%
% one pixel of basis pattern
ones_samp_dz=ones(samp*digzoom);

% ideal low pass filter of the 4f system
lp4f=lpfilter('ideal',Ns*2,Ns*2,Dc);

%%
% compute P_{uv}
P=H(u,:)'*H(v,:);

% generate the basis pattern
Porg=kron(P,ones_samp_dz);

% padd basis pattern with 0 to 2*Ns 2*Ns
[Plcos,ml,nl]=pad2center(Porg,2*Ns,2*Ns);

%%
% calculate the spectrum of the basis pattern
Plcos_spect=fftshift(fft2(ifftshift(Plcos)));
Plcos_spect_amp=mat2gray(abs(Plcos_spect));

% show the spectrum of the Pattern on LCoS and the lowpass filter
spect_show=fftshift(lp4f)+Plcos_spect_amp;
spect_show=spect_show(ml,nl);

%%
% pattern image on the object
Pimage=system4filter(Plcos,lp4f);
Pimage=Pimage(ml,nl);

%%
figure('Color',[1 1 1],...
       'OuterPosition',[50 50 1050 450],...
       'MenuBar','figure',...
       'Toolbar','auto');
subplot(1,3,1),imshow(Porg,[]),title("Original Pattern");
axis on,xticks(zeros(1,0)),yticks(zeros(1,0));

subplot(1,3,2),imshow(spect_show,[]),title("Spectrum and filter");
axis on,xticks(zeros(1,0)),yticks(zeros(1,0));

subplot(1,3,3),imshow(Pimage,[]),title("Pattern image on object");
axis on,xticks(zeros(1,0)),yticks(zeros(1,0));



