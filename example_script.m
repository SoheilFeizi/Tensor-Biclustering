% An example script
% Ref: Tensor Biclustering
% By Soheil Feizi, Hamid Javadi and David Tse
% NIPS 2017


clc
close all
clear all

%*********************************
% generating tensor data

% Tensor size
n1=200;
n2=200;
m=50;

% cluster size
k1=40;
k2=40;

%noise model I or II (see the paper for definition)
control_noise=2;

% signal strength
sigma1=100;

v=randn(1,m);
v=v/norm(v);

J1_true=1:k1;
J2_true=k2+1:2*k2;

% generating signal tensor
X=zeros(n1,n2,m);

for i=J1_true
    for j=J2_true
        X(i,j,:)=sigma1/sqrt(k1)/sqrt(k2)*v;
    end
end

% generating the noise tensor
Z=randn(n1,n2,m);
if control_noise==2
    if sigma1^2>=m*k1*k2
        s_z=sqrt(1-sigma1^2/(m*k1*k2));
    else
        s_z=0;
    end
    
    Z(J1_true,J2_true,:)=Z(J1_true,J2_true,:)*s_z;
end

T=X+Z;
%*********************************
% Applying SLT methods
disp('Tensor Folding+Spectral')

[J1_TF,J2_TF,~,~]=tensor_folding_spectral(T,k1,k2);

r1=length(intersect(J1_TF,J1_true))/k1;
r2=length(intersect(J2_TF,J2_true))/k2;
recovery_rate=(r1+r2)/2

disp('Tensor Unfolding+Spectral')
[J1_TUF,J2_TUF]=tensor_unfolding_spectral(T,k1,k2);
r1=length(intersect(J1_TUF,J1_true))/k1;
r2=length(intersect(J2_TUF,J2_true))/k2;
recovery_rate=(r1+r2)/2

disp('Thresholding Sum of Squared Fiber Lengths')
[J1_SL,J2_SL]=th_sum_fibers(T,k1,k2);
r1=length(intersect(J1_SL,J1_true))/k1;
r2=length(intersect(J2_SL,J2_true))/k2;
recovery_rate=(r1+r2)/2

disp('Thresholding Ind. Fiber Lengths')
[J1_IL,J2_IL]=th_ind_fibers(T,k1,k2);
r1=length(intersect(J1_IL,J1_true))/k1;
r2=length(intersect(J2_IL,J2_true))/k2;
recovery_rate=(r1+r2)/2

