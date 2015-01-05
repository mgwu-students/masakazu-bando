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
#import "LevelUp.h"

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
    BOOL offscreen;
    NSString* dataType;
    CCNode* _map;
    int _gameProgress;
}
-(void)onEnter{
            data= [GameData sharedData];
    dataType = data.dataType;
    [super onEnter];
        self.userInteractionEnabled = YES;



    
    _gameProgress = [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat: @"%@%@",@"GameProgess",dataType]];
    
    for(int i = 1 ;i>=_gameProgress/9;i--)
    {
        if(_gameProgress>(i*9))
        {
            for(int j = 8;j>=_gameProgress%9;j--)
            {
                [[[_map.children[i] children] objectAtIndex:j] removeFromParent];
            }
        }
        else
        {
            for(int j = 8;j>=0;j--)
            {
                [[[_map.children[i] children] objectAtIndex:j] removeFromParent];
            }
        }

    }
}
#pragma mark-
-(void)touchBegan:(UITouch *)touches withEvent:(UIEvent *)event {


}
-(void)Sorry
{
    LevelUp* yeh = (LevelUp*)[CCBReader load:@"PopUp2" owner:self];
    ((CCLabelTTF*)[[yeh.children[0] children] objectAtIndex:0]).fontSize = (10.0);
    ((CCLabelTTF*)[[yeh.children[0] children] objectAtIndex:0]).string = [NSString stringWithFormat:@"More Levels Coming Soon!"];
    [self addChild:yeh];
}
- (void)Level1 {
    if(!offscreen)
    {
        data.currentLevel = 1;
        offscreen = true;
        NSString* temp = @"LocationForest";
        [self loadScene:temp];
    }
    
}

- (void)Level2 {
    if(!offscreen)
    {
        data.currentLevel = 3;
        offscreen = true;
        NSString* temp = @"LocationForest";
          [self loadScene:temp];
    }
  
}

- (void)Level3 {
    if(!offscreen)
    {
        data.currentLevel = 5;
        offscreen = true;
        [self loadScene:@"LocationSea"];}
}
- (void)Level4 {
    if(!offscreen)
    {
        data.currentLevel = 7;
        offscreen = true;
        [self loadScene:@"LocationMountain"];}
}
- (void)Level5 {
    if(!offscreen)
    {
        data.currentLevel = 9;
        offscreen = true;
        [self loadScene:@"LocationFactory"];}
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
