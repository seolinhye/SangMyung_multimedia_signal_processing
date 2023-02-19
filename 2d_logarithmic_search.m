clear;
img1 = imread('frame1.jpg'); % ���� �̹���
img2 = imread('frame2.jpg'); % ���� �̹���
[x,y] = size(img1); % ����, ���� �̹��� ��� ũ�� ����
img1 = double(img1); % �� ��Ȯ�� ����� ����
img2 = double(img2);
N = 16; 
P = 15; 

% MAD 
function mad_value = MAD(R, C)
  mad_value = (1/16^2)*sum(sum(abs(C-R))); 
endfunction  

% 2-D logarithmic search
q = 1;
for i = 1:P:x-P-1
  for j = 1:P:y-P-1
    MB = img2(i:i+P-1,j:j+P-1); % ���� �̹��� ��ũ�� ��� ��ġ �̵�
      k = x/2;
      l = y/2;
      for t = 1:3 % 3-step-search
        p = 2*N/(2^t);
        % �˻����� ���� ���� �� 9���� pixel���� MAD �� ����
        search_mad = [MAD(img1(k-p/2-7:k-p/2+7,l-p/2-7:l-p/2+7),MB) MAD(img1(k-p/2-7:k-p/2+7,l-7:l+7),MB) MAD(img1(k-p/2-7:k-p/2+7,l+p/2-7:l+p/2+7),MB);
                      MAD(img1(k-7:k+7,l-p/2-7:l-p/2+7),MB) MAD(img1(k-7:k+7,l-7:l+7),MB) MAD(img1(k-7:k+7,l+p/2-7:l+p/2+7),MB);
                      MAD(img1(k+p/2-7:k+p/2+7,l-p/2-7:l-p/2+7),MB) MAD(img1(k+p/2-7:k+p/2+7,l-7:l+7),MB) MAD(img1(k+p/2-7:k+p/2+7,l+p/2-7:l+p/2+7),MB)];
        temp_search = find(search_mad == min(min(search_mad))); % �ּ� �ε��� ã��
        switch temp_search % �ε��� ��ġ�� ���� �߽� �̵�
          case 1
              k = k-p/2;
              l = l-p/2;
          case 2
              k = k;
              l = l-p/2;
          case 3
            k = k+p/2;
              l = l-p/2;
        case 4
              k = k-p/2;
              l = l;
          case 5
              k = k;
              l = l;
          case 6
              k = k+p/2;
              l = l;
          case 7
              k = k-p/2;
              l = l+p/2;
          case 8
              k = k;
              l = l+p/2;
          case 9
              k = k+p/2;
              l = l+p/2;
        endswitch
      endfor
      MAD_x = k; % ���� MAD �ش� �ε���
      MAD_y = l; 
      temp_MV = [MAD_x MAD_y]; 
      MV(q,1:2) = [i+7 j+7] - temp_MV; % Motion Vector ���
      q = q+1; % ��ũ�� ��� ������ ���� ���� MV ���� ������ ����
    endfor
  endfor