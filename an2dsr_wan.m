function [str,dip,rake]=an2dsr_wan(A,N)
% ���ݻ���ʸ��A�ͽ��淨��N�õ��ϲ��������Ǻͻ�����
if (N(3)== -1.0)    %�ϲ���Ϊˮƽ
  str= atan2(A(2),A(1));  %��������Ϊ����
dip = 0.0;
else
  str = atan2(-N(1),N(2)); %�ϲ���������ʱ��90�ȷ����뱱��ļн�
if (N(3)==0.0) 
dip = 0.5*pi;
elseif (abs(sin(str))>= 0.1)    %Ϊ��ֹ����С������
    dip = atan2(-N(1)/sin(str),-N(3));  %���ݶϲ�������ΪN=[-sin(str)*sin(dip), cos(str)*sin(dip),-cos(dip)];  
else
    dip = atan2(N(2)/cos(str),-N(3));  %���ݶϲ�������ΪN=[-sin(str)*sin(dip), cos(str)*sin(dip), -cos(dip)];
end
end
a1 = A(1)*cos(str) + A(2)*sin(str);  
%���ݻ��������ڱ���Ͷ����ͶӰΪ��cos(rake)*cos(str)+sin(rake)*cos(dip)*sin(str) cos(rake)*sin(str)-sin(rake)*cos(dip)*cos(str)��
%���a1Ϊcos(rake)
if (abs(a1)<0.0001) a1 = 0.0; end
if (A(3)~= 0.0) 
if (dip~= 0.0) 
    rake = atan2(-A(3)/sin(dip),a1);   %���������ڴ�ֱ�����ͶӰΪ-sin(rake)*sin(dip),���-A(3)/sin(dip)Ϊsin(rake)    
else
    rake = atan2(-1000000.0*A(3),a1);  %��ʱsin(dip)��С��Ϊ��ֹ����С���������������ֱ��
end
else%��A(3)Ϊ��ʱ,���ؿ�����ǵ�Ӱ��
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
str=rad2deg(str);dip=rad2deg(dip);rake=rad2deg(rake);   %���õ��ĽǶ�ת��Ϊ�Զ�Ϊ��λ
return
