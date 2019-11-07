classdef Pawn < handle
    %Pawn-may move up one tile, two at the start, and may take diagonally
    
    
    properties
        AvailMoves;
        value;
        white;
        position; %position is a 1 by 2 vector with the piece's position on the board
        hasMoved;
        row;
        column;
        initial_value=1;
    end
    
    methods
        function obj = Pawn(position,white)
            %Sets up the position of the Pawn
            obj.hasMoved = false;
            obj.white = white;
            obj.position = position;
            obj.row = position(1);
            obj.column = position(2);
            obj.AvailMoves;
            obj.value = 1;
        end
        
        function findAvailMoves (obj, ChessBoard)
            %Finds all the vailable moves for the Pawn
            obj.AvailMoves = {};
            if (obj.white)
                if (~obj.hasMoved) %if the object has already moved
                    if (isempty(ChessBoard.Board{obj.row - 1, obj.column}))
                        obj.AvailMoves{end+1} = [obj.row - 1, obj.column]; %pawn can move up one
                        
                        
                        if (isempty(ChessBoard.Board{obj.row - 2, obj.column})) % only check the double move if the first one is open
                            obj.AvailMoves{end+1} = [obj.row - 2, obj.column];
                        end
                    end
                    
                    %these next two if statements state that if an enemy
                    %object is present diagonally, the pawn may take that
                    %object
                    if (obj.column - 1 >= 1) 
                        if (~isempty(ChessBoard.Board{obj.row - 1, obj.column - 1}))
                            obj.AvailMoves{end+1} =  [obj.row - 1, obj.column - 1];
                        end
                    end
                    if (obj.column + 1 <= 8)
                        if (~isempty(ChessBoard.Board{obj.row - 1, obj.column + 1}))
                            obj.AvailMoves{end+1} =  [obj.row - 1, obj.column + 1];
                        end
                    end
                    
                else %further statements issuing that the pawn may only move up one after its initial move
                    if (isempty(ChessBoard.Board{obj.row - 1, obj.column}))
                        obj.AvailMoves{end+1} = [obj.row - 1, obj.column];
                    end
                    if (obj.column - 1 >= 1)
                        if (~isempty(ChessBoard.Board{obj.row - 1, obj.column - 1}))
                            obj.AvailMoves{end+1} = [obj.row - 1, obj.column - 1];     
                        end
                        
                    end
                    if (obj.column + 1 <= 8)
                        if (~isempty(ChessBoard.Board{obj.row - 1, obj.column + 1}))
                            obj.AvailMoves{end+1} = [obj.row - 1, obj.column + 1];
                        end
                    end
                    
                end
            else % for black pieces, the '-1' has to be a '+1'
                %therefor the following code is a copy-paste of the
                %previous code for the white pawn, with signs adjusted
                if (~obj.hasMoved)
                    if (isempty(ChessBoard.Board{obj.row + 1, obj.column}))
                        obj.AvailMoves{end+1} = [obj.row + 1, obj.column];
                        
                        if (isempty(ChessBoard.Board{obj.row + 2, obj.column})) % only check the double move if the first one is open
                            obj.AvailMoves{end+1} = [obj.row + 2, obj.column];
                        end
                    end
                    
                    if (obj.column + 1 <= 8)
                        if (~isempty(ChessBoard.Board{obj.row + 1, obj.column + 1}))
                            obj.AvailMoves{end+1} =  [obj.row + 1, obj.column + 1];
                        end
                    end
                    if (obj.column - 1 >= 1)
                        if (~isempty(ChessBoard.Board{obj.row + 1, obj.column - 1}))
                            obj.AvailMoves{end+1} =  [obj.row + 1, obj.column - 1];
                        end
                    end
                    
                else
                    if (isempty(ChessBoard.Board{obj.row + 1, obj.column}))
                        obj.AvailMoves{end+1} = [obj.row + 1, obj.column];
                    end
                    if (obj.column + 1 <= 8)
                        if (~isempty(ChessBoard.Board{obj.row + 1, obj.column + 1}))
                            obj.AvailMoves{end+1} = [obj.row + 1, obj.column + 1];
                        end
                        
                    end
                    if (obj.column - 1 >= 1)
                        if (~isempty(ChessBoard.Board{obj.row + 1, obj.column - 1}))
                            obj.AvailMoves{end+1} = [obj.row + 1, obj.column - 1];
                        end
                    end
                    
                end
                
            end
            obj.value=PieceValue(obj); %setting the pawn's value property equal to the called upon function
            
        end
        
    end
end