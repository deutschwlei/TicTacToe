//
//  GameModeViewController.m
//  TicTacToe
//
//  Created by Wilson Lei on 8/10/13.
//  Copyright (c) 2013 Wilson Lei. All rights reserved.
//

#import "GameModeViewController.h"

@interface GameModeViewController (){
    NSString *gameMode;
    NSString *startSymbol;
}

@end

@implementation GameModeViewController

@synthesize cancelBtn;
@synthesize createBtn;
@synthesize pvpBtn;
@synthesize pveBtn;
@synthesize pieceOBtn;
@synthesize pieceXBtn;
@synthesize gameModeLabel;
@synthesize startPieceLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        gameMode = @"1";
        startSymbol = @"1";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    [pieceXBtn setSelected:YES];
    [pvpBtn setSelected:YES];
    
    [gameModeLabel setFont:[UIFont fontWithName:@"Lato-Black" size:20.0f]];
    gameModeLabel.shadowColor = [UIColor blackColor];
    gameModeLabel.shadowOffset = CGSizeMake(1.0, 1.0);
    [startPieceLabel setFont:[UIFont fontWithName:@"Lato-Black" size:20.0f]];
    startPieceLabel.shadowColor = [UIColor blackColor];
    startPieceLabel.shadowOffset = CGSizeMake(1.0, 1.0);
    
    [cancelBtn addTarget:self action:@selector(onCancelBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    [createBtn addTarget:self action:@selector(onCreateBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    [pvpBtn addTarget:self action:@selector(onPvpBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    [pveBtn addTarget:self action:@selector(onPveBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    [pieceXBtn addTarget:self action:@selector(onPieceXBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    [pieceOBtn addTarget:self action:@selector(onPieceOBtnTap:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onCancelBtnTap:(id)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"OnGameModeCancel" object:self];
}

- (void)onCreateBtnTap:(id)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"OnGameModeCreate" object:self userInfo:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:gameMode, startSymbol, nil] forKeys:[NSArray arrayWithObjects:@"gameMode", @"startSymbol", nil]]];
}

- (void)onPvpBtnTap:(id)sender
{
    [sender setSelected:YES];
    [pveBtn setSelected:NO];
    gameMode = @"1";
}

- (void)onPveBtnTap:(id)sender
{
    [sender setSelected:YES];
    [pvpBtn setSelected:NO];
    gameMode = @"2";
}

- (void)onPieceXBtnTap:(id)sender
{
    [sender setSelected:YES];
    [pieceOBtn setSelected:NO];
    startSymbol = @"1";
}

- (void)onPieceOBtnTap:(id)sender
{
    [sender setSelected:YES];
    [pieceXBtn setSelected:NO];
    startSymbol = @"2";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
