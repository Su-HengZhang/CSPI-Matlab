function g=system4filter(f,H)
%SYSTEM4FILTER frequency domain filtering with 4f system
%    g=system4filter(f,H)  filtering f with H
%    H is the same size of f

fc=ifftshift(f);

F=fft2(fc);
G=F.*H;
gc=ifft2(G);

g=fftshift(gc);
