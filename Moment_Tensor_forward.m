%��Դ��բз��ҵ-������������ݣ���֪�ϲ㼸�����������
%2019.10.22
%heyuqing
% clear all;
%input: �߻��ǣ���ǣ������Ǻͱ��������
%output: ������
function [M]=Moment_Tensor_forward(strike,dip,rake,M0)
%% һЩ��֪��
%�ҵ�������һ���еĵ�31+14=45��
%228/66/4
% strike=mod(45,360); %����Ǧ�
% dip=mod(45,90); %��Ǧ�
% rake=mod(45,360); %�����Ǧ�
% 1. northdipping thrust
% strike=276; %����Ǧ�
% dip=10.2; %��Ǧ�
% rake=109.84; %�����Ǧ�
% M0=2.34000000000000e+18; %���������������
% 2. strike-slip
% strike=170; %����Ǧ�
% dip=88; %��Ǧ�
% rake=35.88; %�����Ǧ�
% M0=6.48000000000000e+17; %�߻����������



%% ������������
Mxx=-M0*(sin(dip/180*pi)*cos(rake/180*pi)*sin((2*strike)/180*pi)+sin((2*dip)/180*pi)*sin(rake/180*pi)*sin(strike/180*pi)*sin(strike/180*pi));
Mxy=M0*(sin(dip/180*pi)*cos(rake/180*pi)*cos((2*strike)/180*pi)+(1/2)*sin((2*dip)/180*pi)*sin(rake/180*pi)*sin(2*strike/180*pi));
Myx=Mxy;
Mxz=-M0*(cos(dip/180*pi)*cos(rake/180*pi)*cos(strike/180*pi)+cos((2*dip)/180*pi)*sin(rake/180*pi)*sin(strike/180*pi));
Mzx=Mxz;
Myy=M0*(sin(dip/180*pi)*cos(rake/180*pi)*sin((2*strike)/180*pi)-sin((2*dip)/180*pi)*sin(rake/180*pi)*cos(strike/180*pi)*cos(strike/180*pi));
Myz=-M0*(cos(dip/180*pi)*cos(rake/180*pi)*sin(strike/180*pi)-cos((2*dip)/180*pi)*sin(rake/180*pi)*cos(strike/180*pi));
Mzy=Myz;
Mzz=M0*(sin((2*dip)/180*pi)*sin(rake/180*pi));
trace=Mxx+Myy+Mzz; %Ϊ0��ȷ
M=[Mxx Mxy Mxz;
    Myx Myy Myz;
    Mzx Mzy Mzz];
% M=[-9.46946819683156e+17,2.22056719155905e+16,4.42155860759681e+17;2.22056719155905e+16,1.08906186269084e+18,-4.36980627499351e+17;4.42155860759681e+17,-4.36980627499351e+17,-1.42115043007685e+17]





