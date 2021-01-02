function beachball_ea(str,dip,rake,siz,n,clr,lat,lon,iptb,insew,fillcode)
%..........................................................
%  beachball_ea.m - ���õȻ���Schmidt��ͶӰ������Դ���ƽ�ĳ���
%
%  ����: str - ����, dip - ���, rake - ������,��λ��Ϊ��,
%        ����Ļ����Ǵ���180������ת��Ϊ�Ƕ�Ϊ��
%        siz - ����ͶӰ�Ĵ�С
%         n   - ����ͶӰ�ķֱ���,��ΧΪ5-50.
%         clr - ���Ͳ������õ���ɫ
%         lat - �¼���γ�ȣ�y����
%         lon - �¼��ľ��ȣ�x����
%         iptb-�Ƿ����PTB�ᣬ���δ���㣬�����PTB��
%         insew-�Ƿ������ߵ�NSEW�����־�����δ���㣬��������ֱ�־
%         fillcode-�Ƿ���������������Ϊ1�������Ϊ��
%..........................................................
if n<5,n=5;elseif n>50,n=50;end,d2r=pi/180;pi2=pi*2;
str=str*d2r;dip=dip*d2r;rake=rake*d2r;
if(iptb)
    [Ptrpl,Ttrpl,Btrpl,str2,dip2,rake2]=dsrin(rad2deg(str),rad2deg(dip),rad2deg(rake));
else
A=[cos(rake)*cos(str)+sin(rake)*cos(dip)*sin(str), cos(rake)*sin(str)-sin(rake)*cos(dip)*cos(str), -sin(rake)*sin(dip)];   %A������ʸ�����ĵ�λ����ʸ��
N=[-sin(str)*sin(dip), cos(str)*sin(dip), -cos(dip)];   %N�����淨�ߣ��ĵ�λ����ʸ��
[str2,dip2,rake2]=an2dsr_wan(N,A); %�õ�����һ�������������Ǻͻ�����
end
%��һ���ϲ���
rak=0:-pi/n:-pi;
cosih=-sin(dip)*sin(rak);    %����������z��ķ�������,����ǰ��Ĺ�ʽ����
ih=acos(cosih);    %ֻȡihΪ��ǵ����
cosdet=sqrt(1-cosih.^2);    %�õ�����������ˮƽ��нǵķ������� 
fai=acos(cos(rak)./cosdet);    %��������ֱ�������εĹ�ʽ�õ���ˮƽ��Բ�ڵ�������ֱ���ļн�
str1=str+fai;     %������ǵĻ���������fai
xs1=siz*sqrt(2)*sin(ih/2).*sin(str1);    
ys1=siz*sqrt(2)*sin(ih/2).*cos(str1);   %SchmidtͶӰ������

%�ڶ����ϲ���
str2=deg2rad(str2);dip2=deg2rad(dip2);
cosih=-sin(dip2)*sin(rak);    %����������z��ķ�������,����ǰ��Ĺ�ʽ����
ih=acos(cosih);    %ֻȡihΪ��ǵ����
cosdet=sqrt(1-cosih.^2);    %�õ�����������ˮƽ��нǵķ������� 
fai=acos(cos(rak)./cosdet);    %��������ֱ�������εĹ�ʽ�õ���ˮƽ��Բ�ڵ�������ֱ���ļн�
str21=str2+fai;     %������ǵĻ���������fai
xs2=siz*sqrt(2)*sin(ih/2).*sin(str21);    
ys2=siz*sqrt(2)*sin(ih/2).*cos(str21);   %SchmidtͶӰ������
str1=str+pi;if str1 > pi2,str1=str1-pi2;end%�ϲ�������ķ�����
d=str2;   %�ڶ������������
d1=d+pi;  %�ڶ�����������ķ�����
if str1-d>pi,d=d-pi2;elseif str1-d>=pi,str1=str1-pi2;end
if d1-str>pi,d1=d1-pi2;elseif d1-str>=pi,str=str-pi2;end
st1=str1:(d-str1)/n:d;   %�����������ӵ�С�����Ե�һ����������ķ����򵽵ڶ������������
st2=d1:(str-d1)/n:str;   %�����������ӵ�С�����Եڶ�����������ķ����򵽵�һ�����������
p=[xs1,sin(st1)*siz,xs2,sin(st2)*siz]+lon;
q=[ys1,cos(st1)*siz,ys2,cos(st2)*siz]+lat;
% ���Ƶ����ͶӰ
n=n+n;x=-siz:2*siz/n:siz;y=sqrt(siz*siz-x.^2);  %���ƴ�Բ���õ���������
if(fillcode)
if(rake>0)  %�����һ������Ļ�����Ϊ����������������������Ӧ��С������Ϊ������
fill([x,x(n+1:-1:1)]+lon,[y,-y(n+1:-1:1)]+lat,'w',p,q,clr)
else%�����һ������Ļ�����Ϊ�����������µ����ϲ��������Ӧ��С������Ϊѹ���������෴������Ϊ�����������෴������������
fill([x,x(n+1:-1:1)]+lon,[y,-y(n+1:-1:1)]+lat,clr,p,q,'w')
end
else
plot(siz*cos(0:2*pi/n:2*pi),siz*sin(0:2*pi/n:2*pi),'k');   %���ƴ�Բ
hold on
plot(xs1,ys1,clr,xs2,ys2,clr); %���Ƶ�һ������
end
if(insew)
hold on
% line([0,0],[siz,siz*1.1]);   %���Ʊ���
% text(0,siz*(1.1),'N')   %��ʾ����
% line([-siz,-siz*1.1],[0,0]); %��������
% text(-siz*(1.1),0,'W')   %��ʾ����
% line([siz,siz*1.1],[0,0]);  %���ƶ���
% text(siz*1.1,0,'E')   %��ʾ����
% line([0,0],[-siz,-siz*1.1]);  %��������
% text(0,-siz*1.1,'S')   %��ʾ����
end
if(iptb)
hold on
%����P��
rp = siz*sqrt(2)*sind((90-Ptrpl(2))/2);    %���ݣ�10-5-13������SchmidtͶӰ�ľ����ĵ����
xp=lon+rp*sind(Ptrpl(1)); yp=lat+rp*cosd(Ptrpl(1));
plot(xp,yp,'.')
text(xp+0.1,yp,'T');  
%����T��
rp = siz*sqrt(2)*sind((90-Ttrpl(2))/2);    %���ݣ�10-5-13������SchmidtͶӰ�ľ����ĵ����
xp=lon+rp*sind(Ttrpl(1)); yp=lat+rp*cosd(Ttrpl(1));
plot(xp,yp,'o')
text(xp+0.1,yp,'P');  
%����B��
rp = siz*sqrt(2)*sind((90-Btrpl(2))/2);    %���ݣ�10-5-13������SchmidtͶӰ�ľ����ĵ����
xp=lon+rp*sind(Btrpl(1)); yp=lat+rp*cosd(Btrpl(1));
plot(xp,yp,'+')
text(xp+0.1,yp,'B');  
end
return
