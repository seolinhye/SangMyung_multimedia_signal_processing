clear;
img = imread('lena.bmp');
[m, n] = size(img);
subplot(1,2,1) ; imshow(img);

T = (max(max(img))-min(min(img))) / 2;

g1 = zeros(m,n);
g2 = zeros(m,n);
num_g1 = 0;
num_g2 = 0;

%T로 이진화
for i = 1:m
  for j = 1:n
    if(img(i,j) > T)
      g1(i,j) = img(i,j);
      num_g1++;
    else 
      g2(i,j) = img(i,j);
      num_g2++;
    end
  endfor
endfor

%새로운 경계값 계산
n_T(1) = (((sum(sum(g1)))/num_g1) + ((sum(sum(g2)))/num_g2)) / 2;

n_g1 = zeros(m,n);
n_g2 = zeros(m,n);
num_g1 = 0;
num_g2 = 0;

%eps보다 작을 때 까지 반복
for a = 1:m
  for b = 1:n
    if(img(a,b) > n_T(a))
      n_g1(a,b) = img(a,b);
      num_g1++;
    else 
      n_g2(a,b) = img(a,b);
      num_g2++;
    end
      n_T(a+1)= (((sum(sum(n_g1)))/num_g1) + ((sum(sum(n_g2)))/num_g2)) / 2;
    if(abs(n_T(a+1)-n_T(a)) > eps)
      result_T = n_T(a);
      break
    else
      continue
    end
  endfor
endfor

result_img = zeros(m,n);
for x = 1:m
    for y = 1:n
      if(img(x,y) > result_T)
        result_img(x,y) = 255;
      else
        result_img(x,y) = 0;
      end
  endfor
endfor

subplot(1,2,2); imshow(result_img);
