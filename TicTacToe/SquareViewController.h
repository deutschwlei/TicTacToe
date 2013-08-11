//
//  SquareViewController.h
//  TicTacToe
//
//  Created by Wilson Lei on 8/10/13.
//  Copyright (c) 2013 Wilson Lei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SquareViewController;
@protocol SquareViewDelegate <NSObject>

@optional
- (void)onSquareViewBtnTap:(int)x y:(int)y theSquare:(SquareViewController *)theSquare;

@end
@interface SquareViewController : UIViewController{
    __weak id<SquareViewDelegate> delegate;
}

@property (nonatomic, weak) IBOutlet UIButton *squareBtn;
@property (nonatomic, weak) id<SquareViewDelegate> delegate;
@property (nonatomic, assign) BOOL isEmptySquare;

- (id)initWithProp:(int)x y:(int)y;
- (void)onSquareBtnTap:(id)sender;
- (void)setSymbol:(int)aSymbol;
@end
