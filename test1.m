clear all;
N=200;
bsx(1)=1;
p(1)=10;
Z=randn(1,N)+25;
R = std(Z).^2;
w=randn(1,N);
Q = std(w).^2;
for t=2:N;
    x(t)=bsx(t-1);
    
    p1(t)=p(t-1)+Q;
    
    kg(t)=p1(t)/(p1(t)+R);
    
    bsx(t)=x(t)+kg(t)*(Z(t)-x(t));
    
    p(t)=(1-kg(t))*p1(t);
end
t=1:N;
plot(t,bsx,'r', t,Z,'g', t,x,'b');              % ��ɫ�����Ż��������˲����ֵ��%��ɫ�߹۲�ֵ����ɫ��Ԥ��ֵ
legend('Kalman�˲����','�۲�ֵ','Ԥ��ֵ');

