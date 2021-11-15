function fp=pad2centerx2(f,M)

Mp=2*M;
fp=zeros(Mp);

Mp_c=M+1;
ml=(0:M-1)-floor(M/2);


ml_c=ml+Mp_c;
fp(ml_c,ml_c)=f;