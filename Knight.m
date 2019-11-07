classdef Knight < handle
    %Knight piece
    %   Detailed explanation goes here
    
    properties
         AvailMoves;
         value ;
         white;
         position; %position is a 1 by 2 vector with the piece's position on the board
         hasMoved;
         row;
         column;
         initial_value=3;
    end
    
    methods 
        function obj = Knight(varargin)
            %Sets up the position of the knight
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
            %finds all the available moves for the piece
            %   Detailed explanation goes here
            row = obj.row;
            col = obj.column;
            obj.AvailMoves = {};

          
            if ((row-1) >= 1) && ((col-2) >= 1) %Up 1 left two
                
                    if (isempty(ChessBoard.Board{row-1,col-2}))
                        obj.AvailMoves{end+1} = [row-1,col-2];

                    elseif (ChessBoard.Board{row-1,col-2}.white ~= obj.white)
                        obj.AvailMoves{end+1} = [row-1,col-2];
                    end

            end
            

            
            if ((row-1) >= 1) && ((col+2) <= 8) %Up 1 right two
                
                    if (isempty(ChessBoard.Board{row-1,col+2}))
                        obj.AvailMoves{end+1} = [row-1,col+2];
                    elseif (ChessBoard.Board{row-1,col+2}.white ~= obj.white)
                        obj.AvailMoves{end+1} = [row-1,col+2];
                    end
              
                
            end
            
            row = obj.row;
            col = obj.column;
            
            if ((row+1) <= 8) && ((col-2) >= 1) %Down 1 left two
                
                    if (isempty(ChessBoard.Board{row+1,col-2}))
                        obj.AvailMoves{end+1} = [row+1,col-2];
                    elseif (ChessBoard.Board{row+1,col-2}.white ~= obj.white)
                        obj.AvailMoves{end+1} = [row+1,col-2];
                    end
              
                
            end

            if ((row+1) <= 8) && ((col+2) <= 8) %Down 1 right two
                
                    if (isempty(ChessBoard.Board{row+1,col+2}))
                        obj.AvailMoves{end+1} = [row+1,col+2];
                    elseif (ChessBoard.Board{row+1,col+2}.white ~= obj.white)
                        obj.AvailMoves{end+1} = [row+1,col+2];
                    end
              
                
            end

            if ((row-2) >= 1) && ((col-1) >= 1) %Up 2 left 1
                
                    if (isempty(ChessBoard.Board{row-2,col-1}))
                        obj.AvailMoves{end+1} = [row-2,col-1];
                    elseif (ChessBoard.Board{row-2,col-1}.white ~= obj.white)
                        obj.AvailMoves{end+1} = [row-2,col-1];
                    end
              
                
            end

            if ((row-2) >= 1) && ((col+1) <= 8) %Up 2 right 1
                
                    if (isempty(ChessBoard.Board{row-2,col+1}))
                        obj.AvailMoves{end+1} = [row-2,col+1];
                    elseif (ChessBoard.Board{row-2,col+1}.white ~= obj.white)
                        obj.AvailMoves{end+1} = [row-2,col+1];
                    end
              
                
            end
            
            if ((row+2) <= 8) && ((col-1) >= 1) %Down 2 left 1
                
                    if (isempty(ChessBoard.Board{row+2,col-1}))
                        obj.AvailMoves{end+1} = [row+2,col-1];
                    elseif (ChessBoard.Board{row+2,col-1}.white ~= obj.white)
                        obj.AvailMoves{end+1} = [row+2,col-1];
                    end
              
                
            end
            
            if ((row+2) <= 8) && ((col+1) <= 8) %Down 2 right 1
                
                    if (isempty(ChessBoard.Board{row+2,col+1}))
                        obj.AvailMoves{end+1} = [row+2,col+1];
                    elseif (ChessBoard.Board{row+2,col+1}.white ~= obj.white)
                        obj.AvailMoves{end+1} = [row+2,col+1];
                    end
              
                
            end
            obj.value=PieceValue(obj);

         end
                    
            function move(Knight, ChessBoard, newPos)
                %checks for valid new positions
            Knight.findAvailMoves(ChessBoard)
            
            for z = 1:length(Knight.AvailMoves) %lists the available moves to see if its a valid mpve
                if (newPos == Knight.AvailMoves{z})
                    ChessBoard.Board{newPos(1), newPos(2)} = Knight;
                    ChessBoard.Board{Knight.row,Knight.column} = [];
                    Knight.row = newPos(1);
                    Knight.column = newPos(2);
                    return;
                end

            end
            fprintf('ERROR! The entered move is not an available move for this Knight.\n')
            
        end
        end
end