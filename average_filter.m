clear
img = imread('lena2.bmp'); 
[x,y] = size(img); 
subplot(1,2,1); imshow(img);

pad_img = zeros(x+2,y+2); 
mask = ones(3)./9; 
n = zeros(x,y); 

%zero-padding
for i = 2:x+1 
  for j = 2:y+1
    pad_img(i,j) = img(i-1,j-1); 
 endfor
endfor

%convolution
for a = 1:x
  for b = 1:y
    n(a,b) = sum(sum(mask.*(pad_img(a:a+2, b:b+2)))); 
  endfor
endfor

result_img= uint8(n); 
subplot(1,2,2); imshow(result_img);




