%%HW4P3Q2
% clear
% R=[3 3 5 6;3 4 4 5; 4 5 5 6; 4 5 5 6];
% G=[3 2 3 4; 1 5 3 6;4 5 3 6;2 4 4 5];
% B=[4 2 3 4; 1 4 2 4; 4 3 3 5; 2 3 5 5];
% Picture=zeros(4,4,3);
% Picture(:,:,1)=R;
% Picture(:,:,2)=G;
% Picture(:,:,3)=B;
% MR=mean(mean(R));
% MG=mean(mean(G));
% MB=mean(mean(B));


% 
fanbone=imread('fanbone.bmp');
fanbone=double(fanbone)
R=fanbone(:,:,1);
G=fanbone(:,:,2);
B=fanbone(:,:,3);
MR=mean(mean(R));
MG=mean(mean(G));
MB=mean(mean(B));
Mm=[MR MG MB];
Size=size(R)
N=Size(1,1)
count=1;
variable=1;


while count<=Size(1,1)
    lumpR(count,variable)=(R(count,variable)-MR)*(R(count,variable)-MR);
    lumpG(count,variable)=(G(count,variable)-MG)*(G(count,variable)-MG);
    lumpB(count,variable)=(B(count,variable)-MB)*(B(count,variable)-MB);
    lumpc12(count,variable)=(R(count,variable)-MR)*(G(count,variable)-MG);
    lumpc13(count,variable)=(R(count,variable)-MR)*(B(count,variable)-MB);
    lumpc21(count,variable)=(G(count,variable)-MG)*(R(count,variable)-MR);
    lumpc23(count,variable)=(G(count,variable)-MG)*(B(count,variable)-MB);
    lumpc31(count,variable)=(B(count,variable)-MB)*(R(count,variable)-MR);
    lumpc32(count,variable)=(B(count,variable)-MB)*(G(count,variable)-MG);
    variable=variable+1;
    if variable>Size(1,2)
       variable=1;
    count=count+1;
    end
       
