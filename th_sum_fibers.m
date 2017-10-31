%function [J1,J2]=th_sum_fibers(T,k1,k2)

% T is the input tensor of size n1 x n2 x m
% |J_1|=k1 and |J_2|=k2

% J1: subspace row index set
% J2: subspace column index set

% Ref: Tensor Biclustering
% By Soheil Feizi, Hamid Javadi and David Tse
% NIPS 2017
%**************************************
function [J1,J2]=th_sum_fibers(T,k1,k2)

[n1,n2,m]=size(T);

D=zeros(n1,n2);
for i=1:n1
    for j=1:n2
        temp=zeros(1,m);
        temp(:)=T(i,j,:);
   D(i,j)=norm(temp);             
    end
end

d_c=sum(D);
d_r=sum(D');

[~,I_r]=sort(d_r,'descend');
J1=I_r(1:k1);

[~,I_c]=sort(d_c,'descend');
J2=I_c(1:k2);

