function [Ptrpl,Ttrpl,Btrpl,str2,dip2,rake2]=dsrin(str,dip,rake)
%
%   采用地震震源机制的一个节面的走向str、倾角dip和滑动角rake求其他参数的值
%   输入str为走向、dip为倾角、rake为滑动角.
%     输出Ptrpl为两个元素，第一个元素为P轴走向、第二个元素为P轴倾伏角
%     输出Ttrpl为两个元素，第一个元素为T轴走向、第二个元素为T轴倾伏角
%     输出Btrpl为两个元素，第一个元素为B轴走向、第二个元素为B轴倾伏角
%     输出str2,dip2,rake2为第二个节面的走向、倾角和滑动角
%     该程序中所有的角度值得单位均为度

    SR2=sqrt(2);
      str=deg2rad(str);dip=deg2rad(dip);rake=deg2rad(rake);  %角度转化成弧度值
%走向、倾角和滑动角转换为滑动矢量A和法向N
    A=[cos(rake)*cos(str)+sin(rake)*cos(dip)*sin(str), cos(rake)*sin(str)-sin(rake)*cos(dip)*cos(str), -sin(rake)*sin(dip)];   %A（滑动矢量）的单位方向矢量,根据（10-2-8）式计算
    N=[-sin(str)*sin(dip), cos(str)*sin(dip), -cos(dip)];   %N（节面法线）的单位方向矢量，根据（10-2-9）式计算
    T=SR2*(A+N);      %向量相加，并且单位化，得主张应力轴单位矢量，(10-3-10)第一式
    P=SR2*(A-N);      %向量相减，并且单位化，得主压应力轴单位矢量，（10-3-10）第二式
    B=cross(P,T);     %向量叉乘，得到中间轴单位矢量，（10-3-10）第三式
    [Ptrpl]=v2trpl(P); %求出P轴走向和滑动角
    [Ttrpl]=v2trpl(T); %求出T轴走向和滑动角
    [Btrpl]=v2trpl(B); %求出B轴走向和滑动角
    [str2,dip2,rake2]=an2dsr_wan(N,A);   %根据滑动矢量和法线单位矢量（两个矢量互换）求出另一个节面的参数
return