end
c11=sum(sum(lumpR))/N^2;
title('Green Component Image')
c22=sum(sum(lumpG))/N^2;
c33=sum(sum(lumpB))/N^2;
c12=sum(sum(lumpc12))/N^2;
c13=sum(sum(lumpc13))/N^2;
c21=sum(sum(lumpc21))/N^2;
c23=sum(sum(lumpc23))/N^2;
c31=sum(sum(lumpc31))/N^2;
c32=sum(sum(lumpc32))/N^2;
Covariance=[c11 c12 c13; c21 c22 c23; c31 c32 c33];
[Eigenvectors,Eigenvalues]=eig(Covariance);
Deigenvectors=zeros(3,3);
Deigenvectors(:,1)=Eigenvectors(:,3);
Deigenvectors(:,3)=Eigenvectors(:,1);
Deigenvectors(:,2)=Eigenvectors(:,2);
A=Deigenvectors';
MeanR=mean(mean(Covariance));
BigMatrix=[R(:)';G(:)';B(:)'];
subplot(5,3,1)
plot(BigMatrix(1,:),BigMatrix(2,:),'o')
xlabel('R')
ylabel('G')
subplot(5,3,2)
plot(BigMatrix(2,:),BigMatrix(3,:),'o')
xlabel('G')
ylabel('B')
subplot(5,3,3)
plot(BigMatrix(3,:),BigMatrix(1,:),'o')
xlabel('B')
ylabel('R')
for i=1:size(BigMatrix,2)
y(:,i)=A*(BigMatrix(:,i)-Mm');
end
subplot(5,3,4)
title('Green Component Image')
plot(y(1,:),y(2,:),'o')
xlabel('Transformed R')
ylabel('Transformed G')
subplot(5,3,5)
plot(y(2,:),y(3,:),'o')
xlabel('Transformed G')
ylabel('Transformed B')
subplot(5,3,6)
plot(y(3,:),y(1,:),'o')
xlabel('Transformed B')
ylabel('Transformed R')
Nr=reshape(y(1,:),Size(1,1),Size(1,2));
Ng=reshape(y(2,:),Size(1,1),Size(1,2));
Nb=reshape(y(3,:),Size(1,1),Size(1,2));
subplot(5,3,7)
imshow(Nr)
title('Red Component Image')
subplot(5,3,8)
imshow(Ng)
title('Green Component Image')
subplot(5,3,9)
imshow(Nb)
title('Blue Component Image')
counts=1;
while counts<=numel(Nr)
    RFy1(:,counts)=Mm'+[y(1,counts);y(1,counts);y(1,counts)].*Eigenvectors(:,3);
    GFy2(:,counts)=Mm'+[y(2,counts);y(2,counts);y(2,counts)].*Eigenvectors(:,2);
    BFy3(:,counts)=Mm'+[y(3,counts);y(3,counts);y(3,counts)].*Eigenvectors(:,1);
    counts=counts+1;
end

Red1=reshape(RFy1(1,:),350,480);
Red1=Red1+11.4964;
Red1=Red1*(255/314.1317)
Blue1=reshape(RFy1(2,:),350,480);
Blue1=Blue1+11.4964;
Blue1=Blue1*(255/314.1317);
Green1=reshape(RFy1(3,:),350,480);
Green1=Green1+11.4964;
Green1=Green1*(255/314.1317);

Red1=uint8(Red1);
Green1=uint8(Green1);
Blue1=uint8(Blue1);
subplot(5,3,13)
plot3(Red1(:)',Green1(:)',Blue1(:)','or')
xlabel('R')
ylabel('G')
zlabel('B')
title('Projected Red Component in RGB Coordinate')
Pic1(:,:,1)=Red1;
Pic1(:,:,2)=Green1;
Pic1(:,:,3)=Blue1;
subplot(5,3,10)
imshow(Pic1)
title('Red Component Image on RGB Coordinate')
hold all


Red2=reshape(GFy2(1,:),350,480);
Blue2=reshape(GFy2(2,:),350,480);
Green2=reshape(GFy2(3,:),350,480);
Red2=Red2-62.5925;
Red2=Red2*(255/143.7266);
Blue2=Blue2-62.5925;
Blue2=Blue2*(255/143.7266);
Green2=Green2-62.5925;
Green2=Green2*(255/143.7266);
Red2=uint8(Red2);
Green2=uint8(Green2);
Blue2=uint8(Blue2);
Pic2(:,:,1)=Red2;
Pic2(:,:,2)=Green2;
Pic2(:,:,3)=Blue2;
subplot(5,3,14)
plot3(Red2(:)',Green2(:)',Blue2(:)','og')
xlabel('R')
ylabel('G')
zlabel('B')
title('Projected Green Component in RGB Coordinate')
subplot(5,3,11)
imshow(Pic2)
title('Green Component Image on RGB Coordinate')

Red3=reshape(BFy3(1,:),350,480);
Red3=Red3-106.8685;
Red3=Red3*(255/67.4649);
Blue3=reshape(BFy3(2,:),350,480);
Blue3=Blue3-106.8685;
Blue3=Blue3*(255/67.4649)
Green3=reshape(BFy3(3,:),350,480);
Green3=Green3-106.8685;
Green3=Green3*(255/67.4649)
Red3=uint8(Red3);
Green3=uint8(Green3);
Blue3=uint8(Blue3);
subplot(5,3,15)
plot3(Red3(:)',Green3(:)',Blue3(:)','ob')
xlabel('R')
ylabel('G')
zlabel('B')
title('Projected Green Component in RGB Coordinate')
Pic3(:,:,1)=Red3;
Pic3(:,:,2)=Green3;
Pic3(:,:,3)=Blue3;
subplot(5,3,12)
imshow(Pic3)
title('Blue Component Image on RGB Coordinate')

