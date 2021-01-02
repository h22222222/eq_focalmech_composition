function [str,dip,rake]=an2dsr_wan(A,N)
% 根据滑动矢量A和节面法向N得到断层的走向、倾角和滑动角
if (N(3)== -1.0)    %断层面为水平
  str= atan2(A(2),A(1));  %滑动方向为走向
dip = 0.0;
else
  str = atan2(-N(1),N(2)); %断层面倾向逆时针90度方向与北向的夹角
if (N(3)==0.0) 
dip = 0.5*pi;
elseif (abs(sin(str))>= 0.1)    %为防止被很小的数除
    dip = atan2(-N(1)/sin(str),-N(3));  %根据断层面倾向为N=[-sin(str)*sin(dip), cos(str)*sin(dip),-cos(dip)];  
else
    dip = atan2(N(2)/cos(str),-N(3));  %根据断层面倾向为N=[-sin(str)*sin(dip), cos(str)*sin(dip), -cos(dip)];
end
end
a1 = A(1)*cos(str) + A(2)*sin(str);  
%根据滑动方向在北向和东向的投影为【cos(rake)*cos(str)+sin(rake)*cos(dip)*sin(str) cos(rake)*sin(str)-sin(rake)*cos(dip)*cos(str)】
%因此a1为cos(rake)
if (abs(a1)<0.0001) a1 = 0.0; end
if (A(3)~= 0.0) 
if (dip~= 0.0) 
    rake = atan2(-A(3)/sin(dip),a1);   %滑动方向在垂直方向的投影为-sin(rake)*sin(dip),因此-A(3)/sin(dip)为sin(rake)    
else
    rake = atan2(-1000000.0*A(3),a1);  %此时sin(dip)很小，为防止被很小的数除，采用这种表达
end
else%在A(3)为零时,不必考虑倾角的影响
if(a1>1)  a1=1.;end
if(a1<-1) a1=-1.;end
rake = acos(a1);
end
if (dip<0.0) 
dip = dip+pi;
rake = pi-rake;
if (rake>pi) rake=rake- 2*pi;end
end
if(dip>0.5*pi) 
dip=pi-dip;
str=str+pi;
rake=-rake;
if (str>=2*pi) str = str - 2*pi;end
end
if (str<0.0) str=str+2.0*pi;end
str=rad2deg(str);dip=rad2deg(dip);rake=rad2deg(rake);   %将得到的角度转换为以度为单位
return
