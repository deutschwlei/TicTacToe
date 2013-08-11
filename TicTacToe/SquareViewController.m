//
//  SquareViewController.m
//  TicTacToe
//
//  Created by Wilson Lei on 8/10/13.
//  Copyright (c) 2013 Wilson Lei. All rights reserved.
//

#import "SquareViewController.h"

@interface SquareViewController (){
    int squareX;
    int squareY;
}

@end

@implementation SquareViewController

@synthesize squareBtn;
@synthesize delegate;
@synthesize isEmptySquare;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithProp:(int)x y:(int)y
{
    self = [super init];
    if(self){
        squareX = x;
        squareY = y;
        isEmptySquare = YES;
        self.view.frame = CGRectOffset(self.view.frame, x*self.view.frame.size.width, y*self.view.frame.size.height);
    }
    return self;
}

- (void)setSymbol:(int)aSymbol
{
    if(aSymbol == 1){
        [squareBtn setImage:[UIImage imageNamed:@"pieceX"] forState:UIControlStateNormal];
    }
    else if(aSymbol == 2){
        [squareBtn setImage:[UIImage imageNamed:@"pieceO"] forState:UIControlStateNormal];
    }
    isEmptySquare = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [squareBtn addTarget:self action:@selector(onSquareBtnTap:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onSquareBtnTap:(id)sender
{
    if(delegate!=nil && [delegate respondsToSelector:@selector(onSquareViewBtnTap:y:theSquare:)]){
        [delegate onSquareViewBtnTap:squareX y:squareY theSquare:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
