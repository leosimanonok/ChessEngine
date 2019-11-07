classdef Rook < handle
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Hidden)
         AvailMoves;
         value ;
         white;
         position; %position is a 1 by 2 vector with the piece's position on the board
         hasMoved;
         row;
         column;
         initial_value=5;
    end
    
    methods 
        function obj = Rook(varargin)
            %UNTITLED3 Construct an instance of this class
            %   Detailed explanation goes here
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

          
            while ((row-1) >= 1) %moving upwards
                
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
            
            while ((row+1) <= 8) %moving downwards
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
            
            while ((col+1) <= 8) %moving to the right
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
            
            while ((col-1) >= 1) %moving to the left
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
            obj.value=PieceValue(obj);
            
        
                    
         end
                    %END HERE
        function move(Rook, ChessBoard, newPos)
            Rook.findAvailMoves(ChessBoard)
            %must check all possible moves to see if a move is valid
            for z = 1:length(Rook.AvailMoves)
                if (newPos == Rook.AvailMoves{z})
                    ChessBoard.Board{newPos(1), newPos(2)} = Rook;
                    ChessBoard.Board{Rook.row,Rook.column} = [];
                    Rook.row = newPos(1);
                    Rook.column = newPos(2);
                    return;
                    
                end 
            end
            fprintf('ERROR! The entered move is not an available move for this Rook.\n')
            
        end            
        end
end

        
       
