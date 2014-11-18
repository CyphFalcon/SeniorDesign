function goal = verify(game)
s = warning('off','MATLAB:javaclasspath:jarAlreadySpecified');
javaaddpath('C:\Program Files (x86)\ZXing\core\core.jar');
javaaddpath('C:\Program Files (x86)\ZXing\javase\javase.jar');
r = warning('off','MATLAB:intConvertOverflow');
test_encode = captureVideoFrame(10,2);
goal.Colors = decode_qr(test_encode);
warning(s);
warning(r);

r_present = 0;
b_present = 0;
g_present = 0;
r_needed = 0;
b_needed = 0;
g_needed = 0;
for i = 1:10
    if game.Colors(i) == 1
        r_present = r_present + 1;
    end
    if game.Colors(i) == 2
        g_present = g_present + 1;
    end
    if game.Colors(i) == 4
        b_present = b_present + 1;
    end

end
for i = 1:10
    if goal.Colors(i*2-1) == 'R'
        r_needed = r_needed + 1;
    end
    if goal.Colors(i*2-1) == 'G'
        g_needed = g_needed + 1;
    end
    if goal.Colors(i*2-1) == 'B'
        b_needed = b_needed + 1;
    end
end
check = 0;
for i = 1:10
    if goal.Colors(i*2-1) == 'R' && game.Colors(i) == 1
        check = check + 1;
    end
    if goal.Colors(i*2-1) == 'B' && game.Colors(i) == 4
        check = check + 1;
    end
    if goal.Colors(i*2-1) == 'G' && game.Colors(i) == 2
        check = check + 1;
    end
end

%fprintf('Debug: %d, %d, %d vs %d, %d, %d\n',r_present,g_present,b_present,r_needed,g_needed,b_needed);
if r_present < r_needed || b_present < b_needed || g_present < g_needed
    error('The desired configuration cannot be obtained: washers present do not match specifications.');
end

if r_present > r_needed || b_present > b_needed || g_present > b_needed
    error('There''s plenty here to work with! By which I mean, you''ve got too many washers.');
end

if check == (b_needed + g_needed + r_needed)
    error('This puzzle is already solved...');
end
