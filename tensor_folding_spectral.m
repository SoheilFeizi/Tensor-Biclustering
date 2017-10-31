%function [J1,J2,T_f1,T_f2]=tensor_folding_spectral(T,k1,k2)

% T is the input tensor of size n1 x n2 x m
% |J_1|=k1 and |J_2|=k2

% T_f1: folded tensor on rows
% T_f2: folded tensor on columns
% J1: subspace row index set
% J2: subspace column index set

% Ref: Tensor Biclustering
% By Soheil Feizi, Hamid Javadi and David Tse
% NIPS 2017

%**************************************
function [J1,J2,T_f1,T_f2]=tensor_folding_spectral(T,k1,k2)

[n1,n2,m]=size(T);

% folding rows
T_f1=zeros(n2,n2);
for j=1:n1
    Tj=zeros(n2,m);
    Tj(:,:)=T(j,:,:);
    Tj=Tj';
    T_f1=T_f1+Tj'*Tj;
end

[w_1,~]=eigs(T_f1,1);
[~,I_w1]=sort(abs(w_1),'descend');
J2=I_w1(1:k2);

% folding columns
T_f2=zeros(n1,n1);
for j=1:n2
    Tj=zeros(n1,m);
    Tj(:,:)=T(:,j,:);
    Tj=Tj';
    T_f2=T_f2+Tj'*Tj;
end

[u_1,~]=eigs(T_f2,1);
[~,I_u1]=sort(abs(u_1),'descend');
J1=I_u1(1:k1);


