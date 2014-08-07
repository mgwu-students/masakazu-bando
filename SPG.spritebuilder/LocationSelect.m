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
    GameData* data;
    BOOL* offscreen;
}
-(void)onEnter{
    [super onEnter];
    data= [GameData sharedData];
    NSArray* allLocations = [NSArray arrayWithObjects:@"LocationForest", @"LocationSky", @"LocationSea", @"LocationFactory", @"LocationMountain", nil];
    
    for(int i = 0;i< allLocations.count;i++)
    {
        if([[NSUserDefaults standardUserDefaults] objectForKey:[allLocations objectAtIndex:i]]==nil)
        {
            [self.children[1] removeFromParent];
        }
    }
    
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
        [self loadScene:@"LocationSky"];}
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
