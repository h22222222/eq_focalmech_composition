% ���������Ӽ���ͼ
% HEYUQING
% 2020/12/28
%% �������ؼ�����
%1. north-dipping thrust
meand1=0.06; %ƽ��������
len1=50;
wid1=26;
strike1=276; %����Ǧ�
dip1=10.2; %��Ǧ�
rake1=109.84; %�����Ǧ�
miu=30*10^9; 
A1=len1*wid1*1000000;%ƽ����
m1=A1*meand1;
%����seismic moment
mm1=miu*(m1);
%����moment magnitude ���ּ��㷽ʽ
mw1=(2/3)*log10(mm1)-6.003;
mw2=(2/3)*log10(mm1*10^7)-10.7;

%2. strike-slip
meand2=0.06; %ƽ��������
len2=18;
wid2=20;
strike2=170; %����Ǧ�
dip2=88; %��Ǧ�
rake2=35; %�����Ǧ�
miu=30*10^9; 
A2=len2*wid2*1000000;%ƽ����
m2=A2*meand2;
%����seismic moment
mm2=miu*(m2);
%����moment magnitude
mw1=(2/3)*log10(mm2)-6.003;
mw2=(2/3)*log10(mm2*10^7)-10.7;

%3. south-dipping
meand3=0.07; %ƽ��������
len3=50;
wid3=26;
strike3=89; %����Ǧ�
dip3=84; %��Ǧ�
rake3=94.46; %�����Ǧ�
miu=30*10^9; 
A3=len2*wid2*1000000;%ƽ����
m3=A3*meand3;
%����seismic moment
mm3=miu*(m3);
%����moment magnitude
mw1=(2/3)*log10(mm3)-6.003;
mw2=(2/3)*log10(mm3*10^7)-10.7;

% ���ݾ�����
[M1]=Moment_Tensor_forward(strike1,dip1,rake1,mm1)
[M2]=Moment_Tensor_forward(strike2,dip2,rake2,mm2)
[M3]=Moment_Tensor_forward(strike3,dip3,rake3,mm3)
% ���Ե��ӵõ�������֮���ٷ��ݶϲ���
% M=M1+M2;
M=M1+M2+M3;
[mechanism1,mechanism2]=Moment_Tensor_invert(M)
%% ������Դ������
a=2;%���Ƶ�Schmidt���Ĵ�Բ�뾶
n=500;%��500������ƶϲ�����Wulff���ϵ�ͶӰ
x0=0;y0=0;  %����ԭ��

%���Ӻ� str,dip,rake,siz,n,clr,lat,lon,iptb,insew,fillcode
str=mechanism1(1,1);dip=mechanism1(1,2); rake=mechanism1(1,3); %�ϲ�����������Ǻͻ�����
figure;
subplot(321)
beachball_ea(str,dip,rake,a,n,'k',0,0,0,0,1);   %���û�ͼ����
title('this study','fontsize',25)
axis image  
axis off    %����ʾ������

%����
subplot(323)
beachball_ea(strike1,dip1,rake1,a,n,'r',0,0,0,0,1);   %���û�ͼ����
title('north-dipping','fontsize',25)
axis image  
axis off    

%�߻�
subplot(325)
beachball_ea(strike2,dip2,rake2,a,n,'r',0,0,0,0,1);   %���û�ͼ����
title('strike-slip','fontsize',25) 
axis image   
axis off   

% subplot(323)
% beachball_ea(strike3,dip3,rake3,a,n,'r',0,0,1,1,1);   %���û�ͼ����
% axis equal  
% axis off  


% 196?/37?/30? gcmt
str=196;dip=37; rake=30; %�ϲ�����������Ǻͻ�����
subplot(322)
beachball_ea(str,dip,rake,a,n,'k',0,0,0,0,1);   %���û�ͼ����
title('gCMT','fontsize',25) 
axis image  
axis off    %����ʾ������

% body wave262?/9?/105?
str=262;dip=9; rake=105; %�ϲ�����������Ǻͻ�����
subplot(324)
beachball_ea(str,dip,rake,a,n,'k',0,0,0,0,1);   %���û�ͼ����
title('body wave','fontsize',25) 
axis image   
axis off    %����ʾ������

%W-phase221?/20?/72?
str=221;dip=20; rake=72; %�ϲ�����������Ǻͻ�����
subplot(326)
beachball_ea(str,dip,rake,a,n,'k',0,0,0,0,1);   %���û�ͼ����
title('W-phase','fontsize',25) 
axis image   
axis off    %����ʾ������

set(gcf,'Units','Inches');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3)+5, pos(4)+5])
filename = './beachball_com.pdf'; % �趨�����ļ���
print(gcf,filename,'-dpdf','-r0')
close(gcf)
