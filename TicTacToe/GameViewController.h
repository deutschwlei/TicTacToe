//
//  GameViewController.h
//  TicTacToe
//
//  Created by Wilson Lei on 8/10/13.
//  Copyright (c) 2013 Wilson Lei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SquareViewController.h"

@interface GameViewController : UIViewController<SquareViewDelegate>

@property (nonatomic, weak) IBOutlet UIView *boardView;
@property (nonatomic, weak) IBOutlet UILabel *winnerMessageLabel;
@property (nonatomic, weak) IBOutlet UILabel *playerWinStatus;
@property (nonatomic, weak) IBOutlet UIButton *backBtn;
@property (nonatomic, weak) IBOutlet UIButton *rematchBtn;

- (id)initWithGameMode:(NSString *)aGameMode startSymbol:(NSString *)aStartSymbol;

@end
