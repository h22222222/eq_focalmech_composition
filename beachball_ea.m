function beachball_ea(str,dip,rake,siz,n,clr,lat,lon,iptb,insew,fillcode)
%..........................................................
%  beachball_ea.m - 采用等积（Schmidt）投影绘制震源机制解的程序
%
%  输入: str - 走向, dip - 倾角, rake - 滑动角,单位均为度,
%        这里的滑动角大于180，必须转换为角度为负
%        siz - 绘制投影的大小
%         n   - 绘制投影的分辨率,范围为5-50.
%         clr - 膨胀部分所用的颜色
%         lat - 事件的纬度，y坐标
%         lon - 事件的经度，x坐标
%         iptb-是否绘制PTB轴，如果未非零，则绘制PTB轴
%         insew-是否绘制外边的NSEW方向标志，如果未非零，则绘制这种标志
%         fillcode-是否填充拉张区，填充为1，不填充为零
%..........................................................
if n<5,n=5;elseif n>50,n=50;end,d2r=pi/180;pi2=pi*2;
str=str*d2r;dip=dip*d2r;rake=rake*d2r;
if(iptb)
    [Ptrpl,Ttrpl,Btrpl,str2,dip2,rake2]=dsrin(rad2deg(str),rad2deg(dip),rad2deg(rake));
else
A=[cos(rake)*cos(str)+sin(rake)*cos(dip)*sin(str), cos(rake)*sin(str)-sin(rake)*cos(dip)*cos(str), -sin(rake)*sin(dip)];   %A（滑动矢量）的单位方向矢量
N=[-sin(str)*sin(dip), cos(str)*sin(dip), -cos(dip)];   %N（节面法线）的单位方向矢量
[str2,dip2,rake2]=an2dsr_wan(N,A); %得到另外一个节面的走向、倾角和滑动角
end
%第一个断层面
rak=0:-pi/n:-pi;
cosih=-sin(dip)*sin(rak);    %滑动方向与z轴的方向余弦,按照前面的公式给出
ih=acos(cosih);    %只取ih为锐角的情况
cosdet=sqrt(1-cosih.^2);    %得到滑动方向与水平面夹角的方向余弦 
fai=acos(cos(rak)./cosdet);    %根据球面直角三角形的公式得到在水平大圆内的与走向直径的夹角
str1=str+fai;     %在走向角的基础上增加fai
xs1=siz*sqrt(2)*sin(ih/2).*sin(str1);    
ys1=siz*sqrt(2)*sin(ih/2).*cos(str1);   %Schmidt投影的坐标

%第二个断层面
str2=deg2rad(str2);dip2=deg2rad(dip2);
cosih=-sin(dip2)*sin(rak);    %滑动方向与z轴的方向余弦,按照前面的公式给出
ih=acos(cosih);    %只取ih为锐角的情况
cosdet=sqrt(1-cosih.^2);    %得到滑动方向与水平面夹角的方向余弦 
fai=acos(cos(rak)./cosdet);    %根据球面直角三角形的公式得到在水平大圆内的与走向直径的夹角
str21=str2+fai;     %在走向角的基础上增加fai
xs2=siz*sqrt(2)*sin(ih/2).*sin(str21);    
ys2=siz*sqrt(2)*sin(ih/2).*cos(str21);   %Schmidt投影的坐标
str1=str+pi;if str1 > pi2,str1=str1-pi2;end%断层面走向的反方向
d=str2;   %第二个节面的走向
d1=d+pi;  %第二个节面走向的反方向
if str1-d>pi,d=d-pi2;elseif str1-d>=pi,str1=str1-pi2;end
if d1-str>pi,d1=d1-pi2;elseif d1-str>=pi,str=str-pi2;end
st1=str1:(d-str1)/n:d;   %两个节面所加的小弧，自第一个节面走向的反方向到第二个节面的走向
st2=d1:(str-d1)/n:str;   %两个节面所加的小弧，自第二个节面走向的反方向到第一个节面的走向
p=[xs1,sin(st1)*siz,xs2,sin(st2)*siz]+lon;
q=[ys1,cos(st1)*siz,ys2,cos(st2)*siz]+lat;
% 绘制等面积投影
n=n+n;x=-siz:2*siz/n:siz;y=sqrt(siz*siz-x.^2);  %绘制大圆所用的坐标序列
if(fillcode)
if(rake>0)  %如果第一个节面的滑动角为正，则有向上逆冲分量，对应的小弧所加为膨胀区
fill([x,x(n+1:-1:1)]+lon,[y,-y(n+1:-1:1)]+lat,'w',p,q,clr)
else%如果第一个节面的滑动角为负，则有向下的正断层分量，对应的小弧所加为压缩区，则相反的区域为膨胀区，对相反的区域进行填充
fill([x,x(n+1:-1:1)]+lon,[y,-y(n+1:-1:1)]+lat,clr,p,q,'w')
end
else
plot(siz*cos(0:2*pi/n:2*pi),siz*sin(0:2*pi/n:2*pi),'k');   %绘制大圆
hold on
plot(xs1,ys1,clr,xs2,ys2,clr); %绘制第一个节面
end
if(insew)
hold on
% line([0,0],[siz,siz*1.1]);   %绘制北向
% text(0,siz*(1.1),'N')   %标示北向
% line([-siz,-siz*1.1],[0,0]); %绘制西向
% text(-siz*(1.1),0,'W')   %标示北向
% line([siz,siz*1.1],[0,0]);  %绘制东向
% text(siz*1.1,0,'E')   %标示东向
% line([0,0],[-siz,-siz*1.1]);  %绘制南向
% text(0,-siz*1.1,'S')   %标示南向
end
if(iptb)
hold on
%绘制P轴
rp = siz*sqrt(2)*sind((90-Ptrpl(2))/2);    %根据（10-5-13）计算Schmidt投影的距中心点距离
xp=lon+rp*sind(Ptrpl(1)); yp=lat+rp*cosd(Ptrpl(1));
plot(xp,yp,'.')
text(xp+0.1,yp,'T');  
%绘制T轴
rp = siz*sqrt(2)*sind((90-Ttrpl(2))/2);    %根据（10-5-13）计算Schmidt投影的距中心点距离
xp=lon+rp*sind(Ttrpl(1)); yp=lat+rp*cosd(Ttrpl(1));
plot(xp,yp,'o')
text(xp+0.1,yp,'P');  
%绘制B轴
rp = siz*sqrt(2)*sind((90-Btrpl(2))/2);    %根据（10-5-13）计算Schmidt投影的距中心点距离
xp=lon+rp*sind(Btrpl(1)); yp=lat+rp*cosd(Btrpl(1));
plot(xp,yp,'+')
text(xp+0.1,yp,'B');  
end
return
