function [z,A]=jaccsd(fun,x)
% JACCSD Jacobian through complex step differentiation
% [z J] = jaccsd(f,x)
% z = f(x)
% J = f'(x)
%
z=fun(x);
n=numel(x); % ����\x �е�Ԫ����Ŀ n  n=6, m=6
m=numel(z);
A=zeros(m,n); % 6*6��
h=n*eps; % 6 * 2.2204e-16     % eps ���ش� 1.0 ����һ���ϴ�˫�������ľ���
for k=1:n
    x1=x;
    x1(k)=x1(k)+h*1i;   % 1i ���ػ���������λ
    A(:,k)=imag(fun(x1))/h;  % Y = imag(Z) �������� Z ��ÿ��Ԫ�ص��鲿
end

