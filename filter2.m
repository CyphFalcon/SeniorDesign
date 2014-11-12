% Archived Values below
%rrl = 130;
%rrh = 180;
%rgl = 35;
%rgh = 65;
%rbl = 70;
%rbh = 110;
%grl = 45;
%grh = 80;
%ggl = 80;
%ggh = 125;
%gbl = 60;
%gbh = 100;
%yrl = 150;
%yrh = 210;
%ygl = 160;
%ygh = 210;
%ybl = 60;
%ybh = 100;
%brl = 50;
%brh = 90;
%bgl = 95;
%bgh = 140;
%bbl = 130;
%bbh = 180;

valu = 0;

%MARKERS
cur_img(y+offset,x,1) = 255;
cur_img(y-offset,x,1) = 255;
cur_img(y,x+offset,1) = 255;
cur_img(y,x-offset,1) = 225;

offsetstartx = x - offset;
offsetstarty = y - offset;
offsetendx = x + offset;
offsetendy = y + offset;

counterr = 0;
countery = 0;
counterg = 0;
counterb = 0;

for k = offsetstarty:offsetendy
    for j = offsetstartx:offsetendx
        r = cur_img(k,j,1);
        g = cur_img(k,j,2);
        b = cur_img(k,j,3);
    if r >= rrl && r <= rrh && g >= rgl && g <= rgh && b >= rbl && b <= rbh
        counterr = counterr + 1;
    end
    if r >= grl && r <= grh && g >= ggl && g <= ggh && b >= gbl && b <= gbh
        counterg = counterg + 1;
    end
    if r >= yrl && r <= yrh && g >= ygl && g <= ygh && b >= ybl && b <= ybh
        countery = coutnery + 1;
    end
    if r >= brl && r <= brh && g >= bgl && g <= bgh && b >= bbl && b <= bbh        
        counterb = counterb + 1;
    end
    end
end

%fprintf('counters: r = %d, g = %d, y = %d, b = %d\n',counterr, counterg, countery, counterb);

if counterr > counterg && counterr > counterb 
    valu = 1;
elseif counterg > counterr && counterg > counterb
    valu = 2;
elseif counterb > counterr && counterb > counterg
    valu = 4;
else
    valu = -2;
end
