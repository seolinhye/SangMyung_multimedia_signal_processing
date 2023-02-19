clear;
img = imread('lena.bmp');
[x,y] = size(img)
fx = [-1 0 1; -2 0 2; -1 0 1];
fy = [-1 -2 -1; 0 0 0; 1 2 1];

pad_img = zeros(x+2,y+2); 
mask_fx = zeros(x,y); 
mask_fy = zeros(x,y);

%zero-padding
for i = 2:x+1 
  for j = 2:y+1
    pad_img(i,j) = img(i-1,j-1); 
 endfor
endfor

%convolution
for a = 1:x
  for b = 1:y
    mask_fx(a,b) = sum(sum(fx.*(pad_img(a:a+2, b:b+2)))); 
    mask_fy(a,b) = sum(sum(fy.*(pad_img(a:a+2, b:b+2))));
    result_img(a,b) = sqrt(mask_fx(a,b).^2+mask_fy(a,b).^2);
  endfor
endfor

result_img = uint8(result_img);

%임계값에 따른 출력
for s = 1:x
    for f = 1:y
     if(result_img(s,f) > 200) %threshold = 200
        result_img(s,f) = 255;
      else
        result_img(s,f) = 0;
      end
  endfor
endfor

imshow(result_img);
