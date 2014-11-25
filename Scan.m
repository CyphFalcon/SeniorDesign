function game = Scan()
game.Locations=[15, 45, 90, 135, 165, -155, -120, -90, -60, -25];
game.Colors=[0,0,0,0,0,0,0,0,0,0];
game.key={'0', 'Empty'; '1', 'Red'; '2', 'Green'; '3', 'Yellow'; '4', 'Blue'};

%Don't touch
rrl = 80;
rrh = 125;
rgl = 25;
rgh = 70;
rbl = 50;
rbh = 95;

grl = 38;
grh = 70;
ggl = 45;
ggh = 80;
gbl = 48;
gbh = 85;
%Did not update this block (no yellow check...)
yrl = 150;
yrh = 210;
ygl = 160;
ygh = 210;
ybl = 60;
ybh = 100;

brl = 35;
brh = 88;
bgl = 48;
bgh = 100;
bbl = 90;
bbh = 135;

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
[centers,radii] = imfindcircles(r_fin,[15,35],'Sensitivity', 0.95);
size = length(radii);
i = 1;

while i <= size 
    offset = round(radii(i)*3/4);
    %x1 = 210;
    %x2 = 285;
    %y1 = 45;
    %y2 = 115;
    %cur_img(x1,y1,1) = 255;
    %cur_img(x1,y2,1) = 255;
    %cur_img(x2,y1,1) = 255;
    %cur_img(x2,y2,1) = 255;
    %for j = 0:10
    %    cur_img(x1+j,y1,1) = 255;
    %    cur_img(x1+j,y2,1) = 255;
    %    cur_img(x2-j,y1,1) = 255;
    %    cur_img(x2-j,y2,1) = 255;
    
    %    cur_img(x1,y1-j,1) = 255;
    %    cur_img(x1,y2-j,1) = 255;
    %    cur_img(x2,y1+j,1) = 255;
    %    cur_img(x2,y2+j,1) = 255;
    %end
    
    image(cur_img);
    if centers(i,2) >= 5 && centers(i,2) <= 85 && centers(i,1) >= 170 && centers(i,1) <= 260
        x = round(centers(i,1));
        y = round(centers(i,2));
        filter2;
        game.Colors(10) = valu;
    elseif centers(i,2) >= 130 && centers(i,2) <= 190 && centers(i,1) >= 163 && centers(i,1) <= 223
        x = round(centers(i,1));
        y = round(centers(i,2));
        filter2;
        game.Colors(9) = valu;
    elseif centers(i,2) >= 210 && centers(i,2) <= 285 && centers(i,1) >= 45 && centers(i,1) <= 115
        x = round(centers(i,1));
        y = round(centers(i,2));
        filter2;
        game.Colors(8) = valu;
    elseif centers(i,2) >= 300 && centers(i,2) <= 360 && centers(i,1) >= 150 && centers(i,1) <= 210
        x = round(centers(i,1));
        y = round(centers(i,2));
        filter2;
        game.Colors(7) = valu;
    elseif centers(i,2) >= 420 && centers(i,2) <= 480 && centers(i,1) >= 190 && centers(i,1) <= 260
        x = round(centers(i,1));
        y = round(centers(i,2));
        filter2;
        game.Colors(6) = valu;
    elseif centers(i,2) >= 40 && centers(i,2) <= 105 && centers(i,1) >= 320 && centers(i,1) <= 390
        x = round(centers(i,1));
        y = round(centers(i,2));
        filter2;
        game.Colors(1) = valu;
    elseif centers(i,2) >= 30 && centers(i,2) <= 95 && centers(i,1) >= 440 && centers(i,1) <= 510
        x = round(centers(i,1));
        y = round(centers(i,2));
        filter2;
        game.Colors(2) = valu;
    elseif centers(i,2) >= 190 && centers(i,2) <= 260 && centers(i,1) >= 455 && centers(i,1) <= 520
        x = round(centers(i,1));
        y = round(centers(i,2));
        filter2;
        game.Colors(3) = valu;
    elseif centers(i,2) >= 360 && centers(i,2) <= 435 && centers(i,1) >= 465 && centers(i,1) <= 530
        x = round(centers(i,1));
        y = round(centers(i,2));
        filter2;
        game.Colors(4) = valu;
    elseif centers(i,2) >= 360 && centers(i,2) <= 435 && centers(i,1) >= 335 && centers(i,1) <= 400
        x = round(centers(i,1));
        y = round(centers(i,2));
        filter2;
        game.Colors(5) = valu;
    else
        fprintf('Something unidentified at %d,%d\n',centers(i,1),centers(i,2));
    end
    i = i + 1;
end
