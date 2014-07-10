//
//  MainScene.m
//  PROJECTNA_mainCharacter
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
#import "CCActionFollow+CurrentOffset.h"
#define CP_ALLOW_PRIVATE_ACCESS 1
#import "CCPhysics+ObjectiveChipmunk.h"
@implementation MainScene
{
   
    CCPhysicsNode* _physicsNode;
    
    double _timeSinceGameStart;
    CCNode *_spawnNode;
     CCNode *_myChar;
    CCProgressNode *health;
    
    
    /*
     To Benji:
        This is the one that holds data for the main character
     */
    Creature *_mainCharacter;
    
    
    
    int i;
    NSArray *creatures;
    BOOL spawned;
    CCNode *_levelNode;
    CCActionFollow *follow;
    
    

}
-(void)didLoadFromCCB
{
    //enable physics
    _physicsNode.collisionDelegate = self;
    
    //load the level
    [_levelNode addChild:[CCBReader load:@"Level1" owner:self]];
    
    //initialize that nothing is spawned
    spawned = false;
    
    //array of creatures on this map
    creatures = [NSArray arrayWithObjects: @"Cat",@"Dog",@"Mouse", nil];
    
    i = 0;
    
    //tracks ti_mainCharacter
    _timeSinceGameStart=0.0;
    
    
    
    /*
     To Benji:
        This loads the Mouse ccb as the main character,
        at this point the character does not rotate
     rotation value is also false
     */
    _mainCharacter =(Creature*)[CCBReader load:@"Mouse"];
    
    
    /*
     To Benji:
     _myChar is a node in my level1 ccb file
    .
     used for location setting for main character
     */
    [_myChar addChild:_mainCharacter];


    

 

    
    NSLog(@"%d",_myChar.children.count);
      // fire.physicsBody.collisionType = @"fire";`
   // _cat.physicsBody.collisionType = @"cat";
   
}
- (void)onEnter {
    [super onEnter];
    
  
follow = [CCActionFollow actionWithTarget:_mainCharacter worldBoundary:[_levelNode.children[0] boundingBox]];
    _physicsNode.position = [follow currentOffset];
    [_physicsNode runAction:follow];
}

- (void)up {
   // _mainCharacter.position = ccp(_mainCharacter.position.x, _mainCharacter.position.y+10.0);
   [_mainCharacter.physicsBody applyImpulse:ccp(0, 4)];
  
}
- (void)down {
    //_myChar.position = ccp(_myChar.position.x, _myChar.position.y-10.0);
    CCNode *fire = [CCBReader load:@"FireBall"];
    
    // position the penguin at the bowl of the catapult
    fire.position = ccpAdd(ccpAdd(_myChar.position,_mainCharacter.position), ccp(90, 0));
    //_levelNode.position = ccpAdd(_levelNode.position, ccp(90, 0));
    [_physicsNode addChild:fire];
    
    // manually create & apply a force to launch the penguin
    CGPoint launchDirection = ccp(1, 0);
    CGPoint force = ccpMult(launchDirection, 8000);
    [fire.physicsBody applyForce:force];
}
- (void)right {
    _mainCharacter.position = ccp(_mainCharacter.position.x+10.0, _mainCharacter.position.y);
    
}
- (void)left {
    _mainCharacter.position = ccp(_mainCharacter.position.x-10.0, _mainCharacter.position.y);
}
- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair fireBall:(CCSprite *)nodeA wildcard:(Creature *)nodeB {
    NSLog(@"It works");
    
    //spawn if there are currently no creatures under that spawnnode
    if(_spawnNode.children.count!=0){
    [nodeA removeFromParent];
    [nodeB removeFromParent];
    
        /*
         To Benji:
         The maincharacer is temporary removed
         */
        [_mainCharacter removeFromParent];
        
        /*
         To Benji:
         the main character now takes a new ccb file that is the same as the creature killed
         */
        _mainCharacter =(Creature *)[CCBReader load:nodeB.ccbDirectory];
        
        //_mainCharacter.physicsBody.allowsRotation = true;
        /*
         To Benji:
         reloads the new ccb filed maincharacter on to map
         */
        [_myChar addChild:_mainCharacter];
        
    
        
        
        follow = [CCActionFollow actionWithTarget:_mainCharacter worldBoundary:[_levelNode.children[0] boundingBox]];
        _physicsNode.position = [follow currentOffset];
        [_physicsNode runAction:follow];
 
    spawned = false;
    }
}

- (void)update:(CCTime)delta
{

    _timeSinceGameStart+=delta;
    NSLog(@"My rotation is: %f",_mainCharacter.rotation);
    if(!spawned&&_spawnNode.children.count==0&&((int)_timeSinceGameStart)%10==0)
    {
        spawned = true;
        //if(_spawnNode.children.count==0)
       // {
         NSLog(@"spwaned");
        Creature* enemy = (Creature *)[CCBReader load:creatures[arc4random()%3]];
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
