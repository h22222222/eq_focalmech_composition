function [Ptrpl,Ttrpl,Btrpl,str2,dip2,rake2]=dsrin(str,dip,rake)
%
%   ���õ�����Դ���Ƶ�һ�����������str�����dip�ͻ�����rake������������ֵ
%   ����strΪ����dipΪ��ǡ�rakeΪ������.
%     ���PtrplΪ����Ԫ�أ���һ��Ԫ��ΪP�����򡢵ڶ���Ԫ��ΪP�������
%     ���TtrplΪ����Ԫ�أ���һ��Ԫ��ΪT�����򡢵ڶ���Ԫ��ΪT�������
%     ���BtrplΪ����Ԫ�أ���һ��Ԫ��ΪB�����򡢵ڶ���Ԫ��ΪB�������
%     ���str2,dip2,rake2Ϊ�ڶ��������������Ǻͻ�����
%     �ó��������еĽǶ�ֵ�õ�λ��Ϊ��

    SR2=sqrt(2);
      str=deg2rad(str);dip=deg2rad(dip);rake=deg2rad(rake);  %�Ƕ�ת���ɻ���ֵ
%������Ǻͻ�����ת��Ϊ����ʸ��A�ͷ���N
    A=[cos(rake)*cos(str)+sin(rake)*cos(dip)*sin(str), cos(rake)*sin(str)-sin(rake)*cos(dip)*cos(str), -sin(rake)*sin(dip)];   %A������ʸ�����ĵ�λ����ʸ��,���ݣ�10-2-8��ʽ����
    N=[-sin(str)*sin(dip), cos(str)*sin(dip), -cos(dip)];   %N�����淨�ߣ��ĵ�λ����ʸ�������ݣ�10-2-9��ʽ����
    T=SR2*(A+N);      %������ӣ����ҵ�λ����������Ӧ���ᵥλʸ����(10-3-10)��һʽ
    P=SR2*(A-N);      %������������ҵ�λ��������ѹӦ���ᵥλʸ������10-3-10���ڶ�ʽ
    B=cross(P,T);     %������ˣ��õ��м��ᵥλʸ������10-3-10������ʽ
    [Ptrpl]=v2trpl(P); %���P������ͻ�����
    [Ttrpl]=v2trpl(T); %���T������ͻ�����
    [Btrpl]=v2trpl(B); %���B������ͻ�����
    [str2,dip2,rake2]=an2dsr_wan(N,A);   %���ݻ���ʸ���ͷ��ߵ�λʸ��������ʸ�������������һ������Ĳ���
return
