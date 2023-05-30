%��̬����ʵ����
%���˻���ʵ�ʷ��й�������̬�ǻ᲻�ϸı䣬���Է��������ʹ���˻�����̬�ǣ����ٶ��������
%��ÿ��ѭ���� 4 ά���� u1��u2��u3��u4�����ֵ

%�����ǡ��������ٶȡ�����ǡ�������ٶȡ�ƫ���ǡ�ƫ�����ٶ�
%״̬����X = [x, vx, y, vy, z, vz]
%��������U = [u1, u2, u3, u4]        u2,u3,u4:���˻�������ϵ{B}�������ϵ������ط���[�����й�ʽ(2-22)(2-27)]

%��̬�ֲ����������ͨ��������ϵͳ��Ͳ�������̬����

close all;
clear all;

%��ϵ��
L= 0.3875;      %���˻����ĵ����ת��ľ��� ��λ(m) 
Ix = 0.05887;   %�ƻ�������ϵ�������ת������ ��λ(kg��m^2) 
Iy = 0.05887;
Iz = 0.13151;
g = 9.81;       %�������ٶ� ��λ(N/kg)

%����ѧ���̵ĳ�ϵ��
a1 = -(Iy - Iz)/Ix;
a2 = -(Iz - Ix)/Iy;
a3 = -(Ix - Iy)/Iz;  
b1 = L/Ix;
b2 = L/Iy;
b3 = 1/Iz;

Ts = 0.1;               %����ʱ��
t = 5;                  %����ʱ��
len = fix(t/Ts);        %���沽�� 50
n = 6;                  %״̬ά��
w = 0.1;                %���̱�׼�� ״̬ת�Ʒ��̵�w                                     �⼸������������
v = 0.5;                %������׼�� �۲ⷽ�̵�v
Q = w^2*eye(n);         %���̷���
R = v^2;                %����ֵ�ķ���

h=@(x)[x(2);x(4);x(6)];   %���ⷽ�� ���ٶ�ֵ���Բ��                              h�Ǹ�������
s=[1;2;3;3;2;1];          %��ʵ��ʼ״̬
x=s+w*randn(6,1);         %��ʼ��״̬���Ѿ����Ŷ��ˣ�                                        [0.929;1.991;3.020;2.943;1.946;1.064]
P = eye(6);               %��ʼ��Э������� eye���ص��ǵ�λ����
xV = zeros(6,len);        %EKF����ֵ zeros����һ�� 6��len ��ȫ�����
sV = zeros(6,len);        %��ʵֵ
zV = zeros(3,len);        %����ֵ

for k=1:len            %len = 50
  %�����ֵ������
  u1 = 0.1*randn(1,1);                                                          %û���õ����
  u2 = 0.1*randn(1,1); %randn��̬�ֲ��������
  u3 = 0.1*randn(1,1);
  u4 = 0.1*randn(1,1);
  
  z = h(s) + v*randn;  %h(s)����s�����2,4,6��Ԫ�أ���Ϊ���ٶȿ��Բ����õ�   v*randn��ʾ�������Ǹ��������ⲻ׼          2.7 3.7 1.7           
  sV(:,k)= s;          %ʵ��״̬
  zV(:,k) = z;         %״̬����ֵ  ʵ�ʽ��ٶ�Ȼ������������
  
  %״̬����                                                                                     ����ѧ �˶�ѧ��
  f=@(x)[x(1)+Ts*x(2);
           (a1*x(4)*x(6) +b1*u2)*Ts+x(2);                                       % a1 = -(Iy - Iz)/Ix;  b1 = L/Ix;
           x(3)+Ts*x(4);
           (a2*x(2)*x(6) +b2*u3)*Ts+x(4);                                           % a2 = -(Iz - Ix)/Iy;  b2 = L/Iy;
           x(5)+Ts*x(6);
           (a3*x(2)*x(4) +b3*u4)*Ts+x(6);];                                     % a3 = -(Ix - Iy)/Iz;   b3 = 1/Iz;
  
  %1Ԥ�⡢һ��Ԥ�⣬ͬʱ����f��������x����ſɱȾ���A 
  [x1,A]=jaccsd(f,x);   %x1��Ԥ�⹫ʽ1
  
  %2Ԥ�⡢���̷���Ԥ��
  P=A*P*A'+Q;           %Ԥ�⹫ʽ2 
  
  %״̬Ԥ�⣬ͬʱ����h���ſɱȾ���H
  [z1,H]=jaccsd(h,x1);  %z1������3*1�׾���   z1���м����z1=h(x,0),���Ը���2,Ҳ�����ⷽ���е�h(x)
  
  %1���¡����㿨��������
  K=P*H'/(H*P*H'+R);    %word������ʽ1
  
  %2���¡�״̬EKF����ֵ
  x=x1+K*(z-z1);        %������ʽ2
  
  %3���¡�Э�������
  P=P-K*H*P;            %������ʽ3 P��Ϊ����һ����׼�� 6*6
  
  xV(:,k) = x;          %ÿһ��ѭ��xV��һ��
  
  %������ʵ״̬
  s = f(s) + w*randn(6,1);  %[�����ǡ��������ٶȡ�����ǡ�������ٶȡ�ƫ���ǡ�ƫ�����ٶ�]��һ����̬�ֲ�������
end

%�����ǡ�����ǡ�ƫ���Ƕ�ֵ
for k=1:2:5                           %��1��5��ÿ������2
  figure(); hold on; 
  plot(sV(k,:),'-.','linewidth',1);   %������ʵֵ ����
  plot(xV(k,:),'linewidth',1)         %�������Ź���ֵ ����
  plot(abs(sV(k,:)-xV(k,:)),':','linewidth',1);     %�������ֵ ����
  legend('��ʵ״̬', 'EKF���Ź��ƹ���ֵ', '���ֵ');
end

%�������ٶȡ�������ٶȡ�ƫ�����ٶ�
for k=2:2:6
  figure(); hold on; 
  plot(sV(k,:),'-.','linewidth',1);   %������ʵֵ ����
  plot(xV(k,:),'linewidth',1)         %�������Ź���ֵ ����
  plot(zV(k/2,:),':','linewidth',1);  %����״̬����ֵ ����
  plot(abs(sV(k,:)-xV(k,:)), '--','linewidth',1);     %�������ֵ ����
  legend('��ʵ״̬', 'EKF���Ź��ƹ���ֵ', '״̬����ֵ', '���ֵ');
end
