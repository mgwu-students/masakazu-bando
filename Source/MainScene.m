//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Creature.h"
#import "Cat.h"
#import "Dog.h"
#import "Mouse.h"
#include <stdlib.h>
@implementation MainScene
{
   
    CCPhysicsNode* _physicsNode;
    
    double _timeSinceGameStart;
    CCNode *_spawnNode;
     CCNode *_myChar;
    Creature *myPointer;
    int i;
    NSArray *creatures;
}
-(void)didLoadFromCCB
{
    
    creatures = [NSArray arrayWithObjects: @"Cat",@"Dog",@"Mouse", nil];
    i = 0;
        _timeSinceGameStart=0.0;
    _physicsNode.collisionDelegate = self;
    CCNode *me;
     me =[CCBReader load:@"Dog"];
    myPointer = me;

        [_myChar addChild:myPointer];
  
      // fire.physicsBody.collisionType = @"fire";
   // _cat.physicsBody.collisionType = @"cat";
}
- (void)up {
    myPointer.position = ccp(myPointer.position.x, myPointer.position.y+10.0);
   
  
}
- (void)down {
    //_myChar.position = ccp(_myChar.position.x, _myChar.position.y-10.0);
    CCNode *fire = [CCBReader load:@"FireBall"];
    
    // position the penguin at the bowl of the catapult
    fire.position = ccpAdd(ccpAdd(_myChar.position,myPointer.position), ccp(100, 20));
    [_physicsNode addChild:fire];
    
    // manually create & apply a force to launch the penguin
    CGPoint launchDirection = ccp(1, 0);
    CGPoint force = ccpMult(launchDirection, 8000);
    [fire.physicsBody applyForce:force];
}
- (void)right {
    myPointer.position = ccp(myPointer.position.x+10.0, myPointer.position.y);
    
}
- (void)left {
    myPointer.position = ccp(myPointer.position.x-10.0, myPointer.position.y);
}
- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair fireBall:(CCSprite *)nodeA wildcard:(Creature *)nodeB {
    NSLog(@"It works");
    

    if(_spawnNode.children.count!=0){
    [nodeA removeFromParent];
    [nodeB removeFromParent];
    }
    [myPointer removeFromParent];
    CCNode *me;
    me =[CCBReader load:nodeB.ccbDirectory];
    myPointer = me;
    
    [_myChar addChild:myPointer];
    
}

- (void)update:(CCTime)delta
{
    _timeSinceGameStart+=delta*1000;
    
    if(((int)_timeSinceGameStart)%100==0&&_spawnNode.children.count==0)
    {
        //if(_spawnNode.children.count==0)
       // {
         NSLog(@"spwaned");
        Creature* enemy = [CCBReader load:creatures[arc4random()%3]];
        [_spawnNode addChild:enemy];
       // if(i==1){
//
//            Creature* enemy = [CCBReader load:@"Cat"];
//            i =0;
//            
//             [_spawnNode addChild:enemy];
//            
//
//            
//        }
//        else
//        {
//            Creature* enemy = [CCBReader load:@"Dog"];
//            i =1;
//             [_spawnNode addChild:enemy];
//        }
        
        //[_cat init];
        //NSLog(@"%d",_cat.health);
        
        NSLog(@"%d",_spawnNode.children.count);

        //}
    }
}
@end
