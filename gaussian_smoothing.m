%sigma = 1.0
clear
img = imread('lena2.bmp'); 
[x,y] = size(img); 
subplot(1,2,1); imshow(img);

masksize = [3,3]; 
img = double(img);  
G = zeros(masksize); %3x3 gaussian filter 
pad_img = zeros(x+2, y+2); 
n = zeros(x,y);  
result_img = zeros(x,y); 

%Gaussian filter »ý¼º
for i = -1: 1 
  for j = -1:1
    G(i+2,j+2) = ((e^(-1*(i*i+j*j)/(2*(1^2))))/(2*pi*(1^2))); 
 endfor
endfor

%zero-padding
for s = 2:x+1 
  for f = 2:y+1
    pad_img(s,f) = img(s-1,f-1); 
 endfor
endfor

%convolution
for a = 1:x
  for b = 1:y
    n(a,b) = sum(sum(G.*(pad_img(a:a+2, b:b+2))));
  endfor
endfor

result_img = uint8(n); 
subplot(1,2,2); imshow(result_img);