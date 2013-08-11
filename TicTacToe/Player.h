//
//  Player.h
//  TicTacToe
//
//  Created by Wilson Lei on 8/10/13.
//  Copyright (c) 2013 Wilson Lei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic, assign) BOOL isComputer;
@property (nonatomic, assign) BOOL isWinner;
@property (nonatomic, assign) int symbol;

@end
