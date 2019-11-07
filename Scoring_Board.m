function [whiteScore, blackScore] = Scoring_Board(CB)
whiteScore = 0;
blackScore = 0;
for k = 1:8 %loop through all the columns
        for p = 1:8 %Through all the rows
            if isempty(CB.Board{k,p}) %nothing if empty
                
            elseif (CB.Board{k,p}.white)%add to score if a white piece
                CB.Board{k,p}.findAvailMoves(CB);
                whiteScore = whiteScore + PieceValue(CB.Board{k,p});
            else %add to score if a black piece
                CB.Board{k,p}.findAvailMoves(CB);
                blackScore = blackScore + PieceValue(CB.Board{k,p});

            end
        end
end

end