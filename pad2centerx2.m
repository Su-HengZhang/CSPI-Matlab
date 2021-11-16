function fp=pad2centerx2(f)
%PAD2CENTERX2 pad around matrix with 0 to 2x
%    fp=pad2centerx2(f) pad around f with 0 to 2 times its size

[M,~]=size(f);

Mp=2*M;
fp=zeros(Mp);

Mp_c=M+1;
ml=(0:M-1)-floor(M/2);


ml_c=ml+Mp_c;
fp(ml_c,ml_c)=f;
