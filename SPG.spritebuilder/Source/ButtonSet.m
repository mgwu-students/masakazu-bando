//
//  ButtonSet.m
//  SPG
//
//  Created by sloot on 7/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "ButtonSet.h"

@implementation ButtonSet
- (void)onEnter
{

    [super onEnter];
       // accept touches on the grid
    self.userInteractionEnabled = YES;
    NSLog(@"gucci");
}
-(void)touchBegan:(UITouch *)touches withEvent:(UIEvent *)event {
  
        
    NSLog(@"nigahhh");
    
}
@end
