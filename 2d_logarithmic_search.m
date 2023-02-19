clear;
img1 = imread('frame1.jpg'); % 참조 이미지
img2 = imread('frame2.jpg'); % 현재 이미지
[x,y] = size(img1); % 참조, 현재 이미지 모두 크기 동일
img1 = double(img1); % 더 정확한 계산을 위해
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
    MB = img2(i:i+P-1,j:j+P-1); % 현재 이미지 매크로 블록 위치 이동
      k = x/2;
      l = y/2;
      for t = 1:3 % 3-step-search
        p = 2*N/(2^t);
        % 검색영역 내에 각각 총 9개의 pixel에서 MAD 값 추출
        search_mad = [MAD(img1(k-p/2-7:k-p/2+7,l-p/2-7:l-p/2+7),MB) MAD(img1(k-p/2-7:k-p/2+7,l-7:l+7),MB) MAD(img1(k-p/2-7:k-p/2+7,l+p/2-7:l+p/2+7),MB);
                      MAD(img1(k-7:k+7,l-p/2-7:l-p/2+7),MB) MAD(img1(k-7:k+7,l-7:l+7),MB) MAD(img1(k-7:k+7,l+p/2-7:l+p/2+7),MB);
                      MAD(img1(k+p/2-7:k+p/2+7,l-p/2-7:l-p/2+7),MB) MAD(img1(k+p/2-7:k+p/2+7,l-7:l+7),MB) MAD(img1(k+p/2-7:k+p/2+7,l+p/2-7:l+p/2+7),MB)];
        temp_search = find(search_mad == min(min(search_mad))); % 최소 인덱스 찾기
        switch temp_search % 인덱스 위치에 따라 중심 이동
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
      MAD_x = k; % 최적 MAD 해당 인덱스
      MAD_y = l; 
      temp_MV = [MAD_x MAD_y]; 
      MV(q,1:2) = [i+7 j+7] - temp_MV; % Motion Vector 계산
      q = q+1; % 매크로 블록 단위로 나온 계산된 MV 값을 저장을 위해
    endfor
  endfor