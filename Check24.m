function Sol = Check24(Vec)
% This function is used to check whether Vec can get 24 via operation set:
% {+, -, *, /} (bracket is allowed)
% Input: Vec, a row vector
% Output: Sol, the procedure of calculation. Operation is represented by
% {a, b, c, d} respectively
% Method: recursion

Sol = [];
LenVec = length(Vec);

if LenVec == 2
    if Vec(1) + Vec(2) == 24
        Sol = 'a12';
    elseif Vec(1) - Vec(2) == 24
        Sol = 'b12';
    elseif Vec(2) - Vec(1) == 24
        Sol = 'b21';
    elseif Vec(1) * Vec(2) == 24
        Sol = 'c12';
    elseif Vec(2) && round(Vec(1) / Vec(2)) == 24
        Sol = 'd12';
    elseif Vec(1) && round(Vec(2) / Vec(1)) == 24
        Sol = 'd21';
    end
else
    for iV1 = 1:(LenVec-1)
        Ele1 = Vec(iV1);
        for iV2 = (iV1+1):LenVec
            Ele2 = Vec(iV2);
            NewVec = Vec;
            NewVec(iV2) = [];
            NewVec(iV1) = [];
            
            tempsol = Check24([Ele1 + Ele2, NewVec]);
            SOLold = tempsol;
            SOLnew = repmat(num2str([iV1, iV2], 'a%d%d'), size(tempsol, 1), ~isempty(tempsol));
            
            tempsol = Check24([Ele1 - Ele2, NewVec]);
            SOLold = [SOLold; tempsol];
            SOLnew = [SOLnew; repmat(num2str([iV1, iV2], 'b%d%d'), size(tempsol, 1), ~isempty(tempsol))];
            
            if Ele1 ~= Ele2
                tempsol = Check24([Ele2 - Ele1, NewVec]);
                SOLold = [SOLold; tempsol];
                SOLnew = [SOLnew; repmat(num2str([iV2, iV1], 'b%d%d'), size(tempsol, 1), ~isempty(tempsol))];
            end
            
            tempsol = Check24([Ele1 * Ele2, NewVec]);
            SOLold = [SOLold; tempsol];
            SOLnew = [SOLnew; repmat(num2str([iV1, iV2], 'c%d%d'), size(tempsol, 1), ~isempty(tempsol))];
            
            if Ele2
                tempsol = Check24([Ele1 / Ele2, NewVec]);
                SOLold = [SOLold; tempsol];
                SOLnew = [SOLnew; repmat(num2str([iV1, iV2], 'd%d%d'), size(tempsol, 1), ~isempty(tempsol))];
            end
            if Ele1
                tempsol = Check24([Ele2 / Ele1, NewVec]);
                SOLold = [SOLold; tempsol];
                SOLnew = [SOLnew; repmat(num2str([iV2, iV1], 'd%d%d'), size(tempsol, 1), ~isempty(tempsol))];
            end
            Sol = [Sol; [SOLnew, SOLold]];
        end
    end
end
end