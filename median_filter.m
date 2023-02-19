clear
img = imread('lena2.bmp'); 
[x,y] = size(img); 
subplot(1,2,1); imshow(img);

mask = zeros(1,9); 
med_val = zeros(1,9); 
n = zeros(x, y); 

for i = 2:(x-1) 
  for j = 2:(y-1)
    mask(1) = img(i-1, j-1); 
    mask(2) = img(i-1, j);
    mask(3) = img(i-1, j+1);
    mask(4) = img(i, j-1);
    mask(5) = img(i,j); 
    mask(6) = img(i, j+1);
    mask(7) = img(i+1, j-1); 
    mask(8) = img(i+1, j);
    mask(9) = img(i+1, j+1);
    
    med_val = sort(mask); 
    n(i,j) = med_val(5); 
    
   endfor
endfor

result_img= uint8(n); 
subplot(1,2,2); imshow(result_img);