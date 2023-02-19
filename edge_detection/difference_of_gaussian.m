clear;
img = imread('lena.bmp');
[x,y] = size(img);
masksize = [3,3]; 
w = 1.0;
G = zeros(masksize); %3x3 gaussian filter 
pad_img = zeros(x+2,y+2);
pad_G = zeros(masksize+2); 
fx = [-1 0 1; -1 0 1; -1 0 1];
fy = [-1 -1 -1; 0 0 0; 1 1 1];

%Gaussian filter 생성
for i = -1: 1 
  for j = -1:1
    G(i+2,j+2) = ((e^(-1*(i*i+j*j)/(2*(w^2))))/(2*pi*(w^2))); 
 endfor
endfor

% filter zero-padding
for i = 2:4 
  for j = 2:4
    pad_G(i,j) = G(i-1,j-1); 
 endfor
endfor

%Gaussian filter 차분
for a = 1:3
  for b = 1:3
    G_fx(a,b) = sum(sum(fx.*(pad_G(a:a+2, b:b+2)))); 
    G_fy(a,b) = sum(sum(fy.*(pad_G(a:a+2, b:b+2))));
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
    img_fx(m,n) = sum(sum(G_fx.*(pad_img(m:m+2, n:n+2)))); 
    img_fy(m,n) = sum(sum(G_fy.*(pad_img(m:m+2, n:n+2))));
    result_img(m,n) = sqrt(img_fx(m,n).^2+img_fy(m,n).^2); 
  endfor
endfor

result_img=uint8(result_img);
imshow(result_img);
