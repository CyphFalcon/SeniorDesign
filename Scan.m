game.Locations=[15, 45, 90, 135, 165, -155, -120, -90, -60, -25];
game.Colors=[0,0,0,0,0,0,0,0,0,0];
game.key={'0', 'Empty'; '1', 'Red'; '2', 'Green'; '3', 'Yellow'; '4', 'Blue'};

%Don't touch
rrl = 100;
rrh = 165;
rgl = 0;
rgh = 52;
rbl = 45;
rbh = 110;
grl = 20;
grh = 85;
ggl = 55;
ggh = 115;
gbl = 35;
gbh = 95;
yrl = 120;
yrh = 185;
ygl = 115;
ygh = 175;
ybl = 30;
ybh = 100;
brl = 35;
brh = 95;
bgl = 60;
bgh = 120;
bbl = 95;
bbh = 160;

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
[centers,radii] = imfindcircles(r_fin,[10,30],'Sensitivity', 0.94)
size = length(radii);
i = 1;

while i <= size 
    if centers(i,1) >= 190 && centers(i,1) <= 215 && centers(i,2) >=35 && centers(i,2) <= 70
        x = round(centers(i,1));
        y = round(centers(i,2));
        r = (cur_img(y-1,x-1,1) + cur_img(y,x-1,1) + cur_img(y+1,x-1,1) + cur_img(y-1,x,1) + cur_img(y,x,1) + cur_img(y+1,x,1) + cur_img(y-1,x+1,1) + cur_img(y,x+1,1) + cur_img(y+1,x+1,1)) / 9;
        g = (cur_img(y-1,x-1,2) + cur_img(y,x-1,2) + cur_img(y+1,x-1,2) + cur_img(y-1,x,2) + cur_img(y,x,2) + cur_img(y+1,x,2) + cur_img(y-1,x+1,2) + cur_img(y,x+1,2) + cur_img(y+1,x+1,2)) / 9;
        b = (cur_img(y-1,x-1,3) + cur_img(y,x-1,3) + cur_img(y+1,x-1,3) + cur_img(y-1,x,3) + cur_img(y,x,3) + cur_img(y+1,x,3) + cur_img(y-1,x+1,3) + cur_img(y,x+1,3) + cur_img(y+1,x+1,3)) / 9;
        if r >= rrl && r <= rrh && g >= rgl && g <= rgh && b >= rbl && b <= rbh
            game.Colors(10) = 1; % Red
        end
        if r >= grl && r <= grh && g >= ggl && g <= ggh && b >= gbl && b <= gbh
            game.Colors(10) = 2; % Green
        end
        if r >= yrl && r <= yrh && g >= ygl && g <= ygh && b >= ybl && b <= ybh
            game.Colors(10) = 3; % Yellow
        end
        if r >= brl && r <= brh && g >= bgl && g <= bgh && b >= bbl && b <= bbh
            game.Colors(10) = 4; % Blue
        end
    elseif centers(i,1) >= 155 && centers(i,1) <= 185 && centers(i,2) >= 145 && centers(i,2) <= 180
        x = round(centers(i,1));
        y = round(centers(i,2));
        r = (cur_img(y-1,x-1,1) + cur_img(y,x-1,1) + cur_img(y+1,x-1,1) + cur_img(y-1,x,1) + cur_img(y,x,1) + cur_img(y+1,x,1) + cur_img(y-1,x+1,1) + cur_img(y,x+1,1) + cur_img(y+1,x+1,1)) / 9;
        g = (cur_img(y-1,x-1,2) + cur_img(y,x-1,2) + cur_img(y+1,x-1,2) + cur_img(y-1,x,2) + cur_img(y,x,2) + cur_img(y+1,x,2) + cur_img(y-1,x+1,2) + cur_img(y,x+1,2) + cur_img(y+1,x+1,2)) / 9;
        b = (cur_img(y-1,x-1,3) + cur_img(y,x-1,3) + cur_img(y+1,x-1,3) + cur_img(y-1,x,3) + cur_img(y,x,3) + cur_img(y+1,x,3) + cur_img(y-1,x+1,3) + cur_img(y,x+1,3) + cur_img(y+1,x+1,3)) / 9;
        if r >= rrl && r <= rrh && g >= rgl && g <= rgh && b >= rbl && b <= rbh
            game.Colors(9) = 1; % Red
        end
        if r >= grl && r <= grh && g >= ggl && g <= ggh && b >= gbl && b <= gbh
            game.Colors(9) = 2; % Green
        end
        if r >= yrl && r <= yrh && g >= ygl && g <= ygh && b >= ybl && b <= ybh
            game.Colors(9) = 3; % Yellow
        end
        if r >= brl && r <= brh && g >= bgl && g <= bgh && b >= bbl && b <= bbh
            game.Colors(9) = 4; % Blue
        end
    elseif centers(i,1) >= 65 && centers(i,1) <= 100 && centers(i,2) >= 220 && centers(i,2) <= 255
        x = round(centers(i,1));
        y = round(centers(i,2));
        r = (cur_img(y-1,x-1,1) + cur_img(y,x-1,1) + cur_img(y+1,x-1,1) + cur_img(y-1,x,1) + cur_img(y,x,1) + cur_img(y+1,x,1) + cur_img(y-1,x+1,1) + cur_img(y,x+1,1) + cur_img(y+1,x+1,1)) / 9;
        g = (cur_img(y-1,x-1,2) + cur_img(y,x-1,2) + cur_img(y+1,x-1,2) + cur_img(y-1,x,2) + cur_img(y,x,2) + cur_img(y+1,x,2) + cur_img(y-1,x+1,2) + cur_img(y,x+1,2) + cur_img(y+1,x+1,2)) / 9;
        b = (cur_img(y-1,x-1,3) + cur_img(y,x-1,3) + cur_img(y+1,x-1,3) + cur_img(y-1,x,3) + cur_img(y,x,3) + cur_img(y+1,x,3) + cur_img(y-1,x+1,3) + cur_img(y,x+1,3) + cur_img(y+1,x+1,3)) / 9;
        if r >= rrl && r <= rrh && g >= rgl && g <= rgh && b >= rbl && b <= rbh
            game.Colors(8) = 1; % Red
        end
        if r >= grl && r <= grh && g >= ggl && g <= ggh && b >= gbl && b <= gbh
            game.Colors(8) = 2; % Green
        end
        if r >= yrl && r <= yrh && g >= ygl && g <= ygh && b >= ybl && b <= ybh
            game.Colors(8) = 3; % Yellow
        end
        if r >= brl && r <= brh && g >= bgl && g <= bgh && b >= bbl && b <= bbh
            game.Colors(8) = 4; % Blue
        end
    elseif centers(i,1) >= 150 && centers(i,1) <= 180 && centers(i,2) >= 305 && centers(i,2) <= 335
        x = round(centers(i,1));
        y = round(centers(i,2));
        r = (cur_img(y-1,x-1,1) + cur_img(y,x-1,1) + cur_img(y+1,x-1,1) + cur_img(y-1,x,1) + cur_img(y,x,1) + cur_img(y+1,x,1) + cur_img(y-1,x+1,1) + cur_img(y,x+1,1) + cur_img(y+1,x+1,1)) / 9;
        g = (cur_img(y-1,x-1,2) + cur_img(y,x-1,2) + cur_img(y+1,x-1,2) + cur_img(y-1,x,2) + cur_img(y,x,2) + cur_img(y+1,x,2) + cur_img(y-1,x+1,2) + cur_img(y,x+1,2) + cur_img(y+1,x+1,2)) / 9;
        b = (cur_img(y-1,x-1,3) + cur_img(y,x-1,3) + cur_img(y+1,x-1,3) + cur_img(y-1,x,3) + cur_img(y,x,3) + cur_img(y+1,x,3) + cur_img(y-1,x+1,3) + cur_img(y,x+1,3) + cur_img(y+1,x+1,3)) / 9;
        if r >= rrl && r <= rrh && g >= rgl && g <= rgh && b >= rbl && b <= rbh
            game.Colors(7) = 1; % Red
        end
        if r >= grl && r <= grh && g >= ggl && g <= ggh && b >= gbl && b <= gbh
            game.Colors(7) = 2; % Green
        end
        if r >= yrl && r <= yrh && g >= ygl && g <= ygh && b >= ybl && b <= ybh
            game.Colors(7) = 3; % Yellow
        end
        if r >= brl && r <= brh && g >= bgl && g <= bgh && b >= bbl && b <= bbh
            game.Colors(7) = 4; % Blue
        end
    elseif centers(i,1) >= 190 && centers(i,1) <= 230 && centers(i,2) >= 410 && centers(i,2) <= 450
        x = round(centers(i,1));
        y = round(centers(i,2));
        r = (cur_img(y-1,x-1,1) + cur_img(y,x-1,1) + cur_img(y+1,x-1,1) + cur_img(y-1,x,1) + cur_img(y,x,1) + cur_img(y+1,x,1) + cur_img(y-1,x+1,1) + cur_img(y,x+1,1) + cur_img(y+1,x+1,1)) / 9;
        g = (cur_img(y-1,x-1,2) + cur_img(y,x-1,2) + cur_img(y+1,x-1,2) + cur_img(y-1,x,2) + cur_img(y,x,2) + cur_img(y+1,x,2) + cur_img(y-1,x+1,2) + cur_img(y,x+1,2) + cur_img(y+1,x+1,2)) / 9;
        b = (cur_img(y-1,x-1,3) + cur_img(y,x-1,3) + cur_img(y+1,x-1,3) + cur_img(y-1,x,3) + cur_img(y,x,3) + cur_img(y+1,x,3) + cur_img(y-1,x+1,3) + cur_img(y,x+1,3) + cur_img(y+1,x+1,3)) / 9;
        if r >= rrl && r <= rrh && g >= rgl && g <= rgh && b >= rbl && b <= rbh
            game.Colors(6) = 1; % Red
        end
        if r >= grl && r <= grh && g >= ggl && g <= ggh && b >= gbl && b <= gbh
            game.Colors(6) = 2; % Green
        end
        if r >= yrl && r <= yrh && g >= ygl && g <= ygh && b >= ybl && b <= ybh
            game.Colors(6) = 3; % Yellow
        end
        if r >= brl && r <= brh && g >= bgl && g <= bgh && b >= bbl && b <= bbh
            game.Colors(6) = 4; % Blue
        end
    elseif centers(i,1) >= 315 && centers(i,1) <= 345 && centers(i,2) >= 80 && centers(i,2) <= 105
        x = round(centers(i,1));
        y = round(centers(i,2));
        r = (cur_img(y-1,x-1,1) + cur_img(y,x-1,1) + cur_img(y+1,x-1,1) + cur_img(y-1,x,1) + cur_img(y,x,1) + cur_img(y+1,x,1) + cur_img(y-1,x+1,1) + cur_img(y,x+1,1) + cur_img(y+1,x+1,1)) / 9;
        g = (cur_img(y-1,x-1,2) + cur_img(y,x-1,2) + cur_img(y+1,x-1,2) + cur_img(y-1,x,2) + cur_img(y,x,2) + cur_img(y+1,x,2) + cur_img(y-1,x+1,2) + cur_img(y,x+1,2) + cur_img(y+1,x+1,2)) / 9;
        b = (cur_img(y-1,x-1,3) + cur_img(y,x-1,3) + cur_img(y+1,x-1,3) + cur_img(y-1,x,3) + cur_img(y,x,3) + cur_img(y+1,x,3) + cur_img(y-1,x+1,3) + cur_img(y,x+1,3) + cur_img(y+1,x+1,3)) / 9;
        if r >= rrl && r <= rrh && g >= rgl && g <= rgh && b >= rbl && b <= rbh
            game.Colors(1) = 1; % Red
        end
        if r >= grl && r <= grh && g >= ggl && g <= ggh && b >= gbl && b <= gbh
            game.Colors(1) = 2; % Green
        end
        if r >= yrl && r <= yrh && g >= ygl && g <= ygh && b >= ybl && b <= ybh
            game.Colors(1) = 3; % Yellow
        end
        if r >= brl && r <= brh && g >= bgl && g <= bgh && b >= bbl && b <= bbh
            game.Colors(1) = 4; % Blue
        end
    elseif centers(i,1) >= 425 && centers(i,1) <= 455 && centers(i,2) >= 75 && centers(i,2) <= 105
        x = round(centers(i,1));
        y = round(centers(i,2));
        r = (cur_img(y-1,x-1,1) + cur_img(y,x-1,1) + cur_img(y+1,x-1,1) + cur_img(y-1,x,1) + cur_img(y,x,1) + cur_img(y+1,x,1) + cur_img(y-1,x+1,1) + cur_img(y,x+1,1) + cur_img(y+1,x+1,1)) / 9;
        g = (cur_img(y-1,x-1,2) + cur_img(y,x-1,2) + cur_img(y+1,x-1,2) + cur_img(y-1,x,2) + cur_img(y,x,2) + cur_img(y+1,x,2) + cur_img(y-1,x+1,2) + cur_img(y,x+1,2) + cur_img(y+1,x+1,2)) / 9;
        b = (cur_img(y-1,x-1,3) + cur_img(y,x-1,3) + cur_img(y+1,x-1,3) + cur_img(y-1,x,3) + cur_img(y,x,3) + cur_img(y+1,x,3) + cur_img(y-1,x+1,3) + cur_img(y,x+1,3) + cur_img(y+1,x+1,3)) / 9;
        if r >= rrl && r <= rrh && g >= rgl && g <= rgh && b >= rbl && b <= rbh
            game.Colors(2) = 1; % Red
        end
        if r >= grl && r <= grh && g >= ggl && g <= ggh && b >= gbl && b <= gbh
            game.Colors(2) = 2; % Green
        end
        if r >= yrl && r <= yrh && g >= ygl && g <= ygh && b >= ybl && b <= ybh
            game.Colors(2) = 3; % Yellow
        end
        if r >= brl && r <= brh && g >= bgl && g <= bgh && b >= bbl && b <= bbh
            game.Colors(2) = 4; % Blue
        end
    elseif centers(i,1) >= 425 && centers(i,1) <= 460 && centers(i,2) >= 225 && centers(i,2) <= 255
        x = round(centers(i,1));
        y = round(centers(i,2));
        r = (cur_img(y-1,x-1,1) + cur_img(y,x-1,1) + cur_img(y+1,x-1,1) + cur_img(y-1,x,1) + cur_img(y,x,1) + cur_img(y+1,x,1) + cur_img(y-1,x+1,1) + cur_img(y,x+1,1) + cur_img(y+1,x+1,1)) / 9;
        g = (cur_img(y-1,x-1,2) + cur_img(y,x-1,2) + cur_img(y+1,x-1,2) + cur_img(y-1,x,2) + cur_img(y,x,2) + cur_img(y+1,x,2) + cur_img(y-1,x+1,2) + cur_img(y,x+1,2) + cur_img(y+1,x+1,2)) / 9;
        b = (cur_img(y-1,x-1,3) + cur_img(y,x-1,3) + cur_img(y+1,x-1,3) + cur_img(y-1,x,3) + cur_img(y,x,3) + cur_img(y+1,x,3) + cur_img(y-1,x+1,3) + cur_img(y,x+1,3) + cur_img(y+1,x+1,3)) / 9;
        if r >= rrl && r <= rrh && g >= rgl && g <= rgh && b >= rbl && b <= rbh
            game.Colors(3) = 1; % Red
        end
        if r >= grl && r <= grh && g >= ggl && g <= ggh && b >= gbl && b <= gbh
            game.Colors(3) = 2; % Green
        end
        if r >= yrl && r <= yrh && g >= ygl && g <= ygh && b >= ybl && b <= ybh
            game.Colors(3) = 3; % Yellow
        end
        if r >= brl && r <= brh && g >= bgl && g <= bgh && b >= bbl && b <= bbh
            game.Colors(3) = 4; % Blue
        end
    elseif centers(i,1) >= 420 && centers(i,1) <= 460 && centers(i,2) >= 375 && centers(i,2) <= 405
        x = round(centers(i,1));
        y = round(centers(i,2));
        r = (cur_img(y-1,x-1,1) + cur_img(y,x-1,1) + cur_img(y+1,x-1,1) + cur_img(y-1,x,1) + cur_img(y,x,1) + cur_img(y+1,x,1) + cur_img(y-1,x+1,1) + cur_img(y,x+1,1) + cur_img(y+1,x+1,1)) / 9;
        g = (cur_img(y-1,x-1,2) + cur_img(y,x-1,2) + cur_img(y+1,x-1,2) + cur_img(y-1,x,2) + cur_img(y,x,2) + cur_img(y+1,x,2) + cur_img(y-1,x+1,2) + cur_img(y,x+1,2) + cur_img(y+1,x+1,2)) / 9;
        b = (cur_img(y-1,x-1,3) + cur_img(y,x-1,3) + cur_img(y+1,x-1,3) + cur_img(y-1,x,3) + cur_img(y,x,3) + cur_img(y+1,x,3) + cur_img(y-1,x+1,3) + cur_img(y,x+1,3) + cur_img(y+1,x+1,3)) / 9;
        if r >= rrl && r <= rrh && g >= rgl && g <= rgh && b >= rbl && b <= rbh
            game.Colors(4) = 1; % Red
        end
        if r >= grl && r <= grh && g >= ggl && g <= ggh && b >= gbl && b <= gbh
            game.Colors(4) = 2; % Green
        end
        if r >= yrl && r <= yrh && g >= ygl && g <= ygh && b >= ybl && b <= ybh
            game.Colors(4) = 3; % Yellow
        end
        if r >= brl && r <= brh && g >= bgl && g <= bgh && b >= bbl && b <= bbh
            game.Colors(4) = 4; % Blue
        end
    elseif centers(i,1) >= 320 && centers(i,1) <= 350 && centers(i,2) >= 365 && centers(i,2) <= 400
        x = round(centers(i,1));
        y = round(centers(i,2));
        r = (cur_img(y-1,x-1,1) + cur_img(y,x-1,1) + cur_img(y+1,x-1,1) + cur_img(y-1,x,1) + cur_img(y,x,1) + cur_img(y+1,x,1) + cur_img(y-1,x+1,1) + cur_img(y,x+1,1) + cur_img(y+1,x+1,1)) / 9;
        g = (cur_img(y-1,x-1,2) + cur_img(y,x-1,2) + cur_img(y+1,x-1,2) + cur_img(y-1,x,2) + cur_img(y,x,2) + cur_img(y+1,x,2) + cur_img(y-1,x+1,2) + cur_img(y,x+1,2) + cur_img(y+1,x+1,2)) / 9;
        b = (cur_img(y-1,x-1,3) + cur_img(y,x-1,3) + cur_img(y+1,x-1,3) + cur_img(y-1,x,3) + cur_img(y,x,3) + cur_img(y+1,x,3) + cur_img(y-1,x+1,3) + cur_img(y,x+1,3) + cur_img(y+1,x+1,3)) / 9;
        if r >= rrl && r <= rrh && g >= rgl && g <= rgh && b >= rbl && b <= rbh
            game.Colors(5) = 1; % Red
        end
        if r >= grl && r <= grh && g >= ggl && g <= ggh && b >= gbl && b <= gbh
            game.Colors(5) = 2; % Green
        end
        if r >= yrl && r <= yrh && g >= ygl && g <= ygh && b >= ybl && b <= ybh
            game.Colors(5) = 3; % Yellow
        end
        if r >= brl && r <= brh && g >= bgl && g <= bgh && b >= bbl && b <= bbh
            game.Colors(5) = 4; % Blue
        end
    end
    i = i + 1;
end
