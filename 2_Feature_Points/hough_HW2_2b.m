clear all; clc; close all;

%% Result Obtained in a.
I = rgb2gray(imread('HW2.jpg')); % read image and change to grayscale
BW = imbinarize(I); % binarized image
[B,L,~,A] = bwboundaries(BW); % find the boundaries
subplot(2,1,1); imshow(I) % show origianl image
hold on
title('Original Image, Boundaries, Lines, and Corners');
text(10,10,'\rightarrow y-axis')
text(10,30,'\downarrow')
text(10,50,'x-axis')
for k = 1:length(B) % plot boundaries
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2) % draw a boundaries
end

%% Rho-Theta method
M = size(I,1); % # of rows I
N = size(I,2); % # of columns I

theta = (0:180)'; % theta is between zero to pi
for i = 1:size(boundary,1)
   rho(:,i) = boundary(i,1)*cosd(theta) + boundary(i,2)*sind(theta); % calculate rho
end

max_rho = round(max(max(rho))); % maximum value of rho
min_rho = round(min(min(rho))); % minimum value of rho
c = zeros(max_rho-min_rho+1,length(theta)); % count
for i = 1:size(boundary,1)
    for j = 1:length(theta)
        c(round(rho(j,i))-min_rho+1,theta(j)+1) = ...
        c(round(rho(j,i))-min_rho+1,theta(j)+1) + 1; % counting
    end
end

subplot(2,1,2);
imshow(c,[min(min(c)) max(max(c))],'XData',theta,'YData',min_rho:max_rho,...
      'InitialMagnification','fit'); % show the rho-theta signature
colormap(gca,hot)
title('\rho\theta signature');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal

%% Find Lines
x = (1:M)'; % varying x for the whole image
subplot(2,1,1);
hold on
i = 1;
THETA_old = 0;
RHO_old = 0;
while i <= 6 % stay in while loop until obtain 6 lines
    [max_c,ind] = max(c(:)); % find the most repeated point and its index
    [RHO_index,THETA_index] = ind2sub(size(c),ind); % change index to subscript of matrix
    if prod(abs(THETA_index-THETA_old) > 10) % check whether the new theta is repeated
        THETA(i,:) = THETA_index; % assign theta value
        RHO(i,:) = min_rho+RHO_index-1; % assign rho value
        y(:,i) = -(cosd(THETA(i,:))/sind(THETA(i,:)))*x + RHO(i,:)/sind(THETA(i,:)); % line equation
        plot(y,x,'LineWidth',1) % plot        
        THETA_old = [THETA_old THETA_index];
        RHO_old = [RHO_old RHO_index];
        i = i + 1;
    else
        zero_ind = find((abs(THETA_index-THETA_old) > 10) == 0);
        if abs(RHO_index-RHO_old(zero_ind)) > 100 % check whether the new rho is repeated
            THETA(i,:) = THETA_index; % assign theta value
            RHO(i,:) = min_rho+RHO_index-1; % assign rho value
            y(:,i) = -(cosd(THETA(i,:))/sind(THETA(i,:)))*x + RHO(i,:)/sind(THETA(i,:)); % line equation
            plot(y(:,i),x,'LineWidth',1) % plot        
            THETA_old = [THETA_old THETA_index];
            RHO_old = [RHO_old RHO_index];
            i = i + 1;
        end        
    end
    c(ind) = nan; % set aside the most repeated point in order to find the next most repeated one
end

%% Find Corners
syms xx
k = 1; % corner index
for i = 1:5
    for j = i:6
        % solve for x
        x_intersect = double(solve(-(cosd(THETA(i,:))/sind(THETA(i,:)))*xx + RHO(i,:)/sind(THETA(i,:)) == ...
                                   -(cosd(THETA(j,:))/sind(THETA(j,:)))*xx + RHO(j,:)/sind(THETA(j,:))));
        if(x_intersect > 0 && x_intersect < N)
            % substitute x for y
            y_intersect = -(cosd(THETA(i,:))/sind(THETA(i,:)))*x_intersect + RHO(i,:)/sind(THETA(i,:));
            if (y_intersect > 0 && y_intersect < M)
                % put x and y in matrix form
                corners(k,:) = [y_intersect, x_intersect];
                k = k + 1;
            end
        end
    end    
end
plot(corners(:,1),corners(:,2),'sr','MarkerSize',10,'MarkerEdgeColor','r','MarkerFaceColor',[1,0,0]) % plot