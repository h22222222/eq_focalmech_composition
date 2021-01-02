function [trpl]=v2trpl(xyz)
%   将单位向量在XYZ轴中的分量表示转换为走向trend和倾俯角plunge
%   走向为自北向顺时针旋转到矢量方向针转过的水平角度
%   倾伏角为水平面与矢量的夹角，所有角度的单位为度
%   输入变量xyz包含三个元素X,Y,Z，分别为北向、东向、下向的数值
%     输出分量trpl包含两个元素走向trend和倾伏角plunge
%   如果Z分量为负，则trpl(2),即倾伏角变为正值，而将走向TRPL(1)改变180.
%   返回的走向值在0~360的范围内
%     如果为-1.0，走向可以任意，此处规定为180度

for j=1:3
if (abs(xyz(j))<= 0.0001)   
      xyz(j) = 0.0;      %坐标轴的值（绝对值）不大于0.0001，则赋为0
end
if (abs(abs(xyz(j))-1.0)<0.0001)   %对于微大于1，则数据只能等于1
xyz(j)=xyz(j)/abs(xyz(j));
end
end
if (abs(xyz(3))==1.0)    %单位矢量在z轴上
%   倾伏角为90°
if (xyz(3)< 0.0)       %轴在z轴反方向，走向定为180°
trpl(1) = 180;
else
    trpl(1) = 0.0;       %轴在z轴方向，走向为0°
end
  trpl(2) = 90;      %倾角为90°
return
end
if (abs(xyz(1))< 0.0001)    %轴的单位向量在yz平面上
  if (xyz(2)> 0.0)          %轴在y>0平面内，走向为90°
   trpl(1) = 90.0;
  elseif(xyz(2)< 0.0)       %轴在y<0平面内，走向为270°
   trpl(1) = 270.0;
  else
    trpl(1) = 0.0;          %y=0，轴在z轴方向，走向为0°
  end
else
trpl(1)= rad2deg(atan2(xyz(2),xyz(1)));   %求轴走向并转换为度
end
  hypotxy = hypot(xyz(1),xyz(2));     %sqrt(x^2+y^2)
  trpl(2)=rad2deg(atan2(xyz(3),hypotxy));    %求轴的倾伏角并转换为度   
if (trpl(2)<0.0) 
  trpl(2) = -trpl(2);
  trpl(1) = trpl(1) - 180;
 end
if (trpl(1)< 0.0) trpl(1) = trpl(1) + 360;end
return
