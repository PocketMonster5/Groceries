% This function is used to solve sudoku
% Input: Mi
% Format: a 9*9 matrix whose elements are intergers from 0 to 9. 0
% represents unknown number
% Output: Mo
% Format: a 9*9*N matrix whose elements are intergers from 1 to 9. N
% is the number of different solutions
% Approach: recursion
% Update v1: it can now solve really simple sudoku (unique solution)
%
function Mo = SolveSudoku(Mi)

Mo = Mi;
global MO;
global Area;
MO = [];
Area = [repmat(1:3, 3, 1); repmat(4:6, 3, 1); repmat(7:9, 3, 1)];

% Transform Mi into a 9*9*9 matrix M
M = ones(9, 9, 9);
for rM = 1:9
    for cM = 1:9
        if Mi(rM, cM)
            M(:, cM, Mo(rM, cM)) = 0;
            M(rM, :, Mo(rM, cM)) = 0;
            M(rM, cM, :) = 0;
            M(Area(rM, :), Area(cM, :), Mo(rM, cM)) = 0;
            M(rM, cM, Mo(rM, cM)) = 1;
        end
    end
end

% Solve M recursively
ChangeFlag = 1;
ClearFlag = 0;
% Firstly use simple iterative method
while ChangeFlag
    ChangeFlag = 0;
    ClearFlag = 1;
    for rM = 1:9
        for cM = 1:9
            if ~Mo(rM, cM)
                if sum(M(rM, cM, :)) == 1
                    Mo(rM, cM) = find(M(rM, cM, :), 1);
                    M(:, cM, Mo(rM, cM)) = 0;
                    M(rM, :, Mo(rM, cM)) = 0;
                    M(rM, cM, :) = 0;
                    M(Area(rM, :), Area(cM, :), Mo(rM, cM)) = 0;
                    M(rM, cM, Mo(rM, cM)) = 1;
                    ChangeFlag = 1;
                else
                    ClearFlag = 0;
                end
            end
        end
    end
end
MO(:, :, 1) = Mo;
if ~ClearFlag
    [rM, cM] = find(Mo == 0, 1);
    guessval = find(M(rM, cM, :));
    M_temp = M;
    for iM = 1:length(guessval)
        M = M_temp;
        Mo(rM, cM) = guessval(iM);
        M(:, cM, Mo(rM, cM)) = 0;
        M(rM, :, Mo(rM, cM)) = 0;
        M(rM, cM, :) = 0;
        M(Area(rM, :), Area(cM, :), Mo(rM, cM)) = 0;
        M(rM, cM, Mo(rM, cM)) = 1;
        RecursionSolver(Mo, M);
    end
    MO = MO(:, :, 2:end);
end

% Mo = MO(:, :, 1);
Mo = MO;

end

% This subfunction is used to solve sudoku resursively
function RecursionSolver(Mo, M)

global MO;
global Area;

% Solve M recursively
ChangeFlag = 1;
ClearFlag = 0;
% Firstly use simple iterative method
while ChangeFlag
    ChangeFlag = 0;
    ClearFlag = 1;
    for rM = 1:9
        for cM = 1:9
            if ~Mo(rM, cM)
                if sum(M(rM, cM, :)) == 1
                    Mo(rM, cM) = find(M(rM, cM, :), 1);
                    M(:, cM, Mo(rM, cM)) = 0;
                    M(rM, :, Mo(rM, cM)) = 0;
                    M(rM, cM, :) = 0;
                    M(Area(rM, :), Area(cM, :), Mo(rM, cM)) = 0;
                    M(rM, cM, Mo(rM, cM)) = 1;
                    ChangeFlag = 1;
                else
                    ClearFlag = 0;
                end
            end
        end
    end
end
if ~ClearFlag
    [rM, cM] = find(Mo == 0, 1);
    if all(~M(rM, cM, :))
%         Wrong solution, return NULL
    else
        guessval = find(M(rM, cM, :));
        M_temp = M;
        for iM = 1:length(guessval)
            M = M_temp;
            Mo(rM, cM) = guessval(iM);
            M(:, cM, Mo(rM, cM)) = 0;
            M(rM, :, Mo(rM, cM)) = 0;
            M(rM, cM, :) = 0;
            M(Area(rM, :), Area(cM, :), Mo(rM, cM)) = 0;
            M(rM, cM, Mo(rM, cM)) = 1;
            RecursionSolver(Mo, M);
        end
    end
else
    MO(:, :, size(MO, 3) + 1) = Mo;
end

end