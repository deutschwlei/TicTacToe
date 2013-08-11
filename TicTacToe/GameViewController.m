//
//  GameViewController.m
//  TicTacToe
//
//  Created by Wilson Lei on 8/10/13.
//  Copyright (c) 2013 Wilson Lei. All rights reserved.
//

#import "GameViewController.h"
#import "Player.h"

@interface GameViewController (){
    int gameMode; //1 for pvp, 2 for pve
    int startSymbol;
    Player *player1;
    Player *player2;
    int symbolXScore;
    int symbolOScore;
    int symbolX;
    int symbolO;
    Player *currentPlayer;
    Player *winner;
    int boardScore[3][3];
    int player1TotalWins;
    int player2TotalWins;
    
    SquareViewController *squareViewControllers[9];
}

@end

@implementation GameViewController

@synthesize winnerMessageLabel;
@synthesize playerWinStatus;
@synthesize backBtn;
@synthesize rematchBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (id)initWithGameMode:(NSString *)aGameMode startSymbol:(NSString *)aStartSymbol
{
    self = [super init];
    if(self){
        gameMode = [aGameMode intValue];
        startSymbol = [aStartSymbol intValue];
        
        symbolOScore = -10;
        symbolXScore = 10;
        symbolX = 1;
        symbolO = 2;
        
        player1TotalWins = 0;
        player2TotalWins = 0;
        
        player1 = [[Player alloc]init];
        player2 = [[Player alloc]init];
        currentPlayer = player1;
        winner = nil;
        
        //set board score to zero
        for(int i=0;i<3;i++){
            for(int j=0;j<3;j++){
                boardScore[i][j] = 0;
                squareViewControllers[i*3+j] = nil;
            }
        }
        
    }
    return self;
}

- (void)resetGame{
    currentPlayer = player1;
    winner = nil;
    
    //set board score to zero
    for(int i=0;i<3;i++){
        for(int j=0;j<3;j++){
            boardScore[i][j] = 0;
            squareViewControllers[i*3+j] = nil;
        }
    }

    for(int i=0;i<[self.boardView.subviews count];i++){
        [[self.boardView.subviews objectAtIndex:i] removeFromSuperview];
    }
    [winnerMessageLabel setText:@""];
    [rematchBtn setHidden:YES];
    [self setupPlayers];
    [self setupBoard];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [winnerMessageLabel setFont:[UIFont fontWithName:@"Lato-Black" size:20]];
    winnerMessageLabel.shadowColor = [UIColor blackColor];
    winnerMessageLabel.shadowOffset = CGSizeMake(1.0, 1.0);

    [self setupPlayers];
    [self setupBoard];
    
    [backBtn addTarget:self action:@selector(onBackBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    [rematchBtn addTarget:self action:@selector(resetGame) forControlEvents:UIControlEventTouchUpInside];
    [rematchBtn setHidden:YES];
}

- (void)onBackBtnTap:(id)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"OnGameCancel" object:self];
}

- (void)setupPlayers
{
    if(gameMode == 2){
        player2.isComputer = YES;
    }
    if(startSymbol == symbolX){
        player1.symbol = symbolX;
        player2.symbol = symbolO;
    }
    else{
        player1.symbol = symbolO;
        player2.symbol = symbolX;
    }
}

- (void)setupBoard
{
    //add square
    for(int i=0;i<3;i++){
        for(int j=0;j<3;j++){
            SquareViewController *aSquare = [[SquareViewController alloc]initWithProp:i y:j];
            squareViewControllers[i*3+j] = aSquare;
            aSquare.delegate = self;
            [self.boardView addSubview:aSquare.view];
        }
    }
}

- (void)showWinnerMessage
{
    if(winner == player1){
        [winnerMessageLabel setText:@"Player 1 Wins!!!"];
        player1TotalWins++;
        
    }
    else if(winner == player2){
        [winnerMessageLabel setText:@"Player 2 Wins!!!"];
        player2TotalWins++;
    }
    else{
        [winnerMessageLabel setText:@"Tied"];
    }
    [playerWinStatus setText:[NSString stringWithFormat:@"P1: %i  P2: %i", player1TotalWins, player2TotalWins]];
    [rematchBtn setHidden:NO];
}

- (BOOL)isThereEmptySquare
{
    for(int i=0;i<3;i++){
        for(int j=0;j<3;j++){
            if(boardScore[i][j]==0){
                return YES;
            }
        }
    }
    return NO;
}

- (int)winningSymbol
{
    int winnerSymbol = 0;
    int bestScore = 0;
    for(int i=0;i<3;i++){
        bestScore = boardScore[i][0] + boardScore[i][1] + boardScore[i][2];
        if(bestScore == 30){
            return symbolX;
        }
        else if(bestScore == -30){
            return symbolO;
        }
    }
    for(int i=0;i<3;i++){
        bestScore = boardScore[0][i] + boardScore[1][i] + boardScore[2][i];
        if(bestScore == 30){
            return symbolX;
        }
        else if(bestScore == -30){
            return symbolO;
        }
    }
    bestScore = boardScore[0][0] + boardScore[1][1] + boardScore[2][2];
    if(bestScore == 30){
        return symbolX;
    }
    else if(bestScore == -30){
        return symbolO;
    }
    bestScore = boardScore[2][0] + boardScore[1][1] + boardScore[0][2];
    if(bestScore == 30){
        return symbolX;
    }
    else if(bestScore == -30){
        return symbolO;
    }
    return winnerSymbol;
}

