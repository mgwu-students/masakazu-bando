//
//  GameOver.m
//  SPG
//
//  Created by mike bando on 7/22/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameOver.h"

@implementation GameOver
{
    BOOL offscreen;
}
- (void)Restart {
    if(!offscreen)
    {
        CCScene *gameplayScene = [CCBReader loadAsScene:@"Intro"];
        [[CCDirector sharedDirector] replaceScene:gameplayScene];

    }
}
@end
