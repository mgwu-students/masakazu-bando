//
//  GameOver.m
//  SPG
//
//  Created by mike bando on 7/22/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameOver.h"
#import "MainScene.h"

@implementation GameOver
{
    BOOL offscreen;
}
- (void)Restart {
    if(!offscreen)
    {
        CCScene *gameplayScene = [CCBReader loadAsScene:@"LocationSelect"];
        [[CCDirector sharedDirector] replaceScene:gameplayScene];

    }
}
-(void)Retrylevel
{
    
    if(!offscreen)
    {
       MainScene *mainScene = (MainScene*)[CCBReader loadAsScene:@"MainScene"];
        [[CCDirector sharedDirector] replaceScene:mainScene];
        
    }

}
@end
