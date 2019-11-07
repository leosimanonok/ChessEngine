% Main Script File
clear; clc; clear classes; close all;

newGame = input('Hey, would you like to start a new game of Chess? ','s');
if (strcmpi(newGame,'y') || strcmpi(newGame,'yes'))
    %if they type yes or y a new game starts
    ChessGame = ChessBoard();
    %creating new chessboard object
    ChessGame.newGame();
    %setting up a new game
    ChessGame.Board
    %displays the board
    whiteScore = [];
    blackScore = [];
    totalScore = [];
    %vectors which save scores
    player1 = input('Awesome! Please enter your move in the form ''[Starting Coords of Piece, Ending Coords of Piece]'', or enter ''0'' to quit: \n');
    while (player1 ~= 0)
        % if player 1 types '0' the game quits
        ChessGame.movePiece(player1(1:2),player1(3:4))
        player2 = input('Enter Player 2''s next move in the same format: \n');
        ChessGame.movePiece(player2(1:2),player2(3:4))
        fprintf('Here is how the game looks right now!');
        ChessGame.Board
        %outputs the current board
        [white,black] = Scoring_Board(ChessGame);
        %scores the game and outputs who is ahead
        if (white > black)
            fprintf('White is ahead by %.2f points!\n', (white-black));
        elseif (white < black)
            fprintf('Black is ahead by %.2f points!\n', (black-white));
        else
            fprintf('The game is tied!\n')
        end
        
        whiteScore(end+1) = (white - 100);
        blackScore(end+1) = (black - 100);
        totalScore(end+1) = (white-black);
        %adds current score to the array
        if (totalScore(end) > 80)
            %checks to see if someone has taken the opposing player's king,
            %because the king is worth 100 points
            fprintf('White Wins!')
            break;
        elseif (totalScore(end) < -80)
            fprintf('Black Wins!')
            break;
        end
        [bestScore, startPos, endPos] = ChessGame.calcBestMove(true);
        %finds move with best position for white and outputs it
        fprintf('The best move for White is: [%i %i %i %i]. The score after that move will be: %.2f\n', startPos(1), startPos(2), endPos(1), endPos(2), (bestScore - blackScore(end)));
        player1 = input('Enter Player 1''s next move in the same format, or enter ''0'' to quit: \n');
    end
    
else
    fprintf(':(\n')
end

numTurns = 1:length(totalScore);
plot(numTurns, whiteScore, '-')
% a plot of player 1's score
hold on
plot(numTurns, blackScore,'--', numTurns, totalScore, '.-');
% a plot of player 2's score and the total score
legend('White', 'Black', 'Total')
hold off
    