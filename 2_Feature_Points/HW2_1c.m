clear all; clc; close all;

II = rgb2gray(imread('HW2.jpg')); % read image and change to grayscale

%% Pre-Processing
thres = 60;
I = Binarize(II, thres); % Binarize the image
[~, ~, G] = edge_Sobel(I); % Edge Detection of Binarized Image
[Gx, Gy, ~] = edge_Sobel(G); % Calculate the Gradient

%% Hough Transform for Finding Circles
M = size(I,1); % # of rows I
N = size(I,2); % # of columns I
R = (1:min(M/2,N/2))'; % The largest radius is half of the shorter size of image
c = zeros(M,N,length(R)); % count matrix
for i = 1:M
    for j = 1:N
       for k = 1:length(R)
          if sqrt(Gx(i,j)^2+Gy(i,j)^2) ~= 0 % check whether gradient exists
             Cos = Gx(i,j)/sqrt(Gx(i,j)^2+Gy(i,j)^2); % cos theta
             Sin = Gy(i,j)/sqrt(Gx(i,j)^2+Gy(i,j)^2); % sin theta
             xc = round((i-1) - R(k)*Cos); % x center
             yc = round((j-1) - R(k)*Sin); % y center
             if xc > 0 && yc > 0 && xc < M && yc < N % center of circle must be inside the image
                c(xc,yc,k) = c(xc,yc,k) + 1; % count
             end
          end
       end
    end
end

INDEX = zeros(length(R),3);
for k = 1:length(R)
    cc = c(:,:,k); % one value of radius at each time
    [max_cc,ind] = max(cc(:)); % find the most repeated point and its index
    [ind1,ind2] = ind2sub(size(cc),ind); % change index to subscript of matrix
    INDEX(k,:) = [ind1,ind2,max_cc]; % most repeated center of each radius
end

%% Find the radius and center of the circle
[~,R_cir] = max(INDEX(:,3)); % most repeated among every radius
Xc = INDEX(R_cir,1);
Yc = INDEX(R_cir,2);

%% Show Orignal Image and Detected Circle
imshow(II)
hold on
text(10,10,'\rightarrow y-axis')
text(10,20,'\downarrow')
text(10,30,'x-axis')
rectangle('Position', [Yc-R_cir, Xc-R_cir, 2*R_cir, 2*R_cir], ...
          'Curvature', [1 1], 'EdgeColor', 'r', 'LineWidth', 4);
plot(Yc,Xc,'sg','MarkerSize',10,'MarkerEdgeColor','g','MarkerFaceColor',[0,1,0])
txt = sprintf('(%d, %d)',Yc,Xc);
text(Yc-20, Xc+15, txt);
txt = sprintf('R = %d',R_cir);
text(Yc-20, Xc-75, txt, 'color','w');