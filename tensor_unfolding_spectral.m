%function [J1,J2,T_uf,tt]=tensor_unfolding_spectral(T,k1,k2)

% T is the input tensor of size n1 x n2 x m
% |J_1|=k1 and |J_2|=k2

% T_uf: unfolded tensor
% J1: subspace row index set
% J2: subspace column index set

% Ref: Tensor Biclustering
% By Soheil Feizi, Hamid Javadi and David Tse
% NIPS 2017

%**************************************
function [J1,J2,T_uf]=tensor_unfolding_spectral(T,k1,k2)

[n1,n2,m]=size(T);
T_uf=zeros(m,n1*n2);
for j1=1:n1
    for j2=1:n2
        T_uf(:,(j1-1)*n2+j2)=T(j1,j2,:);
    end
end
[~,~,x]=svds(T_uf,1);
[~,I_x]=sort(abs(x),'descend');
J12=I_x(1:k1*k2);

A=zeros(n1,n2);
for i=1:k1*k2
    index=J12(i);
    
    if mod(index,n2)~=0
        j11=ceil(index/n2);
    else
        j11=index/n2;
    end
    
    j22=index-n2*(j11-1);
    
    A(j11,j22)=1;
end

%******************
% Selecting k1 rows and k2 columns of A with the most number of 1's
[~,I_c]=sort(sum(A),'descend');
J2=I_c(1:k2);

[~,I_r]=sort(sum(A'),'descend');
J1=I_r(1:k1);



