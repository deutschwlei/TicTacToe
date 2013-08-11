//
//  GameModeViewController.h
//  TicTacToe
//
//  Created by Wilson Lei on 8/10/13.
//  Copyright (c) 2013 Wilson Lei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameModeViewController : UIViewController

@property(nonatomic, weak)IBOutlet UIButton *cancelBtn;
@property(nonatomic, weak)IBOutlet UIButton *createBtn;
@property(nonatomic, weak)IBOutlet UIButton *pvpBtn;
@property(nonatomic, weak)IBOutlet UIButton *pveBtn;
@property(nonatomic, weak)IBOutlet UIButton *pieceXBtn;
@property(nonatomic, weak)IBOutlet UIButton *pieceOBtn;
@property(nonatomic, weak)IBOutlet UILabel *gameModeLabel;
@property(nonatomic, weak)IBOutlet UILabel *startPieceLabel;

@end
