game.Locations=[5, 41, 77, 113, 149, -175, -139, -103, -67, -31];
%Need to get actual measurements tomorrow morning...
game.Colors=[0,0,0,0,0,0,0,0,0,0];
game.key={'0', 'Empty'; '1', 'Red'; '2', 'Green'; '3', 'Yellow'; '4', 'Red'};

%Take image of current board...
vid = videoinput('winvideo', 1, 'MJPG_640x480');
set(vid,'TriggerRepeat',Inf);
   vid.FrameGrabInterval = 1;
   pause(1);
   start(vid);
   data = getdata(vid,1);
   cur_img = data(:,:,:,1);
%   image(cur_img);
   stop(vid);

imwrite(cur_img,'current.png');
prev_img = imread('previous.png');

c_img = rgb2gray(cur_img);
p_img = rgb2gray(prev_img);
%image(c_img);
%image(p_img);
%isolate foreground (which isn't what this should be called...)
result = imsubtract(p_img,c_img);
%image(result);
for i = 1:640
        for j = 1:480
           if result(j,i,1) > 20
               result(j,i,1) = 255;
           else
               result(j,i,1) = 0;
           end
        end
end
imwrite(result,'difference.png');
se = strel('square', 5);
r_ero = imdilate(result,se);
r_fin = imerode(r_ero,se);
image(r_fin);
[centers,radii] = imfindcircles(r_fin,[10,30],'Sensitivity', 0.92)
%STATS = regionprops(r_fin,'Area','Centroid','PixelIdxList')
