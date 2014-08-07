//
//  Tutorial.m
//  SPG
//
//  Created by sloot on 8/5/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Tutorial.h"
#import "MainScene.h"
#import "GameData.h"
#import "PauseMenu.h"
#import "SwipeSet.h"
#import "Creature.h"

#import "CCActionFollow+CurrentOffset.h"
#define CP_ALLOW_PRIVATE_ACCESS 1
#import "CCPhysics+ObjectiveChipmunk.h"

@implementation Tutorial
{
    int _tutorialProgress;
    CCSprite* _cursor;
    float initialPlayerPosition;
    GameData *data;
    CCPhysicsNode* _physicsNode;
    CCLabelTTF* _mylab;
}
-(void)didLoadFromCCB
{
    //enable physics
    _physicsNode.collisionDelegate = self;
    _cursor.physicsBody.sensor = YES;
}
- (void)onEnter {
    [super onEnter];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"didFinishTutorial"]==nil)
    {
        // accept touches on the grid
        //self.userInteractionEnabled = YES;
        initialPlayerPosition = self.me.position.x;
        data= [GameData sharedData];
        _cursor.rotation = (90.0);
        if(data.gameProgress ==0)
        {
            [self tutorialMoving];
        }
        else if(data.gameProgress ==1)
        {
            [self tutorialAttack];
        }
        else if(data.gameProgress==2)
        {
            [self tutorialAttackEnemy];
        }
        else if(data.gameProgress==4)
        {
            [self teachNewAttack];
        }
    }


}
-(void)onExit
{
    [super onExit];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}
//-(void)touchBegan:(UITouch *)touches withEvent:(UIEvent *)event {
//if(1==1)
//{
//    [(MainScene*)[self parent] touchBegan:touches withEvent:event];
//}
//}
//
//- (void)touchMoved:(UITouch *)touches withEvent:(UIEvent *)event {
//[(MainScene*)[self parent] touchMoved:touches withEvent:event];
//}
//
//- (void)touchEnded:(UITouch *)touches withEvent:(UIEvent *)event {
//    
//[(MainScene*)[self parent] touchEnded:touches withEvent:event];
//    
//}
-(void)tutorialAttackEnemy
{

}
-(void)teachNewAttack
{

if([self.parent isKindOfClass:[PauseMenu class]])
{
    if(data.gameProgress==4)
    {_cursor.rotation = (90.0);
        _cursor.position = ccp(300.0f,110.0f);
        [ _cursor.physicsBody setVelocity:ccp(0,10)];
        [self performSelector:@selector(teachNewAttack) withObject:nil afterDelay:.5f];
    }
    else
    {_cursor.rotation = (90.0);
        _cursor.position = ccp(60,240);
        [ _cursor.physicsBody setVelocity:ccp(0,10)];
        [self performSelector:@selector(teachNewAttack) withObject:nil afterDelay:.5f];
    }
}

else if([self.parent isKindOfClass:[SwipeSet class]])
{
    if(data.gameProgress==4)
    {
        _mylab.color = [CCColor blackColor];
          _mylab.string = @"Select New Attack";
        _cursor.rotation = (90.0);
        _cursor.position = ccp(490.0, 140.0);
        [ _cursor.physicsBody setVelocity:ccp(0,10)];
        [self performSelector:@selector(teachNewAttack) withObject:nil afterDelay:.5f];
    }
    else
        
    {
        _mylab.color = [CCColor blackColor];
          _mylab.string = @"Swipe pattern and save";
        _cursor.rotation = (90.0);
        _cursor.position = ccp(60.0, 240.0);
        [ _cursor.physicsBody setVelocity:ccp(0,10)];
        [self performSelector:@selector(teachNewAttack) withObject:nil afterDelay:.5f];
    }
    
}

}
-(void)tutorialMoving
{

    if([self.parent isKindOfClass:[MainScene class]])
    {
        if(data.currentTutorialProgress == 2)
        {
          
            data.gameProgress = 1;
              data.currentTutorialProgress = 0;
            [_cursor.physicsBody setVelocity:ccp(0,0)];
            [self tutorialAttack];
        }
        else if(data.currentTutorialProgress==1)
        {
            

          
            [self swipeattack];
            
        }
        else
        {
            if(((MainScene*)[self parent]).playerMoved)
            {
                _mylab.string = @"Attack the Enemy";
                data.currentTutorialProgress = 1;
                Creature* enemy = (Creature*)[CCBReader load:@"Spider"];
                enemy.physicsBody.sensor = true;
                enemy.physicsBody.affectedByGravity = false;
                enemy.physicsBody.collisionGroup = @"bad";
                enemy.physicsBody.collisionType = @"dummy";
                enemy.position = ccp(400,50);
                
                
                 [self.physNode addChild:enemy];
                
                

                
                [self performSelector:@selector(tutorialMoving) withObject:nil afterDelay:.1f];
            }
            else
            {
                  _mylab.string = @"Tap to Move";
                _cursor.rotation = (90.0);
                _cursor.position= ccp(180.0f,25.0f);
                [ _cursor.physicsBody setVelocity:ccp(0,10)];
                [self performSelector:@selector(tutorialMoving) withObject:nil afterDelay:.5f];
                
            }

            
        }
    }
    

 }
