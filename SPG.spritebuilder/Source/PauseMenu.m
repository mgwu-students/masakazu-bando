//
//  PauseMenu.m
//  SPG
//
//  Created by sloot on 7/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "PauseMenu.h"
#import "SwipeSet.h"
#import "Tutorial.h"
#import "GameData.h"


@implementation PauseMenu
{
    CCNode* _configbutton;
    GameData* data;
}
- (void)onEnter
{
    
    [super onEnter];
  data= [GameData sharedData];
        self.userInteractionEnabled = YES;
    [self cursorStart];
    [self addTutorial];
}
-(void)addTutorial
{
    Tutorial* myTutorial = (Tutorial*)[CCBReader load:@"TutorialBackground"];
    myTutorial.physNode = self.physNode;
    [self addChild:myTutorial];
}
-(void)Resume
{
    [self removeFromParent];
    [self physNode].paused = false;
}
-(void)Return
{
    if(data.gameProgress>3||[[NSUserDefaults standardUserDefaults] objectForKey:@"didFinishTutorial"]!=nil)
    {
        CCScene *gameplayScene = [CCBReader loadAsScene:@"LocationSelect"];
        [[CCDirector sharedDirector] replaceScene:gameplayScene];
    }

}

-(void)ConfigureMoves
{
    if(data.gameProgress!=0||[[NSUserDefaults standardUserDefaults] objectForKey:@"didFinishTutorial"]!=nil)
    {
         data.currentTutorialProgress = 0;
        SwipeSet *mySwipeSet = (SwipeSet*)[CCBReader load:@"SwipeSet"];
        mySwipeSet.myMoveNode = self.myMoveNode;
        mySwipeSet.tutorialProgress = self.tutorialProgress;
        mySwipeSet.physnode = self.physNode;
        [self addChild:mySwipeSet];
       
        
    }

}
-(void)touchBegan:(UITouch *)touches withEvent:(UIEvent *)event
{
    NSLog(@"fck this shit");
}
-(void)cursorStart
{
    if(self.tutorialProgress==2)
    {
        CCNode* pointer = (CCNode*)[CCBReader load:@"Pointer"];
        pointer.position = ccp(10,-20);
        [[[_configbutton children] objectAtIndex:0] addChild:pointer];
        [self performSelector:@selector(cursorEnd) withObject:nil afterDelay:.3];
    }
    
    
}
-(void)cursorEnd
{
    [[[_configbutton children] objectAtIndex:0] removeAllChildren];

    [self performSelector:@selector(cursorStart) withObject:nil afterDelay:.3];
}
@end
