game.Locations=[15, 45, 90, 135, 165, -155, -120, -90, -60, -25];
game.Colors=[0,0,0,0,0,0,0,0,0,0];
game.key={'0', 'Empty'; '1', 'Red'; '2', 'Green'; '3', 'Yellow'; '4', 'Blue'};

%Don't touch
rrl = 130;
rrh = 180;
rgl = 35;
rgh = 65;
rbl = 70;
rbh = 110;
grl = 45;
grh = 80;
ggl = 80;
ggh = 125;
gbl = 60;
gbh = 100;
yrl = 150;
yrh = 210;
ygl = 160;
ygh = 210;
ybl = 60;
ybh = 100;
brl = 50;
brh = 90;
bgl = 95;
bgh = 140;
bbl = 130;
bbh = 180;

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
result = imsubtract(p_img,c_img);
for i = 1:640;
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
%image(r_fin);
[centers,radii] = imfindcircles(r_fin,[10,30],'Sensitivity', 0.94);
size = length(radii);
i = 1;

while i <= size 
    offset = radii(i)*3/4;
    if centers(i,1) >= 160 && centers(i,1) <= 220 && centers(i,2) >=35 && centers(i,2) <= 95
        x = round(centers(i,1));
        y = round(centers(i,2));
        filter;
        game.Colors(10) = valu;
    elseif centers(i,1) >= 135 && centers(i,1) <= 195 && centers(i,2) >= 138 && centers(i,2) <= 198
        x = round(centers(i,1));
        y = round(centers(i,2));
        filter;
        game.Colors(9) = valu;
    elseif centers(i,1) >= 50 && centers(i,1) <= 110 && centers(i,2) >= 225 && centers(i,2) <= 285
        x = round(centers(i,1));
        y = round(centers(i,2));
        filter;
        game.Colors(8) = valu;
    elseif centers(i,1) >= 130 && centers(i,1) <= 190 && centers(i,2) >= 300 && centers(i,2) <= 360
        x = round(centers(i,1));
        y = round(centers(i,2));
        filter;
        game.Colors(7) = valu;
    elseif centers(i,1) >= 180 && centers(i,1) <= 240 && centers(i,2) >= 410 && centers(i,2) <= 480
        x = round(centers(i,1));
        y = round(centers(i,2));
        filter;
        game.Colors(6) = valu;
    elseif centers(i,1) >= 300 && centers(i,1) <= 360 && centers(i,2) >= 75 && centers(i,2) <= 135
        x = round(centers(i,1));
        y = round(centers(i,2));
        filter;
        game.Colors(1) = valu;
    elseif centers(i,1) >= 406 && centers(i,1) <= 466 && centers(i,2) >= 68 && centers(i,2) <= 128
        x = round(centers(i,1));
        y = round(centers(i,2));
        filter;
        game.Colors(2) = valu;
    elseif centers(i,1) >= 416 && centers(i,1) <= 476 && centers(i,2) >= 214 && centers(i,2) <= 274
        x = round(centers(i,1));
        y = round(centers(i,2));
        filter;
        game.Colors(3) = valu;
    elseif centers(i,1) >= 420 && centers(i,1) <= 480 && centers(i,2) >= 360 && centers(i,2) <= 420
        x = round(centers(i,1));
        y = round(centers(i,2));
        filter;
        game.Colors(4) = valu;
    elseif centers(i,1) >= 300 && centers(i,1) <= 370 && centers(i,2) >= 365 && centers(i,2) <= 430
        x = round(centers(i,1));
        y = round(centers(i,2));
        filter;
        game.Colors(5) = valu;
    end
    i = i + 1;
end
