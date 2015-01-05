//
//  Intro.m
//  SPG
//
//  Created by mike bando on 7/11/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Intro.h"

@implementation Intro
{
    OALSimpleAudio *audio;
}

-(void)onEnter
{
    [super onEnter];
    // access audio object
    audio = [OALSimpleAudio sharedInstance];
    
    // play background sound
    [audio playBg:@"INTRO.mp3" loop:TRUE];
    
    [audio preloadEffect:@"click.mp3"];
    
}
-(void)onExit
{
    [super onExit];
       // play background sound
    [audio stopBg];
}
- (void)Start {

       [audio playEffect:@"click.mp3"];
    CCScene *gameplayScene = [CCBReader loadAsScene:@"DataSelect"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}


@end
