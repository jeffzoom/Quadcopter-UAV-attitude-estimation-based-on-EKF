function [z,A]=jaccsd(fun,x)
% JACCSD Jacobian through complex step differentiation
% [z J] = jaccsd(f,x)
% z = f(x)
% J = f'(x)
%
z=fun(x);
n=numel(x); % 数组\x 中的元素数目 n  n=6, m=6
m=numel(z);
A=zeros(m,n); % 6*6阶
h=n*eps; % 6 * 2.2204e-16     % eps 返回从 1.0 到下一个较大双精度数的距离
for k=1:n
    x1=x;
    x1(k)=x1(k)+h*1i;   % 1i 返回基本虚数单位
    A(:,k)=imag(fun(x1))/h;  % Y = imag(Z) 返回数组 Z 中每个元素的虚部
end

