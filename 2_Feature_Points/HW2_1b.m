clear all; clc; close all;

II = rgb2gray(imread('HW2.jpg')); % read image and change to grayscale

%% Pre-Processing
thres = 60;
I = Binarize(II, thres); % Binarize the image
[~, ~, G] = edge_Sobel(I); % Edge Detection of Binarized Image
[Gx, Gy, ~] = edge_Sobel(G); % Calculate the Gradient

%% Hough Transform Foot-of-Normal
M = size(I,1); % # of rows I
N = size(I,2); % # of columns I
k = 1;
for i = 1:M
    for j = 1:N
       v = ((i-1)*Gx(i,j)+(j-1)*Gy(i,j))/(Gx(i,j)^2+Gy(i,j)^2); % calculate v
       if ~isnan(v) % check whether v is a valid number
          x0(k,:) = round(v*Gx(i,j)); % calculate a point x0
          y0(k,:) = round(v*Gy(i,j)); % calculate a point y0
          k = k + 1; 
       end
    end
end

c = zeros(range(x0)+1,range(y0)+1); % matrix for counting the number of repeated (x0,y0)
for i = 1:k-1
    if y0(i) ~= 0 && x0(i) ~= 0 % ignore horizontal and vertical line
        if y0(i) ~= -x0(i) && y0(i) ~= x0(i) % ignore a line with slope +-1
            c(x0(i)-min(x0)+1,y0(i)-min(y0)+1) = ...
            c(x0(i)-min(x0)+1,y0(i)-min(y0)+1) + 1; % count (x0,y0)
        end
    end
end

%% Plot x0, y0, and the counted number
[Y,X] = meshgrid(min(y0):max(y0),min(x0):max(x0));
cc = c;
cc(cc<=1) = nan; %ignore the lines that pass through less than two points
subplot(1,2,1); surf(Y,X,cc,gradient(cc))
xlabel('y0'); ylabel('x0'); zlabel('count')

%% Show Orignal Image and Detected lines
subplot(1,2,2); imshow(II) % Original Image
hold on
text(10,10,'\rightarrow y-axis')
text(10,20,'\downarrow')
text(10,30,'x-axis')
x = (1:M)'; % varying x for the whole image

j = 1;
for i = 1:75 
    [max_c,ind] = max(c(:)); % find the most repeated point and its index
    [ind1,ind2] = ind2sub(size(c),ind); % change index to subscript of matrix
    six_edges = [2,3,15,23,16,75];
    if sum(i == six_edges) % pick only six egdes
        y00(j) = min(y0)+ind2-1; % pick most repeated y0 (-1 to account for 0)
        x00(j) = min(x0)+ind1-1; % pick most repeated x0 (-1 to account for 0)
        y = y00(j) - x00(j)/y00(j)*(x - x00(j)); % line equation
        plot(y,x,'-b','LineWidth',2) % plot
        j = j + 1;
    end
    c(ind) = nan; % set aside the most repeated point in order to find the next most repeated one
end

%% Find Corners
syms xx
k = 1; % corner index
for i = 1:length(x00)-1
    for j = i:length(x00)
        % solve for x
        x_intersect = round(double(solve(y00(i) - x00(i)/y00(i)*(xx - x00(i)) ...
                                      == y00(j) - x00(j)/y00(j)*(xx - x00(j)))));
        if(x_intersect > 0 && x_intersect < N)
            % substitute x for y
            y_intersect = round(y00(i) - x00(i)/y00(i)*(x_intersect - x00(i)));
            if (y_intersect > 0 && y_intersect < M)
                % put x and y in matrix form
                corners(k,:) = [y_intersect, x_intersect];
                k = k + 1;
                txt = sprintf('(%d, %d)', x_intersect,y_intersect);
                text(y_intersect-15, x_intersect+15, txt, 'color', 'w');
            end
        end
    end
end
plot(corners(:,1),corners(:,2),'sr','MarkerSize',10,'MarkerEdgeColor','r','MarkerFaceColor',[1,0,0]) % plot