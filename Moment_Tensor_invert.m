%震源大闸蟹作业-地震矩张量反演（已知矩张量求断层几何）
%2019.10.22
%heyuqing
% clear all;
%input: 矩张量 
%output: 走滑角，倾角，滑动角
function [mechanism1,mechanism2]=Moment_Tensor_invert(M)
%% 求解特征方程
[x,y]=eig(M); %其中x的每一列值表示矩阵a的一个特征向量，这里有3个特征向量，y的对角元素值代表a矩阵的特征值
[eigval]=eig(M);
% xigema=[-1,0,0;0,-2.14238349283136e-16,0;0,0,1];
sca_M=(max(eigval(:))-min(eigval(:)))./2;
% T=[-0.250000000000000 -0.457106781186547 0.853553390593274]; %特征值为1时
% P=[0.957106781186548 -0.250000000000000 0.146446609406726];  %特征值为-1时
% B=[0.146446609406726 0.853553390593274 0.500000000000000];  %特征值为0时
% xigema=[-1.00000000000000,0,0;0,-3.54351249720646e-17,0;0,0,1.00000000000000];
T=x(:,3);
P=x(:,1);
B=x(:,2);
e1=(1/sqrt(2))*(T+P);
v1=(1/sqrt(2))*(T-P);
e2=(1/sqrt(2))*(T-P);
v2=(1/sqrt(2))*(T+P);
%检验
% [Mxx+1 Mxy Mxz]*[0.957106781186548 -0.250000000000000 0.146446609406726]'
% [Myx Myy+1 Myz]*[0.957106781186548 -0.250000000000000 0.146446609406726]'
P1=(y(1,1)+y(2,2)+y(3,3))/3;
M0=(y(3,3)-y(1,1))/2; %在这里计算出来的λ3>λ1
C=(2*y(2,2)-y(1,1)-y(3,3))/6;
%分解矩张量
ICO=P1.*[1 0 0;
       0 1 0;
       0 0 1]; %体积分量
DC=M0.*[1 0 0;
        0 0 0;
        0 0 -1]; %最佳双力偶
CLVD=C.*[-1 0 0;
         0 2 0;
         0 0 -1]; %补偿线性矢量偶极

%矩张量分解之后各部分的含量计算
ISOper=abs(P1)/abs(y(1,1))*100;
NDCper=2*abs(y(2,2))/abs(y(1,1))*100;
DCper=100-NDCper;
%% 计算TP轴的方位角、俯角
%方位角：以北方向顺时针方向旋转到该方向
tanthetaT=T(2)/T(1); %y/x
if (T(1)>0)&&(T(2)>0) %第四象限
    thetaT=360-atand(tanthetaT);
end
if (T(1)>0)&&(T(2)<0) %第一象限
    thetaT=360+atand(tanthetaT);
end
if (T(1)<0)&&(T(2)<0) %第二象限
    thetaT=180+atand(tanthetaT);
end
if (T(1)<0)&&(T(2)>0) %第三象限
    thetaT=270+atand(-tanthetaT);
end

tanthetaP=P(2)/P(1);
thetaP=atand(tanthetaP);
if (P(1)>0)&&(P(2)>0) %第四象限
    thetaP=360-atand(tanthetaP);
end
if (P(1)>0)&&(P(2)<0) %第一象限
    thetaP=360+atand(tanthetaP);  % revised 2019-11-06
end
if (P(1)<0)&&(P(2)<0) %第二象限
    thetaP=180+atand(tanthetaP);
end
if (P(1)<0)&&(P(2)>0) %第三象限
    thetaP=270+atand(-tanthetaP);
end

%计算仰角
tanfaiT=T(3)/sqrt(T(2)*T(2)+T(1)*T(1));
faiT=atand(tanfaiT);
if (T(3)<0) %z分量为负值
    faiT=180+faiT;
end

tanfaiP=P(3)/sqrt(P(2)*P(2)+P(1)*P(1));
faiP=atand(tanfaiP);
if (P(3)<0) %z分量为负值
    faiP=180+faiP;
end
disp('方位角和俯角的结果为：')
disp(thetaT);
disp(faiT);
disp(thetaP);
disp(faiP);
%% 求解走向、倾角、滑动角
% strike1=180-atand(-v1(1)/v1(2)); %走向角范围0-360
% strike2=atand(-v2(1)/v2(2));
% dip1=90-(acosd(-v1(3))-90); %倾角范围0-90
% dip2=90-(acosd(-v2(3))-90);
% rake1=180-(-atand((-e1(3)/sind(dip1))/(e1(1)*cosd(strike1)+e1(2)*sind(strike1))));
% rake2=atand((-e2(3)/sind(dip2))/(e2(1)*cosd(strike2)+e2(2)*sind(strike2)));
%倾角计算
dip1=acosd(-v1(3)); %倾角范围0-90
dip2=acosd(-e1(3));
dip=[dip1 dip2];

%走向角计算
sinstrike1=v1(1)/-sind(dip1);
cosstrike1=v1(2)/sind(dip1);
sinstrike2=v2(1)/-sind(dip2);
cosstrike2=v2(2)/sind(dip2);
% strike1=atand(-v1(1)/v1(2)); %走向角范围0-360
% strike2=atand(-e1(1)/e1(2));
cosstrike=[cosstrike1 cosstrike2];
sinstrike=[sinstrike1 sinstrike2];

for i=1:2
if (cosstrike(i)>0)&&(sinstrike(i)<0) %在第四象限
    strike(i)=360-rad2deg(acos(cosstrike(i)));
  
end
if (cosstrike(i)>0)&&(sinstrike(i)>0)  %在第一象限
    strike(i)=rad2deg(acos(cosstrike(i)));

end
if (cosstrike(i)<0)&&(sinstrike(i)>0)   %在第二象限
    strike(i)=rad2deg(acos(cosstrike(i)));
  
end
if (cosstrike(i)<0)&&(sinstrike(i)<0) %第三象限
    strike(i)=180-rad2deg(asin(sinstrike(i)));
end
end

%判断倾角是否大于90度
for i=1:2
if (dip(i)>90) && (dip(i)<180)
    dip(i)=180-dip(i);
    strike(i)=180+strike(i);
end

if strike(i)>360
    strike(i)=strike(i)-360;
end
end

rake1=atand((-e1(3)/sind(dip(1)))/(e1(1)*cosd(strike(1))+e1(2)*sind(strike(1))));
rake2=atand((-e2(3)/sind(dip(2)))/(e2(1)*cosd(strike(2))+e2(2)*sind(strike(2))));
rake=[rake1 rake2];
for i=1:2
if (rake(i)<0)
    rake(i)=rake(i)+180;
end
end

%输出震源机制
mechanism1=[strike(1) dip(1) rake(1)];
mechanism2=[strike(2) dip(2) rake(2)];
% strike1=atand(-v1(1)/v1(2)); %走向角范围0-360
% strike2=atand(-v2(1)/v2(2));
% dip1=acosd(-v1(3))-90; %倾角范围0-90
% dip2=acosd(-v2(3))-90;
% rake1=atand((-e1(3)/sind(dip1))/(e1(1)*cosd(strike1)+e1(2)*sind(strike1)));
% rake2=atand((-e2(3)/sind(dip2))/(e2(1)*cosd(strike2)+e2(2)*sind(strike2)));

% 
% strike1=strike1+360;
% mechanism1=[strike1 dip1 rake1];