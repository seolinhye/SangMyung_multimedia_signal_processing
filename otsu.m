clear;
img = imread('lena.bmp');
[m,n] = size(img);
subplot(1,2,1) ; imshow(img);

%분산 찾기
for i = 1:m
  n_i(i) = size((find(img == i)),1);
  N = m*n;
  p_i(i) = n_i(i)/N;
  w_1(i) = sum(p_i(i));
  w_2(i) = 1 - w_1(i); 
  m_t(i) = sum(i*p_i(i));
  b_var(i) = (w_1(i)*((sum((i*p_i(i))/w_1(i))) - m_t(i))^2) + (w_2(i)*((sum((i*p_i(i))/w_2(i)))-m_t(i))^2);
endfor

%경계값 찾기
max_val = max(b_var); 
k = (find(b_var == max_val));

%영상분할
result_img = zeros(m,n);
for x = 1:m
  for y = 1:n
    if(img(x,y) > k)
      result_img(x,y) = 255;
    else
      result_img(x,y) = 0;
    end
  endfor
endfor

subplot(1,2,2); imshow(result_img);  