classdef ChessBoard < handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Board;
        WhiteKPos;
        BlackKPos;
    end
    
    methods
        function obj = ChessBoard(varargin)
            % can either make a new chess board by entering 0 arguments, or
            % make a seperate copy of a chess board by entering a
            % chessboard object as an argument
            if (nargin == 1)
                % this is used to make a new Board object that is a copy of
                %  a chessboard that is input into the constructor function
                obj.Board = varargin{1}.Board;
                obj.WhiteKPos = varargin{1}.WhiteKPos;
                obj.BlackKPos = varargin{1}.BlackKPos;
            else
                obj.Board{8,8} = [];
                
            end
            
        end
        
        function newGame(ChessBoard)
            % sets up a new, standard chess board
            ChessBoard.WhiteKPos = [8,5];
            ChessBoard.BlackKPos = [1,5];
            
            K1 = King([1,5], false);
            ChessBoard.Board{1,5} = K1;
            
            K2 = King([8,5], true);
            ChessBoard.Board{8,5} = K2;
            
            for j = 1:8
                P1 = Pawn([2,j], false);
                ChessBoard.Board{2,j} = P1;
                
                P2 = Pawn([7,j], true);
                ChessBoard.Board{7,j} = P2;
            end
            
           B1 = Bishop([1,3], false);
           ChessBoard.Board{1,3} = B1;
         
           B2 = Bishop([1,6], false);
           ChessBoard.Board{1,6} = B2;
           
           B3 = Bishop([8,3], true);
           ChessBoard.Board{8,3} = B3;
           
           B4 = Bishop([8,6], true);
           ChessBoard.Board{8,6} = B4;
           
           R1 = Rook([1,1], false);
           ChessBoard.Board{1,1} = R1;
           
           R2 = Rook([1,8], false);
           ChessBoard.Board{1,8} = R2;
           
           R3 = Rook([8,1], true);
           ChessBoard.Board{8,1} = R3;
           
           R4 = Rook([8,8], true);
           ChessBoard.Board{8,8} = R4;
           
           Q1 = Queen([1,4], false);
           ChessBoard.Board{1,4} = Q1;
           
           Q2 = Queen([8,4], true);
           ChessBoard.Board{8,4} = Q2;
           
           N1 = Knight([1,2], false);
           ChessBoard.Board{1,2} = N1;
           
           N2 = Knight([1,7], false);
           ChessBoard.Board{1,7} = N2;
           
           N3 = Knight([8,2], true);
           ChessBoard.Board{8,2} = N3;
           
           N4 = Knight([8,7], true);
           ChessBoard.Board{8,7} = N4;
           
        end
