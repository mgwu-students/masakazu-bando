//
//  PopUp.m
//  SPG
//
//  Created by sloot on 7/30/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "PopUp.h"

@implementation PopUp
{
    BOOL offscreen;
}

- (void)onEnter
{
    [super onEnter];
    self.userInteractionEnabled = YES;
  
}

-(void)touchBegan:(UITouch *)touches withEvent:(UIEvent *)event {}

-(void)Continue
{
    if(!offscreen)
    {
        CCScene *gameplayScene = [CCBReader loadAsScene:@"Location"];
        [[CCDirector sharedDirector] replaceScene:gameplayScene];
        offscreen = true;
    }

    
}

@end
