function [H,D]=lpfilter(type,M,N,Dc,n)
%LPFILTER Computes frequency domain lowpass filters.
%   H=LPFILTER(TYPE,M,N,Dc,n) creates the transfer function
%   of a lowpass filter, H, of the specified TYPE and size
%   (M-by-N).

%Computing the required distances
[U,V]=dftuv(M,N);

%Compute the distances D(U,V)
D=sqrt(U.^2+V.^2);

%Begin filter computations
switch type
    case 'ideal'
        H=double(D<=Dc);
    case 'btw'
        if nargin==4
            n=1;
        end
        H=1./(1+(D./Dc).^(2*n));
    case 'gaussian'
        H=exp(-(D.^2)./(2*(Dc^2)));
    otherwise
        error('Unknown filter type!')
end
