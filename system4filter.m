function g=system4filter(f,H)

fc=ifftshift(f);

F=fft2(fc);
G=F.*H;
gc=ifft2(G);

g=fftshift(gc);



