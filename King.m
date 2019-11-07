classdef King < handle
    %King-can move any direction only one square
    %   May not be taken, or the game is over
    
    properties
        AvailMoves;
        value ;
        white;
        position; %position is a 1 by 2 vector with the piece's position on the board
        hasMoved;
        row;
        column;
        inCheck;
        initial_value=100;
    end
    
    methods
        function obj = King(varargin)
            %Sets up the position of the Queen
            % King(position, white)
            
            if (nargin == 1)
                obj.position = varargin{1}.position;
                obj.row = varargin{1}.position(1);
                obj.column = varargin{1}.position(2);
                obj.white = varargin{1}.white;
                obj.hasMoved = varargin{1}.hasMoved;
                obj.inCheck = varargin{1}.inCheck; % im not sure that we still need this variable
            else
                obj.position = varargin{1};
                obj.row = varargin{1}(1);
                obj.column = varargin{1}(2);
                obj.white = varargin{2};
                obj.hasMoved = false;
                obj.inCheck = false;
            end
        end
        
        function findAvailMoves(obj, ChessBoard)
            obj.AvailMoves = {};
            %finds all the available  moves for the Queen
            row = obj.row;
            col = obj.column;
            white = obj.white;
            
            if ((row+1) <= 8) %moving down a square
                if (isempty(ChessBoard.Board{row+1,col}) || (ChessBoard.Board{row+1,col}.white ~= white))
                    obj.AvailMoves{end+1} = [row+1,col];
                end
            
                if ((col + 1) <= 8) %also moving left a square (diagononally southwest)
                    if (isempty(ChessBoard.Board{row+1,col+1}) || (ChessBoard.Board{row+1,col+1}.white ~= white))
                        obj.AvailMoves{end+1} = [row+1,col+1];
                    end
                end
                if ((col - 1) >= 1) %also moving right a square (diagononally southeast)
                    if (isempty(ChessBoard.Board{row+1,col+1}) || (ChessBoard.Board{row+1,col+1}.white ~= white))
                        obj.AvailMoves{end+1} = [row+1,col-1];
                    end
                end
            end
            if ((col-1) >= 1) %moving right a square
                if (isempty(ChessBoard.Board{row,col-1}) || (ChessBoard.Board{row,col-1}.white ~= white))
                    obj.AvailMoves{end+1} = [row, col-1];
                end
            end
            
            if ((col+1) <= 8) %moving left a square
                if (isempty(ChessBoard.Board{row,col+1}) || (ChessBoard.Board{row,col+1}.white ~= white))
                    obj.AvailMoves{end+1} = [row,col+1];
                end
            end
            
            if ((row-1) >= 1) %moving up a square
                if (isempty(ChessBoard.Board{row-1,col}) || (ChessBoard.Board{row-1,col}.white ~= white))
                    obj.AvailMoves{end+1} = [row-1,col];
                end
                if ((col-1) >= 1) %also moving right a square (diagonally northeast)
                    if (isempty(ChessBoard.Board{row-1,col-1}) || (ChessBoard.Board{row-1,col-1}.white ~= white))
                        obj.AvailMoves{end+1} = [row-1,col-1];
                    end
                end
                
                if ((col+1) <= 8) %also moving left a square (diagonally northwest)
                    if (isempty(ChessBoard.Board{row-1,col+1}) || (ChessBoard.Board{row-1,col+1}.white ~= white))
                        obj.AvailMoves{end+1} = [row-1,col+1];
                    end
                end
            end
        end
                        
            
            
            
            
            
        
        
        function inCheck = check4Check(King,ChessBoard)
            %returns a boolean value of whether or not the king is in check
            inCheck = false;
            white = King.white;
            %this series of if/for statements is checking to make sure the
            %king is in check, and if it is, it must make a move out of
            %check
            if white
                for k = 1:8
                    for p = 1:8
                        if (~isempty(ChessBoard.Board{k,p}) && ~ChessBoard.Board{k,p}.white)
                            ChessBoard.Board{k,p}.findAvailMoves(ChessBoard) % calls the findAvailMoves function on any found during this looping
                            for z = 1:length(ChessBoard.Board{k,p}.AvailMoves)
                                if (King.position == ChessBoard.Board{k,p}.AvailMoves{z})
                                    inCheck = true;
                                    return
                                end
                            end
                        end
                    end
                end
            else
                for k = 1:8
                    for p = 1:8
                        if (~isempty(ChessBoard.Board{k,p}) && ChessBoard.Board{k,p}.white)
                            ChessBoard.Board{k,p}.findAvailMoves(ChessBoard)
                            for z = 1:length(ChessBoard.Board{k,p}.AvailMoves)
                                if (King.position == ChessBoard.Board{k,p}.AvailMoves{z})
                                    inCheck = true;
                                    return
                                end
                            end
                        end
                    end
                end
            end
        end 
                                
                    
        
        
        function move(King, ChessBoard, newPos)
            King.findAvailMoves(ChessBoard)
            %need to make sure the moves are legal before making them
           
            if (King.white) %finding the available moves of the king
                for z = 1:length(King.AvailMoves)
                   if (newPos == King.AvailMoves{z})
                        ChessBoard.Board{newPos(1), newPos(2)} = King;
                        ChessBoard.Board{King.row, King.column} = [];
                        King.position = newPos;
                        King.row = newPos(1);
                        King.column = newPos(2);
                        ChessBoard.WhiteKPos = newPos;
                        return;
                   end
                end
            else
                for z = 1:length(King.AvailMoves)
                   if (newPos == King.AvailMoves{z})
                        ChessBoard.Board{newPos(1), newPos(2)} = King;
                        ChessBoard.Board{King.row, King.column} = [];
                        King.position = newPos;
                        King.row = newPos(1);
                        King.column = newPos(2);
                        ChessBoard.WhiteKPos = newPos;
                        ChessBoard.BlackKPos = newPos;
                        return;
                   end
                end
            end
            
            fprintf('ERROR! The entered move is not an available move for this King.\n')
            
                
           
           end
    end
    
end