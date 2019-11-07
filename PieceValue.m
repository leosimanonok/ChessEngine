function [pieceValue] = PieceValue(Piece)
%PieceValue- returns the value of a piece according to the type of piece
%and the number of moves it can make
%Input [initial_value, AvailMoves]
initial_value = Piece.initial_value; %set the function variable initial_value to the initial_value property
a=length(Piece.AvailMoves);%we base our value of a piece on how many moves it can make, or how much it controls the board
if a==0
    pieceValue=.8*initial_value;
elseif a>=1 & a<=3
    pieceValue=initial_value+.05*a;
elseif a>=4 & a<=7
    pieceValue=initial_value+.1*a;
elseif a>=8
    pieceValue=initial_value+.15*a;
end
    %as the available moves go up, the pieceValue does as well
end

