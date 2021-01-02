% 矩张量叠加及绘图
% HEYUQING
% 2020/12/28
%% 计算地震矩及矩震级
%1. north-dipping thrust
meand1=0.06; %平均滑动量
len1=50;
wid1=26;
strike1=276; %走向角φ
dip1=10.2; %倾角δ
rake1=109.84; %滑动角λ
miu=30*10^9; 
A1=len1*wid1*1000000;%平方米
m1=A1*meand1;
%计算seismic moment
mm1=miu*(m1);
%计算moment magnitude 两种计算方式
mw1=(2/3)*log10(mm1)-6.003;
mw2=(2/3)*log10(mm1*10^7)-10.7;

%2. strike-slip
meand2=0.06; %平均滑动量
len2=18;
wid2=20;
strike2=170; %走向角φ
dip2=88; %倾角δ
rake2=35; %滑动角λ
miu=30*10^9; 
A2=len2*wid2*1000000;%平方米
m2=A2*meand2;
%计算seismic moment
mm2=miu*(m2);
%计算moment magnitude
mw1=(2/3)*log10(mm2)-6.003;
mw2=(2/3)*log10(mm2*10^7)-10.7;

%3. south-dipping
meand3=0.07; %平均滑动量
len3=50;
wid3=26;
strike3=89; %走向角φ
dip3=84; %倾角δ
rake3=94.46; %滑动角λ
miu=30*10^9; 
A3=len2*wid2*1000000;%平方米
m3=A3*meand3;
%计算seismic moment
mm3=miu*(m3);
%计算moment magnitude
mw1=(2/3)*log10(mm3)-6.003;
mw2=(2/3)*log10(mm3*10^7)-10.7;

% 正演矩张量
[M1]=Moment_Tensor_forward(strike1,dip1,rake1,mm1)
[M2]=Moment_Tensor_forward(strike2,dip2,rake2,mm2)
[M3]=Moment_Tensor_forward(strike3,dip3,rake3,mm3)
% 线性叠加得到矩张量之后再反演断层面
% M=M1+M2;
M=M1+M2+M3;
[mechanism1,mechanism2]=Moment_Tensor_invert(M)
%% 绘制震源机制球
a=2;%绘制的Schmidt网的大圆半径
n=500;%用500个点绘制断层面在Wulff网上的投影
x0=0;y0=0;  %坐标原点

%叠加后 str,dip,rake,siz,n,clr,lat,lon,iptb,insew,fillcode
str=mechanism1(1,1);dip=mechanism1(1,2); rake=mechanism1(1,3); %断层面的走向和倾角和滑动角
figure;
subplot(321)
beachball_ea(str,dip,rake,a,n,'k',0,0,0,0,1);   %调用绘图程序
title('this study','fontsize',25)
axis image  
axis off    %不显示坐标轴

%北倾
subplot(323)
beachball_ea(strike1,dip1,rake1,a,n,'r',0,0,0,0,1);   %调用绘图程序
title('north-dipping','fontsize',25)
axis image  
axis off    

%走滑
subplot(325)
beachball_ea(strike2,dip2,rake2,a,n,'r',0,0,0,0,1);   %调用绘图程序
title('strike-slip','fontsize',25) 
axis image   
axis off   

% subplot(323)
% beachball_ea(strike3,dip3,rake3,a,n,'r',0,0,1,1,1);   %调用绘图程序
% axis equal  
% axis off  


% 196?/37?/30? gcmt
str=196;dip=37; rake=30; %断层面的走向和倾角和滑动角
subplot(322)
beachball_ea(str,dip,rake,a,n,'k',0,0,0,0,1);   %调用绘图程序
title('gCMT','fontsize',25) 
axis image  
axis off    %不显示坐标轴

% body wave262?/9?/105?
str=262;dip=9; rake=105; %断层面的走向和倾角和滑动角
subplot(324)
beachball_ea(str,dip,rake,a,n,'k',0,0,0,0,1);   %调用绘图程序
title('body wave','fontsize',25) 
axis image   
axis off    %不显示坐标轴

%W-phase221?/20?/72?
str=221;dip=20; rake=72; %断层面的走向和倾角和滑动角
subplot(326)
beachball_ea(str,dip,rake,a,n,'k',0,0,0,0,1);   %调用绘图程序
title('W-phase','fontsize',25) 
axis image   
axis off    %不显示坐标轴

set(gcf,'Units','Inches');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3)+5, pos(4)+5])
filename = './beachball_com.pdf'; % 设定导出文件名
print(gcf,filename,'-dpdf','-r0')
close(gcf)
