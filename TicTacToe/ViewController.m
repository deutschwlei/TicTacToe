//
//  ViewController.m
//  TicTacToe
//
//  Created by Wilson Lei on 8/10/13.
//  Copyright (c) 2013 Wilson Lei. All rights reserved.
//

#import "ViewController.h"
#import "GameViewController.h"
#import "GameModeViewController.h"

@interface ViewController (){
    GameViewController *gameViewController;
    GameModeViewController *gameModeViewController;
}

@end

@implementation ViewController

@synthesize startGameBtn;
@synthesize startGameSmallBtn;

- (void)viewDidLoad
{
    [super viewDidLoad];
    gameViewController = nil;
    gameModeViewController = nil;
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    [startGameBtn addTarget:self action:@selector(onStartGameBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    [startGameSmallBtn addTarget:self action:@selector(onStartGameBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onGameModeCancel:) name:@"OnGameModeCancel" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onGameModeCreate:) name:@"OnGameModeCreate" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onGameCancel:) name:@"OnGameCancel" object:nil];
}

- (void)onGameModeCancel:(NSNotification *)notification
{
    if(gameModeViewController){
        [gameModeViewController.view removeFromSuperview];
        gameModeViewController = nil;
    }
    
}

- (void)onGameModeCreate:(NSNotification *)notification
{
    if(gameModeViewController){
        [gameModeViewController.view removeFromSuperview];
        gameModeViewController = nil;
    }
    if(!gameViewController){
        gameViewController = [[GameViewController alloc]initWithGameMode:[notification.userInfo objectForKey:@"gameMode"] startSymbol:[notification.userInfo objectForKey:@"startSymbol"]];
    }
    
    [self.view addSubview:gameViewController.view];
}

- (void)onGameCancel:(NSNotification *)notification
{
    if(gameViewController){
        [gameViewController.view removeFromSuperview];
        gameViewController = nil;
    }
}

- (void)onStartGameBtnTap:(id)sender
{
    
    if(!gameModeViewController){
        gameModeViewController = [[GameModeViewController alloc]init];
    }
    
    [self.view addSubview:gameModeViewController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
