% Uploading a game Script File
clear; clc; clear classes; close all;

newGame = input('Hey, would you like to import a new game of Chess? ','s');
if (strcmpi(newGame,'y') || strcmpi(newGame,'yes'))
    ChessGame = ChessBoard();
    ChessGame.newGame();
    ChessGame.Board
    whiteScore = [];
    blackScore = [];
    totalScore = [];
    moves=load('ChessMoves.txt'); %Moves found in this file
    size=size(moves);
    gamelength=size(1);
    
   
    for k=1:2:gamelength %main loop of the moves
        if k>=(gamelength-1)
            break
        end
        player1 = moves(k,:) %reads the move for player 1
        ChessGame.movePiece(player1(1:2),player1(3:4))
        player2 = moves(k+1,:) %reads the move for player 2
        ChessGame.movePiece(player2(1:2),player2(3:4))
        fprintf('Here is how the game looks right now! \/\/\/\/')
        ChessGame.Board %displays the board
        [white,black] = Scoring_Board(ChessGame); %Calculating score
        if (white > black)
            fprintf('White is ahead by %.2f points!\n', (white-black));
        elseif (white < black)
            fprintf('Black is ahead by %.2f points!\n', (black-white));
        else
            fprintf('The game is tied!\n')
        end
        %Displays who wins after taking the king
        whiteScore(end+1) = (white - 100);
        blackScore(end+1) = (black - 100);
        totalScore(end+1) = (white-black);
        if (totalScore(end) > 80)
            fprintf('White Wins!')
            break;
        elseif (totalScore(end) < -80)
            fprintf('Black Wins!')
            break;
        end
 
    end
totalScore=totalScore+60;
end
%Sets up the plot
length(totalScore);
numTurns = [1:length(totalScore)];
%Plot of score over turns
plot(numTurns, whiteScore, '-')
hold on
plot(numTurns, blackScore,'--', numTurns, totalScore, '.-');
legend('White', 'Black', 'Total')
title('Score Over the Course of the Game');
xlabel('Turn')
ylabel('Score')
hold off