%震源大闸蟹作业-地震矩张量正演（已知断层几何求矩张量）
%2019.10.22
%heyuqing
% clear all;
%input: 走滑角，倾角，滑动角和标量地震矩
%output: 矩张量
function [M]=Moment_Tensor_forward(strike,dip,rake,M0)
%% 一些已知量
%我的生日在一年中的第31+14=45天
%228/66/4
% strike=mod(45,360); %走向角φ
% dip=mod(45,90); %倾角δ
% rake=mod(45,360); %滑动角λ
% 1. northdipping thrust
% strike=276; %走向角φ
% dip=10.2; %倾角δ
% rake=109.84; %滑动角λ
% M0=2.34000000000000e+18; %北倾逆冲标量地震矩
% 2. strike-slip
% strike=170; %走向角φ
% dip=88; %倾角δ
% rake=35.88; %滑动角λ
% M0=6.48000000000000e+17; %走滑标量地震矩



%% 计算地震矩张量
Mxx=-M0*(sin(dip/180*pi)*cos(rake/180*pi)*sin((2*strike)/180*pi)+sin((2*dip)/180*pi)*sin(rake/180*pi)*sin(strike/180*pi)*sin(strike/180*pi));
Mxy=M0*(sin(dip/180*pi)*cos(rake/180*pi)*cos((2*strike)/180*pi)+(1/2)*sin((2*dip)/180*pi)*sin(rake/180*pi)*sin(2*strike/180*pi));
Myx=Mxy;
Mxz=-M0*(cos(dip/180*pi)*cos(rake/180*pi)*cos(strike/180*pi)+cos((2*dip)/180*pi)*sin(rake/180*pi)*sin(strike/180*pi));
Mzx=Mxz;
Myy=M0*(sin(dip/180*pi)*cos(rake/180*pi)*sin((2*strike)/180*pi)-sin((2*dip)/180*pi)*sin(rake/180*pi)*cos(strike/180*pi)*cos(strike/180*pi));
Myz=-M0*(cos(dip/180*pi)*cos(rake/180*pi)*sin(strike/180*pi)-cos((2*dip)/180*pi)*sin(rake/180*pi)*cos(strike/180*pi));
Mzy=Myz;
Mzz=M0*(sin((2*dip)/180*pi)*sin(rake/180*pi));
trace=Mxx+Myy+Mzz; %为0正确
M=[Mxx Mxy Mxz;
    Myx Myy Myz;
    Mzx Mzy Mzz];
% M=[-9.46946819683156e+17,2.22056719155905e+16,4.42155860759681e+17;2.22056719155905e+16,1.08906186269084e+18,-4.36980627499351e+17;4.42155860759681e+17,-4.36980627499351e+17,-1.42115043007685e+17]





