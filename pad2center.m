function [fp,ml_c,nl_c]=pad2center(f,Mp,Np)

[M,N]=size(f);

if nargin<2
    Mp=2*M;
    Np=2*N;
end

if Mp<M
    Mp=M;
end

if Np<N
   Np=N;
end


ml=(0:M-1)-floor(M/2);
nl=(0:N-1)-floor(N/2);


fp=zeros(Mp,Np);

Mp_c=floor(Mp/2)+1;
Np_c=floor(Np/2)+1;

ml_c=ml+Mp_c;
nl_c=nl+Np_c;

fp(ml_c,nl_c)=f;
