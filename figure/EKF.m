%״̬����X = [x, vx, y, vy, z, vz]
%��������U = [u1, u2, u3, u4]

close all;
clear all;

%��ϵ��
L= 0.3875;      %��λ(m)
Ix = 0.05887;   %��λ(kg��m^2)
Iy = 0.05887;
Iz = 0.13151;
g = 9.81;       %��λ(N/kg)

%����ѧ���̵ĳ�ϵ��
a1 = -(Iy - Iz)/Ix;
a2 = -(Iz - Ix)/Iy;
a3 = -(Ix - Iy)/Iz;  
b1 = L/Ix;
b2 = L/Iy;
b3 = 1/Iz;

Ts = 0.1;               %����ʱ��
t = 5;                  %����ʱ��
len = fix(t/Ts);        %���沽��
n = 6;                  %״̬ά��
w = 0.1;                %���̱�׼��
v = 0.5;                %������׼��
Q = w^2*eye(n);         %���̷���
R = v^2;                %����ֵ�ķ���

h=@(x)[x(2);x(4);x(6)];         %��������
s=[1;2;3;3;2;1];                %��ʼ״̬
x=s+w*randn(6,1);               %��ʼ��״̬
P = eye(6);                     %��ʼ��Э�������
xV = zeros(6,len);              %EKF����ֵ
sV = zeros(6,len);          	%��ʵֵ
zV = zeros(3,len);          	%����ֵ

for k=1:len
  %�����ֵ������
  u2 = 0.1*randn(1,1);
  u3 = 0.1*randn(1,1);
  u4 = 0.1*randn(1,1);
  
  z = h(s) + v*randn;                     
  sV(:,k)= s;                   %ʵ��״̬
  zV(:,k) = z;              	%״̬����ֵ
  
  %״̬����
  f=@(x)[x(1)+Ts*x(2);
           (a1*x(4)*x(6) +b1*u2)*Ts+x(2);
           x(3)+Ts*x(4);
           (a2*x(2)*x(6) +b2*u3)*Ts+x(4);
           x(5)+Ts*x(6);
           (a3*x(2)*x(4) +b3*u4)*Ts+x(6);];  
  
  %һ��Ԥ�⣬ͬʱ����f���ſɱȾ���A
  [x1,A]=jaccsd(f,x); 
  
  %���̷���Ԥ��
  P=A*P*A'+Q;         
  
  %״̬Ԥ�⣬ͬʱ����h���ſɱȾ���H
  [z1,H]=jaccsd(h,x1); 
  
  %���㿨��������
  K=P*H'/(H*P*H'+R); 
  
  %״̬EKF����ֵ
  x=x1+K*(z-z1);        
  
  %Э�������
  P=P-K*H*P;          
  
  xV(:,k) = x;          
  
  %����״̬
  s = f(s) + w*randn(6,1);  
end

%�����ǡ���ת�ǡ�ƫ���Ƕ�ֵ
for k=1:2:5
  figure(); hold on; 
  plot(sV(k,:),'-.','linewidth',1);   %������ʵֵ
  plot(xV(k,:),'linewidth',1)         %�������Ź���ֵ
  plot(abs(sV(k,:)-xV(k,:)),':','linewidth',1);     %�������ֵ
  legend('��ʵ״̬', 'EKF���Ź��ƹ���ֵ', '���ֵ');
end

%�������ٶȡ���ת���ٶȡ�ƫ�����ٶȶ�ֵ
for k=2:2:6
  figure(); hold on; 
  plot(sV(k,:),'-.','linewidth',1);   %������ʵֵ
  plot(xV(k,:),'linewidth',1)         %�������Ź���ֵ
  plot(zV(k/2,:),':','linewidth',1);  %����״̬����ֵ
  plot(abs(sV(k,:)-xV(k,:)), '--','linewidth',1);     %�������ֵ
  legend('��ʵ״̬', 'EKF���Ź��ƹ���ֵ', '״̬����ֵ', '���ֵ');
end