%         function [startPos, endPos] = findBestMove(ChessBoard)
%         end
        function inCheck = check4Check(ChessBoard, white)
            % function that makes checks to make sure a king, either white
            % or black, is not in check
            inCheck = false;
            % if the function never changes this to true, the function
            % returns fals
            if (white)
                Kpos = ChessBoard.WhiteKPos;
                % making a variable so I didnt have to retype it
                for k = 1:8
                    for p = 1:8
                        if (~isempty(ChessBoard.Board{k,p}) && ~ChessBoard.Board{k,p}.white)
                            ChessBoard.Board{k,p}.findAvailMoves(ChessBoard)
                            for z = 1:length(ChessBoard.Board{k,p}.AvailMoves)
                                if (Kpos == ChessBoard.Board{k,p}.AvailMoves{z})
                                    % if any piece has the position of the
                                    % king as one of their available moves,
                                    % the function returns true
                                    inCheck = true;
                                    return
                                end
                            end
                        end
                    end
                end
            else
                Kpos = ChessBoard.BlackKPos;
                for k = 1:8
                    for p = 1:8
                        if (~isempty(ChessBoard.Board{k,p}) && ChessBoard.Board{k,p}.white)
                            ChessBoard.Board{k,p}.findAvailMoves(ChessBoard)
                            for z = 1:length(ChessBoard.Board{k,p}.AvailMoves)
                                if (Kpos == ChessBoard.Board{k,p}.AvailMoves{z})
                                    % if any piece has the position of the
                                    % king as one of their available moves,
                                    % the function returns true
                                    inCheck = true;
                                    return
                                end
                            end
                        end
                    end
                end
            end
        end
            
        function movePiece(ChessBoard1, startPos, endPos)
            %moves a piece to a new position on the board
            if (isempty(ChessBoard1.Board{startPos(1), startPos(2)}))
                % if their is no piece on the entered move, print an error
                fprintf('ERROR! There is no piece there. Please pick a different move.\n')
                return;  
            end
            
            tempCB = ChessBoard(ChessBoard1);
            %create a copy of the chessboard in a temp variable
            if (ChessBoard1.Board{startPos(1), startPos(2)}.white)
                white = true;
                if (isa(ChessBoard1.Board{startPos(1), startPos(2)},'King'))
                    % if the piece is white and of class King, set a new
                    % king position so we can check that the king isn't
                    % moving into check
                    tempCB.WhiteKPos = endPos;
                end
                
            else
                white = false;
                if (isa(ChessBoard1.Board{startPos(1), startPos(2)},'King'))
                    % if the piece is black and of class King, set a new
                    % king position so we can check that the king isn't
                    % moving into check
                    tempCB.BlackKPos = endPos;
                end
            end
            
            tempCB.Board{endPos(1), endPos(2)} = tempCB.Board{startPos(1), startPos(2)};
            tempCB.Board{startPos(1), startPos(2)} = [];
            % make a copy of the piece in the new position, and then remove
            % the original
            

            while (tempCB.check4Check(white))
                % if the king is in check, ask for a new move
                move = input('If this move is made, your king will be in check. Please select a different move.\n');
                startPos = move(1:2);
                endPos = move(3:4);
                
                tempCB.Board{endPos(1), endPos(2)} = tempCB.Board{startPos(1), startPos(2)};
                tempCB.Board{startPos(1), startPos(2)} = [];
                % recheck if the king is in check
            end
            
               
            ChessBoard1.Board{startPos(1), startPos(2)}.findAvailMoves(ChessBoard1);
            % make sure the piece has its available moves stored
            for k = 1:length(ChessBoard1.Board{startPos(1), startPos(2)}.AvailMoves)
                %iterate through the pieces available moves
                if (endPos == ChessBoard1.Board{startPos(1), startPos(2)}.AvailMoves{k})
                    % if the entered move is a valid move, move the piece
                    if(isa(ChessBoard1.Board{startPos(1), startPos(2)},'King'))
                        %if the piece is of class king, update the king's
                        %position on the board
                        if (white)
                            ChessBoard1.WhiteKPos = endPos;
                        else
                            ChessBoard1.BlackKPos = endPos;
                        end
                    elseif (isa(ChessBoard1.Board{startPos(1), startPos(2)}, 'Pawn'))
                        % if the piece is of class pawn, update the pawn's
                        % hasMoves property, so that it cannot move forward
                        % two anymore
                        ChessBoard1.Board{startPos(1), startPos(2)}.hasMoved = true;
                    end
                    
                    % actually moving the piece, and updating the pieces
                    % properties
                    ChessBoard1.Board{endPos(1), endPos(2)} = ChessBoard1.Board{startPos(1), startPos(2)};
                    ChessBoard1.Board{startPos(1), startPos(2)}.row = endPos(1);
                    ChessBoard1.Board{startPos(1), startPos(2)}.column = endPos(2);
                    ChessBoard1.Board{startPos(1), startPos(2)}.position = endPos;
                    ChessBoard1.Board{startPos(1), startPos(2)} = [];

                    return;
                end

            end
            %if you get here, it means that the move you entered was not in
            %the available moves property of the piece, so it prints an
            %erros
                fprintf('The move you selected is not an available move for the piece.\n')

        end
            
        function [bestScore, startPos, endPos] = calcBestMove(ChessBoard, white)
            % iterates through all piece and all their moves, calculates
            % the score of the new board, and saves the highest score.
            firstPiece = true;
            for k = 1:8
                for p = 1:8
                    if(~isempty(ChessBoard.Board{k,p}) && (ChessBoard.Board{k,p}.white == white))
                        %checks that the spaces has a piece and that the
                        %piece is the right color
                        ChessBoard.Board{k,p}.findAvailMoves(ChessBoard);
                        %finds the available moves of the piece
                        if (~isempty(ChessBoard.Board{k,p}.AvailMoves))
                            for z = 1:length(ChessBoard.Board{k,p}.AvailMoves)
                                % iterates through avail moves
                                if (firstPiece)
                                    %need to initalize all the values so
                                    %that you have something to compare the
                                    %next values to
                                    %saves the starting position, ending
                                    %position and the score
                                    startPos = [k,p];
                                    endPos = ChessBoard.Board{k,p}.AvailMoves{z};
                                    ChessBoard.Board{endPos(1),endPos(2)} = ChessBoard.Board{k,p};
                                    ChessBoard.Board{k,p} = [];

                                    bestScore = Scoring_Board(ChessBoard);
                                    ChessBoard.Board{k,p} = ChessBoard.Board{endPos(1), endPos(2)};
                                    ChessBoard.Board{endPos(1), endPos(2)} = [];
                                    firstPiece = false;
                                else
                                    ChessBoard.Board{k,p}.findAvailMoves(ChessBoard);
                                    tempPos = ChessBoard.Board{k,p}.AvailMoves{z};
                                    ChessBoard.Board{tempPos(1),tempPos(2)} = ChessBoard.Board{k,p};
                                    ChessBoard.Board{k,p} = [];

                                    Score = Scoring_Board(ChessBoard);
                                    ChessBoard.Board{k,p} = ChessBoard.Board{tempPos(1), tempPos(2)};
                                    ChessBoard.Board{tempPos(1), tempPos(2)} = [];

                                    if (Score > bestScore)
                                        %compares the score of this move to
                                        %the best previous score. If the
                                        %score is higher, it saves the new
                                        %score, the starting position, and
                                        %the ending position
                                        startPos = [k,p];
                                        endPos = tempPos;
                                        bestScore = Score;
                                    end
                                end
                                
                            end
                        end
                    end
                end
            end
            bestScore = bestScore - 100;
            %this subtracts the value of the king from the total score,
            %which is how we have it in the main script as well.
        end
                        
    end
end

