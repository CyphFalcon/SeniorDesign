moves = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];
for i = 1:10
    if goal.Colors(i*2-1) == 'R' && game.Colors(i) == 1
        moves(i) = 7;
    elseif goal.Colors(i*2-1) == 'B' && game.Colors(i) == 4
        moves(i) = 7;
    elseif goal.Colors(i*2-1) == 'G' && game.Colors(i) == 2
        moves(i) = 7;
    elseif goal.Colors(i*2-1) == 'E' && game.Colors(i) == 0
        moves(i) = 0;
    else
        moves(i) = game.Colors(i);
    end
end
% Make free moves first (current implementation may hang if all target
% spots are occupied.
b = 1;
stuck = 0;
k = 1;
while (b == 1)
b = 0;
for i = 1:10
    l = 0;
    if moves(i) == 1
        for j = 1:10
            if goal.Colors(j*2-1) == 'R' && moves(j) == 0 && l == 0
                instructions(k,1) = i;
                instructions(k,2) = j;
                l = 1;
                break;
            end
        end
        if (l == 1)
            b = 1;
            moves(j) = 7;
            moves(i) = 0;
            k = k + 1;
        end
    end
    if moves(i) == 2
        for j = 1:10
            if goal.Colors(j*2-1) == 'G' && moves(j) == 0 && l == 0
                instructions(k,1) = i;
                instructions(k,2) = j;
                l = 1;
                break;
            end
        end
        if (l == 1)
            b = 1;
            moves(j) = 7;
            moves(i) = 0;
            k = k + 1;
        end
    end
    if moves(i) == 4
        for j = 1:10
            if goal.Colors(j*2-1) == 'B' && moves(j) == 0 && l == 0
                instructions(k,1) = i;
                instructions(k,2) = j;
                l = 1;
                break;
            end
        end
        if (l == 1)
            b = 1;
            moves(j) = 7;
            moves(i) = 0;
            k = k + 1;
        end
    end
    if b == 0 && i == 10
        % maybe throw a check in here?
       fprintf('hmmm...\n');
       x = 0;
       for a = 1:10
           if moves(a) ~= 7 && moves(a) ~= 0
               x = 15;
               break;
           end
       end
       if x == 15
           %This implies no easy move, shift puzzle
           for a = 1:10 
               if moves(a) ~= 7 && moves(1) ~= 0 && (goal.Colors(a) == 'R' || goal.Colors(a) == 'G' || goal.Colors(a) == 'B')
                   break
               end
           end
           for x = 1:10
               if moves(x) == 0
                   break;
               end
           end
           instructions(k,1) = a;
           instructions(k,2) = x;
           moves(x) = moves(a);
           moves(a) = 0;
           k = k + 1;
           b = 1;
       end
    end
end
    
end
for i = 1:k-1
    b = instructions(i,1);
    instructions(i,1) = game.Locations(b);
    b = instructions(i,2);
    instructions(i,2) = game.Locations(b);
end
