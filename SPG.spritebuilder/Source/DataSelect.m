//
//  DataSelect.m
//  SPG
//
//  Created by mike bando on 7/12/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "DataSelect.h"
#import "GameData.h"
#import "MainScene.h"

@implementation DataSelect
{
GameData* data;

}
//-(void)saveHighScore:(int) score
//{
//
//    if([[NSUserDefaults standardUserDefaults] objectForKey:@"HighScore"]==nil)
//    {
//        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"HighScore"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
//    
//    
//    if(score>[[NSUserDefaults standardUserDefaults] integerForKey:@"HighScore"])
//    {
//        [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"HighScore"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
//}
- (void)LoadData1 {
   

    if([[NSUserDefaults standardUserDefaults] objectForKey:@"didFinishTutorial"]!=nil)
    {
      
        [self setUp];
        
        CCScene *gameplayScene = [CCBReader loadAsScene:@"LocationSelect"];
        [[CCDirector sharedDirector] replaceScene:gameplayScene];
    }
    else
    {
        [self reset];
          [self setUp];
        
        data.levelname = @"Maze";
        
        MainScene *mainScene = (MainScene*)[CCBReader loadAsScene:@"MainScene"];
            [[CCDirector sharedDirector] replaceScene:mainScene];
    }

  
    
}
-(void)setUp
{
    
     data= [GameData sharedData];
    
    NSArray* allMyAttacks = [NSArray arrayWithObjects:@"Fire",@"BodySwap",@"Bomb",@"Barrier",@"RockSlide", nil];
    
    data.myMoves =   data.myMoves = [[MoveNode alloc] init];
    data.unlockedAttacks = [NSMutableArray array];
    
    for(int i = 0;i<allMyAttacks.count;i++)
    {
        
        if( [[NSUserDefaults standardUserDefaults] objectForKey: [allMyAttacks objectAtIndex:i]]!=nil)
        {
             [data.unlockedAttacks addObject:[allMyAttacks objectAtIndex:i]];
            if(![((NSString*)[[NSUserDefaults standardUserDefaults] objectForKey: [allMyAttacks objectAtIndex:i]]) isEqualToString:@"" ])
            {
                            [self saveAttack:[allMyAttacks objectAtIndex:i] withPattern:[[NSUserDefaults standardUserDefaults] objectForKey: [allMyAttacks objectAtIndex:i]]];
            }

             
        }
    }
    
    
    data.unlockedCharacter = [NSMutableArray array];
    data.unlockedCharacterExp = [NSMutableArray array];
    

}
-(void)resetGame
{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"didFinishTutorial"];
     [[NSUserDefaults standardUserDefaults] synchronize];
    [self LoadData1];
}
-(void)reset
{
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"Coins"];
    [[NSUserDefaults standardUserDefaults] setObject:@"Ghost" forKey:@"CreatureType"];
    [[NSUserDefaults standardUserDefaults] setObject:@"rr" forKey:@"Fire"];
    [[NSUserDefaults standardUserDefaults] setObject:@"dd" forKey:@"BodySwap"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"Bomb"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"RockSlide"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"Barrier"];
    
    NSArray* allLocations = [NSArray arrayWithObjects:@"LocationForest", @"LocationSky", @"LocationSea", @"LocationFactory", @"LocationMountain", nil];
    
    for(int i = 0;i< allLocations.count;i++)
    {
         [[NSUserDefaults standardUserDefaults] setObject:nil forKey:[allLocations objectAtIndex:i] ];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];

    
    
//        if([prefs objectForKey:@"HighScore"]==nil)
//        {
//            [prefs setInteger:0 forKey:@"HighScore"];
//            [prefs synchronize];
//        }
//    
//    
//        if(score>[prefs integerForKey:@"HighScore"])
//        {
//            [prefs setInteger:score forKey:@"HighScore"];
//            [prefs synchronize];
//        }
    
    
}
-(void)default
{
   
   

   

    
     
    

   }

-(void)saveAttack:(NSString*)attk withPattern:(NSString*) str
{
    MoveNode* _attemptingMove = data.myMoves;
    NSString* moveString = str;
    while(moveString.length>0)
    {
        
        if([moveString characterAtIndex:(0)]=='r')
        {
            if(_attemptingMove.Right==nil)
            {
                _attemptingMove.Right = [[MoveNode alloc] init];
                
            }
            _attemptingMove = _attemptingMove.Right;
            
            
        }
        else if([moveString characterAtIndex:(0)]=='l')
        {
            if(_attemptingMove.Left==nil)
            {
                _attemptingMove.Left = [[MoveNode alloc] init];
                
            }
            _attemptingMove = _attemptingMove.Left;
            
        }
        else if([moveString characterAtIndex:(0)]=='u')
        {
            if(_attemptingMove.Up==nil)
            {
                _attemptingMove.Up = [[MoveNode alloc] init];
                
            }
            _attemptingMove = _attemptingMove.Up;
            
        }
        
        else if([moveString characterAtIndex:(0)]=='d')
        {
            if(_attemptingMove.Down==nil)
            {
                _attemptingMove.Down = [[MoveNode alloc] init];
                
            }
            _attemptingMove = _attemptingMove.Down;
            
        }
        moveString = [moveString substringFromIndex:(1)];
    }
    
    _attemptingMove.attack = attk;
    
}
@end
