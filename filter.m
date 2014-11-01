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

r1 = cur_img(y+offset,x,1);
g1 = cur_img(y+offset,x,2);
b1 = cur_img(y+offset,x,3);
r2 = cur_img(y-offset,x,1);
g2 = cur_img(y-offset,x,2);
b2 = cur_img(y-offset,x,3);
r3 = cur_img(y,x+offset,1);
g3 = cur_img(y,x+offset,2);
b3 = cur_img(y,x+offset,3);
r4 = cur_img(y,x-offset,1);
g4 = cur_img(y,x-offset,2);
b4 = cur_img(y,x-offset,3);
counterr = 0;
countery = 0;
counterg = 0;
counterb = 0;
if r1 >= rrl && r1 <= rrh && g1 >= rgl && g1 <= rgh && b1 >= rbl && b1 <= rbh
    counterr = counterr + 1;
end
if r2 >= rrl && r2 <= rrh && g2 >= rgl && g2 <= rgh && b2 >= rbl && b2 <= rbh
    counterr = counterr + 1;
end
if r3 >= rrl && r3 <= rrh && g3 >= rgl && g3 <= rgh && b3 >= rbl && b3 <= rbh
    counterr = counterr + 1;
end
if r4 >= rrl && r4 <= rrh && g4 >= rgl && g4 <= rgh && b4 >= rbl && b4 <= rbh
    counterr = counterr + 1;
end
        
if r1 >= grl && r1 <= grh && g1 >= ggl && g1 <= ggh && b1 >= gbl && b1 <= gbh
    counterg = counterg + 1;
end
if r2 >= grl && r2 <= grh && g2 >= ggl && g2 <= ggh && b2 >= gbl && b2 <= gbh
    counterg = counterg + 1;
end
if r3 >= grl && r3 <= grh && g3 >= ggl && g3 <= ggh && b3 >= gbl && b3 <= gbh
    counterg = counterg + 1;
end
if r4 >= grl && r4 <= grh && g4 >= ggl && g4 <= ggh && b4 >= gbl && b4 <= gbh
    counterg = counterg + 1;
end

if r1 >= yrl && r1 <= yrh && g1 >= ygl && g1 <= ygh && b1 >= ybl && b1 <= ybh
    countery = countery + 1;
end
if r2 >= yrl && r2 <= yrh && g2 >= ygl && g2 <= ygh && b2 >= ybl && b2 <= ybh
    countery = countery + 1;
end
if r3 >= yrl && r3 <= yrh && g3 >= ygl && g3 <= ygh && b3 >= ybl && b3 <= ybh
    countery = countery + 1;
end
if r4 >= yrl && r4 <= yrh && g4 >= ygl && g4 <= ygh && b4 >= ybl && b4 <= ybh
    countery = countery + 1;
end

if r1 >= brl && r1 <= brh && g1 >= bgl && g1 <= bgh && b1 >= bbl && b1 <= bbh
    counterb = counterb + 1;
end
if r2 >= brl && r2 <= brh && g2 >= bgl && g2 <= bgh && b2 >= bbl && b2 <= bbh
    counterb = counterb + 1;
end
if r3 >= brl && r3 <= brh && g3 >= bgl && g3 <= bgh && b3 >= bbl && b3 <= bbh
    counterb = counterb + 1;
end
if r4 >= brl && r4 <= brh && g4 >= bgl && g4 <= bgh && b4 >= bbl && b4 <= bbh
    counterb = counterb + 1;
end
        
if counterr > 2 
    valu = 1;
elseif counterg > 2
    valu = 2;
elseif countery > 2
    valu = 3;
elseif counterb > 2 
    valu = 4;
end
