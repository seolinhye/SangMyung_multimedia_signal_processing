clear;
img = imread('lena2.bmp');
[x,y] = size(img);
subplot(1,2,1); imshow(img);
img = double(img);

% ����ȭ ���̺�
QT = [16 11 10 16 24 40 51 61;
      12 12 14 19 26 58 60 55;
      14 13 16 24 40 57 69 56;
      14 17 22 29 51 87 80 62;
      18 22 37 56 68 109 103 77;
      24 35 55 64 81 104 113 92;
      49 64 78 87 103 121 120 101;
      72 92 95 98 112 100 103 99];
%QT�� ������ �� ����
k = 0.5;
QT = QT.*k;

%DCT & Quantization & IDCT
for u = 1:8:x
  for v = 1:8:y
    f = img(u:u+7, v:v+7); %dct2 �Լ� ���(���� ������)�� ���� ���Ƿ� ����
    DF = dct2(f); 
    F(u:u+7, v:v+7) = DF; %8x8 ��ŭ�� dct�� �� ������ �°� �ֱ�
    F_Q(u:u+7,v:v+7) = round(F(u:u+7,v:v+7)./QT); %Quantization ����
    R(u:u+7,v:v+7) = F_Q(u:u+7,v:v+7).*QT; %Inverse Quantization
    f = R(u:u+7,v:v+7); %idct2 �Լ� ����� ���� (���� ������) ���Ƿ� ���� 
    IDF = idct2(f);
    r(u:u+7, v:v+7) = IDF; %8x8 ��ŭ�� idct�� �� ������ �°� �ֱ�
  endfor
endfor

result_img = img - r;
result_img= uint8(result_img);
subplot(1,2,2); imshow(result_img);