-(void)tutorialAttack
{
    
        if([self.parent isKindOfClass:[MainScene class]])
        {
            
            if(data.gameProgress<2)
            {
//                _cursor.rotation = (90.0);
//                _cursor.position= ccp(50.0f,250.0f);
//                 [ _cursor.physicsBody setVelocity:ccp(0,10)];
//                [self performSelector:@selector(tutorialAttack) withObject:nil afterDelay:.5f];
                data.gameProgress = 2;
                _mylab.string = @"Swap Bodies";
                [self swipe2];
            }
            else
            {

                
                [self swipe2];
            }

        }
        else if([self.parent isKindOfClass:[PauseMenu class]])
        {
            if(data.gameProgress!=2)
            {
                _cursor.rotation = (90.0);
                _cursor.position = ccp(300.0f,110.0f);
                [ _cursor.physicsBody setVelocity:ccp(0,10)];
                [self performSelector:@selector(tutorialAttack) withObject:nil afterDelay:.5f];
            }
            else
            {
                _cursor.rotation = (90.0);
                _cursor.position = ccp(60,240);
                [ _cursor.physicsBody setVelocity:ccp(0,10)];
                [self performSelector:@selector(tutorialAttack) withObject:nil afterDelay:.5f];
            }
        }
        else if([self.parent isKindOfClass:[SwipeSet class]])
        {
            if(data.currentTutorialProgress==0)
            {
                _cursor.rotation = (90.0);
                _cursor.position = ccp(490.0, 190.0);
                   [ _cursor.physicsBody setVelocity:ccp(0,10)];
                [self performSelector:@selector(tutorialAttack) withObject:nil afterDelay:.5f];

            }
            else
            {
                [self swipe];
                
            }
            
        }

    
}
-(void)swipe
{
    if(data.gameProgress==1)
    {
        _cursor.position = ccp(190.0, 230.0);
        [_cursor.physicsBody setVelocity:ccp(0,-100)];
        [self performSelector:@selector(swipe) withObject:nil afterDelay:2.0f];
    }
    else
    {
        _cursor.position = ccp(60.0, 260.0);
          [ _cursor.physicsBody setVelocity:ccp(0,10)];
         [self performSelector:@selector(swipe) withObject:nil afterDelay:.5f];
    }
}
-(void)swipe2
{
    if(data.gameProgress==3)
    {
        _mylab.string = @"Defeat all Enemies";
        Creature* enemy = (Creature*)[CCBReader load:@"Spider"];
        enemy.physicsBody.sensor = true;
        enemy.physicsBody.affectedByGravity = false;
        enemy.physicsBody.collisionGroup = @"bad";
        enemy.physicsBody.collisionType = @"dummy";
        enemy.position = ccp(100,50);
        
        
        [self.physNode addChild:enemy];
        
        Creature* enemy2 = (Creature*)[CCBReader load:@"Spider"];
        enemy2.physicsBody.sensor = true;
        enemy2.physicsBody.affectedByGravity = false;
        enemy2.physicsBody.collisionGroup = @"bad";
        enemy2.physicsBody.collisionType = @"dummy";
        enemy2.position = ccp(200,50);
        
        
        [self.physNode addChild:enemy2];
        
        Creature* enemy3 = (Creature*)[CCBReader load:@"Spider"];
        enemy3.physicsBody.sensor = true;
        enemy3.physicsBody.affectedByGravity = false;
        enemy3.physicsBody.collisionGroup = @"bad";
        enemy3.physicsBody.collisionType = @"dummy";
        enemy3.position = ccp(300,50);
        
        
        [self.physNode addChild:enemy3];
        
        [self didKillEnemy];
        

    }
    else if(data.gameProgress==2)
    {
        _cursor.rotation = (-90.0);
        _cursor.position = ccp(190.0, 230.0);
        [_cursor.physicsBody setVelocity:ccp(0,-100)];
        [self performSelector:@selector(cursoronEnemy) withObject:nil afterDelay:2.0f];
    }
    else
    {
        _cursor.rotation = (90.0);
        _cursor.position = ccp(60.0, 260.0);
              [ _cursor.physicsBody setVelocity:ccp(0,10)];
        [self performSelector:@selector(swipe2) withObject:nil afterDelay:.5f];
        
    }
}
-(void)didKillEnemy
{
    if(data.gameProgress==3)
    {
        _cursor.rotation = (180.0);
        _cursor.position = ccp(190.0, 230.0);
        [_cursor.physicsBody setVelocity:ccp(100,0)];
        [self performSelector:@selector(didKillEnemy) withObject:nil afterDelay:2.0f];
           }
    else
    {
        _mylab.string = @"";
        [self clickOnPause];
        

    }
}

-(void)clickOnPause
{
    if(data.gameProgress==4)
    {
        _cursor.rotation = (90.0);
        _cursor.position = ccp(60.0, 260.0);
        [ _cursor.physicsBody setVelocity:ccp(0,10)];
        [self performSelector:@selector(clickOnPause) withObject:nil afterDelay:.5f];
    }
    else
    {
        
        CCSprite* gem = (CCSprite*)[CCBReader load:@"Gem"];
        gem.physicsBody.sensor = YES;
        gem.position = ccp(460,50);
        
        [self.physNode addChild:gem];
        [self repeat];
    }

}

-(void)repeat
{
    _cursor.rotation = (90.0);
    _cursor.position = ccp(460,30);
    [ _cursor.physicsBody setVelocity:ccp(0,10)];
      [self performSelector:@selector(repeat) withObject:nil afterDelay:.5f];
    
}
-(void)cursoronEnemy
{
    _cursor.rotation = (90.0);
    _cursor.position = ccp(420,10);
    [ _cursor.physicsBody setVelocity:ccp(0,10)];
    [self performSelector:@selector(swipe2) withObject:nil afterDelay:.5f];
    
}
-(void)swipeattack
{
    if(data.currentTutorialProgress<2)
    {
        _cursor.rotation = (180.0);
        _cursor.position = ccp(190.0, 230.0);
        [_cursor.physicsBody setVelocity:ccp(100,0)];
        [self performSelector:@selector(swipeattack) withObject:nil afterDelay:2.0f];
    }
    else
    {
        
        [self tutorialMoving];
    }

}
@end
