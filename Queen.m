classdef Queen < handle
    %Queen- can move in any direction
    
    properties
        AvailMoves;
         value ;
         white;
         position; %position is a 1 by 2 vector with the piece's position on the board
         row;
         column;
         initial_value=9;
    end
    
    methods
        function obj = Queen(varargin)
            %Sets up the position of the Queen
            %Queen(position, white)
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
            %finds all the available moves for the Queen
            row = obj.row;
            col = obj.column;
            obj.AvailMoves = {};

          
            while ((row-1) >= 1) %Moving up in a column
                
                    if (isempty(ChessBoard.Board{row-1,col}))
                        obj.AvailMoves{end+1} = [row-1,col];
                        row = row - 1;
                    elseif (ChessBoard.Board{row-1,col}.white ~= obj.white)
                        obj.AvailMoves{end+1} = [row-1,col];
                        break;
                    else
                        break;
                    end
              
                
            end
            
            row = obj.row;
            col = obj.column;
            
            while ((row+1) <= 8) %moving down in a column
                if (isempty(ChessBoard.Board{row+1,col}))
                    obj.AvailMoves{end+1} = [row+1,col];
                    row = row + 1;
                elseif (ChessBoard.Board{row+1,col}.white ~= obj.white)
                    obj.AvailMoves{end+1} = [row+1,col];
                    break;
                else 
                    break;
                end
            end
            
            row = obj.row;
            col = obj.column;
            
            while ((col+1) <= 8) %moving left in a row
                if (isempty(ChessBoard.Board{row,col+1}))
                    obj.AvailMoves{end+1} = [row, col+1];
                    col = col + 1;
                elseif (ChessBoard.Board{row,col+1}.white ~= obj.white)
                    obj.AvailMoves{end+1} = [row, col+1];
                    break;
                else
                    break;
                end
            end
            
            row = obj.row;
            col = obj.column;
            
            while ((col-1) >= 1) %moving right in a row
                if (isempty(ChessBoard.Board{row,col-1}))
                    obj.AvailMoves{end+1} = [row,col-1];
                    col = col-1;
                elseif (ChessBoard.Board{row,col-1}.white ~= obj.white)
                    obj.AvailMoves{end+1} = [row,col-1];
                    break;
                else 
                    break;
                end
            end
            
            row = obj.row;
            col = obj.column;
                    
            while (((row-1) >= 1) && ((col+1) <= 8)) %moving diagonally northwest
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
            
            while (((row+1) <= 8) && ((col+1) <= 8)) %moving diagonally southwest
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
            
            while (((row+1) <= 8) && ((col-1) >= 1)) %moving diagonally southeast
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
            
            while (((row-1) >= 1) && ((col-1) >= 1)) %moving diagonally northeast
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
            obj.value=PieceValue(obj); %calling the piecevalue function to give the queen its value property
           
        end
                
            
            
        end  
        
end