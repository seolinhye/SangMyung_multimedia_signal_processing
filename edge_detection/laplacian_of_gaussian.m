clear;
img = imread('lena.bmp');
[x,y] = size(img);
masksize = [3,3]; 
w = 1.0;
L = zeros(masksize); %3x3 LoG mask ����
pad_img = zeros(x+2,y+2);
pad_L = zeros(masksize+2); 
fx = [-1 0 1; -1 0 1; -1 0 1];
fy = [-1 -1 -1; 0 0 0; 1 1 1];

%Laplacian of Gaussian mask ����
for i = -1: 1 
  for j = -1:1
    L(i+2,j+2) = ((e^(-1*(i*i+j*j)/(2*(w^2))))/(pi*(w^4)))*(1-((i*i+j*j)/(2*(w^2))));
 endfor
endfor

%mask zero-padding
for i = 2:4 
  for j = 2:4
    pad_L(i,j) = L(i-1,j-1); 
 endfor
endfor

%mask ����
for a = 1:3
  for b = 1:3
    L_fx(a,b) = sum(sum(fx.*(pad_L(a:a+2, b:b+2)))); 
    L_fy(a,b) = sum(sum(fy.*(pad_L(a:a+2, b:b+2))));
  endfor
endfor

% image zero-padding
for s = 2:x+1 
  for f = 2:y+1
    pad_img(s,f) = img(s-1,f-1); 
 endfor
endfor

%convolution
for m = 1:x
  for n = 1:y
    img_fx(m,n) = sum(sum(L_fx.*(pad_img(m:m+2, n:n+2)))); 
    img_fy(m,n) = sum(sum(L_fy.*(pad_img(m:m+2, n:n+2))));
    result_img(m,n) = sqrt(img_fx(m,n).^2+img_fy(m,n).^2); 
  endfor
endfor

result_img=uint8(result_img);
subplot(1,2,1); imshow(result_img);

%zero-crossing ����
hori = [-1 -1 -1; 2 2 2; -1 -1 -1]; %������� ����ũ
verti = [-1 2 -1; -1 2 -1; -1 2 -1]; %�������� ����ũ
dia_1 = [-1 -1 2; -1 2 -1; 2 -1 -1]; %+45������ ����ũ
dia_2 = [2 -1 -1; -1 2 -1; -1 -1 2]; %-45������ ����ũ
repad_img = zeros(x+2,y+2);
zero_check = zeros(x,y); %2�� �̻��� ��ȭ Ȯ�ο�
threshold = 15; %Ư�� �Ӱ谪 ����

%����̹��� �ٽ� zero-padding
for s = 2:x+1 
  for f = 2:y+1
    repad_img(s,f) = result_img(s-1,f-1); 
 endfor
endfor

%�� ���⿡ ���� convolution (����)
for m = 1:x
  for n = 1:y
    img_hori(m,n) = sum(sum(hori.*(repad_img(m:m+2, n:n+2)))); 
    img_verti(m,n) = sum(sum(verti.*(repad_img(m:m+2, n:n+2))));
    img_dia1(m,n) = sum(sum(dia_1.*(repad_img(m:m+2, n:n+2))));
    img_dia2(m,n) = sum(sum(dia_2.*(repad_img(m:m+2, n:n+2))));
  endfor
endfor

%���� ��ȭ üũ
for v = 1:x
  for r = 1:y-1
    if(img_hori(v,r)*img_hori(v,r+1) <0)
      if(abs(abs(img_hori(v,r))-abs(img_hori(v,r+1))) > threshold)
        zero_check(v,r+1) ++;
      endif
    endif
  endfor
endfor

%���� ��ȭ üũ
for v = 1:x-1
  for r = 1:y
    if(img_verti(v,r)*img_verti(v+1,r)<0)
      if(abs(abs(img_verti(v,r))-abs(img_verti(v+1,r))) > threshold)
        zero_check(v+1,r) ++;
      endif  
    endif   
  endfor
endfor

%�밢�� ��ȭ üũ
for v = 1:x-1
  for r = 1:y-1
    if(img_dia2(v,r)*img_dia2(v+1,r+1)<0)
       if(abs(abs(img_dia2(v,r))-abs(img_dia2(v+1,r+1))) > threshold)
          zero_check(v+1,r+1) ++;
       endif   
    endif
    if(img_dia1(v,257-r)*img_dia1(v+1,256-r)<0)
       if(abs(abs(img_dia1(v,257-r))-abs(img_dia1(v+1,256-r))) > threshold)
         zero_check(v+1,256-r) ++;
       endif
    endif
  endfor
endfor

%zero-crossing ���� (2 ���� �̻��� ��ȭ ��)
for s = 1:x
    for f = 1:y
     if(zero_check(s,f) >= 2)
        result_zero(s,f) = 255;
      else
        result_zero(s,f) = 0;
      end
  endfor
endfor

subplot(1,2,2); imshow(result_zero);


