//
//  Intro.m
//  SPG
//
//  Created by mike bando on 7/11/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Intro.h"

@implementation Intro
- (void)Start {
   
    CCScene *gameplayScene = [CCBReader loadAsScene:@"DataSelect"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}
- (void)Test {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"ScrollTest"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

@end
