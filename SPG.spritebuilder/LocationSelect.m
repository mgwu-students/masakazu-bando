//
//  LocationSelect.m
//  SPG
//
//  Created by mike bando on 7/12/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "LocationSelect.h"
#import "MainScene.h"
#import "GameData.h"

@implementation LocationSelect{
    CCSprite* _bossShade;
    CCSprite* _mageShade;
    CCSprite* _golemnShade;
    CCSprite* _goblinShade;
    
    CCSprite* _boss;
    CCSprite* _mage;
    CCSprite* _golemn;
    CCSprite* _goblin;
    GameData* data;
    BOOL* offscreen;
}
-(void)onEnter{
    [super onEnter];
        self.userInteractionEnabled = YES;

    NSArray* allLocations = [NSArray arrayWithObjects:@"LocationForest", @"LocationSky", @"LocationSea", @"LocationFactory", @"LocationMountain", nil];
    
    for(int i = 0;i< allLocations.count;i++)
    {
        if([[NSUserDefaults standardUserDefaults] objectForKey:[allLocations objectAtIndex:i]]==nil)
        {
            [self.children[1] removeFromParent];
        }
    }
}
#pragma mark-
-(void)touchBegan:(UITouch *)touches withEvent:(UIEvent *)event {
    CGPoint positionInScene = [touches locationInNode:self];
    if (CGRectContainsPoint([_goblin boundingBox], positionInScene))
    {
        _goblinShade.opacity = .6;
    }
    else if (CGRectContainsPoint([_golemn boundingBox], positionInScene))
    {
        _golemnShade.opacity = .6;
    }
    else if (CGRectContainsPoint([_mage boundingBox], positionInScene))
    {
        _mageShade.opacity = .6;
    }
    else if (CGRectContainsPoint([_boss boundingBox], positionInScene))
    {
        _bossShade.opacity = .6;
    }

}
- (void)touchMoved:(UITouch *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchEnded:(UITouch *)touches withEvent:(UIEvent *)event {
    CGPoint positionInScene = [touches locationInNode:self];
    
    if (CGRectContainsPoint([_goblin boundingBox], positionInScene))
    {
        [self Forest];
    }
    else if (CGRectContainsPoint([_golemn boundingBox], positionInScene))
    {
        [self Mountain];
    }
    else if (CGRectContainsPoint([_mage boundingBox], positionInScene))
    {
        [self Sea];
    }
    else if (CGRectContainsPoint([_boss boundingBox], positionInScene))
    {
        [self Sky];
    }
    
    _goblinShade.opacity = 0;

    _golemnShade.opacity = 0;

    _mageShade.opacity = 0;

    _bossShade.opacity = 0;
    
}
- (void)Forest {
    if(!offscreen)
    {
        offscreen = true;
        NSString* temp = @"LocationForest";
          [self loadScene:temp];
    }
  
}
- (void)Mountain {
    if(!offscreen)
    {
        offscreen = true;
        [self loadScene:@"LocationMountain"];}
}
- (void)Sea {
    if(!offscreen)
    {
        offscreen = true;
        [self loadScene:@"LocationSea"];}
}
- (void)Sky {
    if(!offscreen)
    {
        offscreen = true;
        [self loadScene:@"LocationSea"];}
}

- (void)Factory {
    if(!offscreen)
    {
        offscreen = true;
        [self loadScene:@"LocationFactory"];}
}

- (void)Tutorial{
    if(!offscreen)
    {
        offscreen = true;
        [self loadScene:@"Maze"];}
}

-(void)loadScene:(NSString*) scene
{
        data= [GameData sharedData];
     data.levelname = scene;
   
    MainScene *mainScene = (MainScene*)[CCBReader loadAsScene:@"MainScene"];
    
    
    
    
    
    
   
   // MainScene *mainScene = (MainScene*)[[[CCBReader loadAsScene:@"MainScene"] children] objectAtIndex:0];
   // [mainScene doNothing];
    
    
    //[(MainScene*)gameplayScene change];
    
    
  //  [gameplayScene initWithData:(scene) andNext:num];
    
  
    
    
    
    
   
    
    //gameplayScene.numOfSpawnNodes;
    
    
     //( (MainScene*)gameplayScene).levelName = scene;
    
    
    
    
    [[CCDirector sharedDirector] replaceScene:mainScene];
    
}


@end
