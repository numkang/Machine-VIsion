clear all; clc; close all;

bw = im2bw(imread('nut_shell.jpg'),0.2);
s  = regionprops(bw, 'centroid', 'area');
centroids = cat(1, s.Centroid);
area = cat(1, s.Area);
imshow(bw)

hold on
plot(centroids(2:3,1), centroids(2:3,2), 'b*')

txt = strcat('Area: ',num2str(area(2)));
text(centroids(2,1)-50,centroids(2,2)+120,txt)
txt = strcat('Centroid: [',num2str(centroids(2,2)),', ',num2str(centroids(2,1)),']');
text(centroids(2,1)-50,centroids(2,2)+150,txt)

txt = strcat('Area: ',num2str(area(3)));
text(centroids(3,1)-50,centroids(3,2)+200,txt)
txt = strcat('Centroid: [',num2str(centroids(3,2)),', ',num2str(centroids(3,1)),']');
text(centroids(3,1)-50,centroids(3,2)+230,txt)

text(10,10,'\rightarrow y-axis')
text(0,30,'\downarrow')
text(0,50,'x-axis')
hold off
