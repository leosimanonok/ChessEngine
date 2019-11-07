classdef Bishop < handle
    %UNTITLED7 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        AvailMoves;
         value ;
         white;
         position; %position is a 1 by 2 vector with the piece's position on the board
         row;
         column;
         initial_value=3.25;
    end
    
    methods
        function obj = Bishop(varargin)
            %Bishop(position, white)
            %How we make a new piece- constructors
            %Setting the default position and if white or black
            if (nargin == 1)
                obj.white = varargin{1}.white;
                obj.position = varargin{1}.position;
                obj.row = varargin{1}.position(1);
                obj.column = varargin{1}.position(2);
                obj.AvailMoves = varargin{1}.AvailMoves;
            else
                obj.white = varargin{2};
                obj.position = varargin{1};
                obj.row = varargin{1}(1);
                obj.column = varargin{1}(2);
            end
        end
        
        function findAvailMoves(obj,ChessBoard)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            row = obj.row;
            col = obj.column;
            obj.AvailMoves = {};
                    
            while (((row-1) >= 1) && ((col+1) <= 8)) %moving diagonally to the bottom right
                if (isempty(ChessBoard.Board{row-1,col+1}))
                    obj.AvailMoves{end+1} = [row-1,col+1];
                    col = col+1;
                    row = row-1;
                elseif (ChessBoard.Board{row-1,col+1}.white ~= obj.white)
                    obj.AvailMoves{end+1} = [row-1,col+1];
                    break;
                else
                    break;
                end
            end
            
            row = obj.row;
            col = obj.column;
            
            while (((row+1) <= 8) && ((col+1) <= 8)) %moving to the top right
                if (isempty(ChessBoard.Board{row+1,col+1}))
                    obj.AvailMoves{end+1} = [row+1,col+1];
                    col = col+1;
                    row = row+1;
                elseif (ChessBoard.Board{row+1,col+1}.white ~= obj.white)
                    obj.AvailMoves{end+1} = [row+1,col+1];
                    break;
                else
                    break;
                end
            end
            
            row = obj.row;
            col = obj.column;
            
            while (((row+1) <= 8) && ((col-1) >= 1)) %moving diagonal to the top left
                if (isempty(ChessBoard.Board{row+1,col-1}))
                    obj.AvailMoves{end+1} = [row+1,col-1];
                    col = col-1;
                    row = row+1;
                elseif (ChessBoard.Board{row+1,col-1}.white ~= obj.white)
                    obj.AvailMoves{end+1} = [row+1, col-1];
                    break;
                else
                    break;
                end
            end
            
            row = obj.row;
            col = obj.column;
            
            while (((row-1) >= 1) && ((col-1) >= 1)) %moving diagonal to the bottom left
                if (isempty(ChessBoard.Board{row-1,col-1}))
                    obj.AvailMoves{end+1} = [row-1,col-1];
                    col = col-1;
                    row = row-1;
                elseif (ChessBoard.Board{row-1,col-1}.white ~= obj.white)
                    obj.AvailMoves{end+1} = [row-1,col-1];
                    break;
                else
                    break;
                end
            end
            obj.value=PieceValue(obj);
        end
 
        
            
        function move(Bishop, ChessBoard, newPos)
            % need to make sure moves are legal before calling this funtion
            
            
            if (length(newPos) == 2)
                row = newPos(1);
                col = newPos(2);
            
                ChessBoard.Board{row,col} = Bishop;
                ChessBoard.Board{Bishop.row,Bishop.column} = [];
                Bishop.row = row;
                Bishop.column = col;
            else 
                newPos
                fprintf('Invalid move format.\n');
            end
        end
        
    end
   
end