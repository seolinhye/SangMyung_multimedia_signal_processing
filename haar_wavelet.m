clear;
img = imread('lena2.bmp');
[x y] = size(img);
img = double(img);

h0 = [1/sqrt(2), 1/sqrt(2)];
h1 = [-1/sqrt(2), 1/sqrt(2)];

% 변환 (분해)
k = 1;
for i = 1:2:x
  L(:,k) = h0(1)*img(:,i) + h0(2)*img(:,i+1);
  H(:,k) = h1(1)*img(:,i) + h1(2)*img(:,i+1);
  k = k+1;
endfor

k = 1;
for j = 1:2:y
  LL(k,:) = h0(1)*L(j,:) + h0(2)*L(j+1,:);
  LH(k,:) = h1(1)*L(j,:) + h1(2)*L(j+1,:);
  HL(k,:) = h0(1)*H(j,:) + h0(2)*H(j+1,:);
  HH(k,:) = h1(2)*H(j,:) + h1(2)*H(j+1,:);
  k = k+1;
endfor

hw = [LL HL; LH HH];
hw_U = uint8(hw);
figure(1); imshow(hw_U);

% 역변환 (합성)
k = 1;
for i = 1:y/2
  Ihw_T(k,:) = h0(1)*hw(i,:) + h0(2)*hw(i+y/2,:);
  Ihw_T(k+1,:) = h1(1)*hw(i+y/2,:) + h1(2)*hw(i,:);
  k = k+2;
endfor

k = 1;
for j = 1:x/2
  Ihw(:,k) = h0(1)*Ihw_T(:,j) + h0(2)*Ihw_T(:,j+x/2);
  Ihw(:,k+1) = h1(1)*Ihw_T(:,j+x/2) + h1(2)*Ihw_T(:,j);
  k = k+2;  
endfor

Ihw = uint8(Ihw);
figure(2); imshow(Ihw);