- (CGPoint)findWinningSquareBySymbol:(int)aSymbol
{
    int bestScore = 0;
    CGPoint aMove = CGPointMake(-1, -1);
    for(int i=0;i<3;i++){
        bestScore = boardScore[i][0] + boardScore[i][1] + boardScore[i][2];
        if((aSymbol == 1 && bestScore >=20) || (aSymbol == 2 && bestScore <= -20)){
            for(int j=0;j<3;j++){
                if(boardScore[i][j] == 0){
                    aMove.x = i;
                    aMove.y = j;
                    return aMove;
                }
            }
        }
    }
    for(int i=0;i<3;i++){
        bestScore = boardScore[0][i] + boardScore[1][i] + boardScore[2][i];
        if((aSymbol == 1 && bestScore >=20) || (aSymbol == 2 && bestScore <= -20)){
            for(int j=0;j<3;j++){
                if(boardScore[j][i] == 0){
                    aMove.x = j;
                    aMove.y = i;
                    return aMove;
                }
            }
        }
    }
    bestScore = boardScore[0][0] + boardScore[1][1] + boardScore[2][2];
    if((aSymbol == 1 && bestScore >=20) || (aSymbol == 2 && bestScore <= -20)){
        for(int j=0;j<3;j++){
            if(boardScore[j][j] == 0){
                aMove.x = j;
                aMove.y = j;
                return aMove;
            }
        }
    }
    bestScore = boardScore[2][0] + boardScore[1][1] + boardScore[0][2];
    if((aSymbol == 1 && bestScore >=20) || (aSymbol == 2 && bestScore <= -20)){
        for(int j=0;j<3;j++){
            if(boardScore[2-j][j] == 0){
                aMove.x = 2-j;
                aMove.y = j;
                return aMove;
            }
        }
    }
    return aMove;
}

- (CGPoint)findPreferSquare
{
    CGPoint aMove = CGPointMake(-1, -1);
    //corners and center
    if(boardScore[1][1]==0){
        aMove.x = 1;
        aMove.y = 1;
        return aMove;
    }
    else if(boardScore[0][0]==0){
        aMove.x = 0;
        aMove.y = 0;
        return aMove;
    }
    else if(boardScore[2][0]==0){
        aMove.x = 2;
        aMove.y = 0;
        return aMove;
    }
    else if(boardScore[0][2]==0){
        aMove.x = 0;
        aMove.y = 2;
        return aMove;
    }
    else if(boardScore[2][2]==0){
        aMove.x = 2;
        aMove.y = 2;
        return aMove;
    }
    return aMove;
}

- (CGPoint)findEmptySquare
{
    CGPoint aMove = CGPointMake(-1, -1);
    for(int i=0;i<3;i++){
        for(int j=0;j<3;j++){
            if(boardScore[i][j]==0){
                aMove.x = i;
                aMove.y = j;
                return aMove;
            }
        }
    }
    return aMove;
}

- (void)onSquareViewBtnTap:(int)x y:(int)y theSquare:(SquareViewController *)theSquare
{
    if(winner == nil){
        if(currentPlayer == player1 && theSquare.isEmptySquare){
            [theSquare setSymbol:player1.symbol];
            if(player1.symbol == 1){
                boardScore[x][y] = symbolXScore;
            }
            else if(player1.symbol == 2){
                boardScore[x][y] = symbolOScore;
            }
            if(player1.symbol == [self winningSymbol]){
                winner = player1;
                [self showWinnerMessage];
            }
            else{
                if(![self isThereEmptySquare]){
                    [self showWinnerMessage];
                }
                else{
                    currentPlayer = player2;
                    if(currentPlayer.isComputer == YES){
                        CGPoint aMove = [self findNextMove];
                        [self onSquareViewBtnTap:aMove.x y:aMove.y theSquare:squareViewControllers[(int)aMove.x*3+(int)aMove.y]];
                    }
                    
                }
            }
            
        }
        else if(currentPlayer == player2 && theSquare.isEmptySquare){
            [theSquare setSymbol:player2.symbol];
            if(player2.symbol == 1){
                boardScore[x][y] = symbolXScore;
            }
            else if(player2.symbol == 2){
                boardScore[x][y] = symbolOScore;
            }
            if(player2.symbol == [self winningSymbol]){
                winner = player2;
                [self showWinnerMessage];
            }
            else{
                if(![self isThereEmptySquare]){
                    [self showWinnerMessage];
                }
                else{
                    currentPlayer = player1;
                }
            }
        }
    }
    
}

//computer
- (CGPoint)findNextMove
{
    CGPoint aMove = CGPointMake(0, 0);

    //check if there is a winning square for computer
    aMove = [self findWinningSquareBySymbol:currentPlayer.symbol];
    if(aMove.x != -1){
        return aMove;
    }
    
    //check if there is a move that can prevent opponet to win
    Player *opponent = player1;
    aMove = [self findWinningSquareBySymbol:opponent.symbol];
    if(aMove.x != -1){
        return aMove;
    }
    
    //check prefer squares
    aMove = [self findPreferSquare];
    if(aMove.x != -1){
        return aMove;
    }
    
    //find any empty square
    aMove = [self findEmptySquare];
    if(aMove.x != -1){
        return aMove;
    }
    return aMove;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
