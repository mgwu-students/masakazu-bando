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
#import "DeadBody.h"
@implementation MainScene
{
   
    CCPhysicsNode* _physicsNode;
    
    double _timeSinceGameStart;
    CCNode *_spawnNode;
     CCNode *_myChar;
    CCProgressNode *health;
    DeadBody *db;
    
    /*
     To Benji:
        This is the one that holds data for the main character
     */
    Creature *_mainCharacter;
    
    Creature* enemy;
    
    int i;
    NSArray *creatures;
    BOOL spawned;
    CCNode *_levelNode;
    CCActionFollow *follow;
    float targetXPoint;
    BOOL moving;
    float speed;
    float flip;
    int limit;
    
    
    

}
-(void)didLoadFromCCB
{
    flip = 1.0;
    limit = 25;
    speed = 3.0;
    //enable physics
    _physicsNode.collisionDelegate = self;
    
    //load the level
    [_levelNode addChild:[CCBReader load:@"Level1" owner:self]];
    
    //initialize that nothing is spawned
    spawned = false;
    
    moving = false;
    
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
    
    
    
    

    
    
    [self addSwipeGestures];
}
- (void)onEnterTransitionDidFinish {
    [super onEnterTransitionDidFinish];
    
    self.userInteractionEnabled = YES;
}

-(void) addSwipeGestures
{
    UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self   action:@selector(handleSwipeGesture:)];
    swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeleft];
    
    UISwipeGestureRecognizer * swiperight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGesture:)];
    swiperight.direction=UISwipeGestureRecognizerDirectionRight;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swiperight];
    
    UISwipeGestureRecognizer * swipedown=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipedown.direction=UISwipeGestureRecognizerDirectionDown;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipedown];
    
    UISwipeGestureRecognizer * swipeup=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipeup.direction=UISwipeGestureRecognizerDirectionUp;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeup];
    
    UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
    tapOne.numberOfTapsRequired = 1;
    [tapOne requireGestureRecognizerToFail:swipeup];
    [[[CCDirector sharedDirector] view] addGestureRecognizer:tapOne];
}
-(void)singleTap:(UITapGestureRecognizer*)sender
{
    
    CGPoint touchPoint = [sender locationInView: [sender.view superview]];
    
        if (CGRectContainsPoint(_mainCharacter.boundingBox, touchPoint))
        {
            //some action if _part01 is touched
            NSLog(@"enemy is touched");
        }
        else{
    
    
    moving = true;
    
    
    
            targetXPoint = touchPoint.x-(_myChar.position.x+_mainCharacter.position.x);
        }
    
    //targetXPoint = touchPoint.x-[_levelNode convertToWorldSpace: _mainCharacter.position ].x;
    
    

}
-(void)moveCharacter:(Creature*) creature
{
    if(targetXPoint>-speed&&targetXPoint<speed)
    {
        creature.position = ccp(creature.position.x+targetXPoint,creature.position.y);
        moving = FALSE;
    }
    else
    {
        if(targetXPoint>0.0)
        {
            creature.position = ccp(creature.position.x+speed,creature.position.y);
            targetXPoint -=speed;
        }
        else
        {
            creature.position = ccp(creature.position.x-speed,creature.position.y);
            targetXPoint +=speed;
        }
    }
    
}
#pragma mark Swipe Gestures
-(void) handleSwipeGesture:(UISwipeGestureRecognizer*)sender
{
    //Gesture detect - swipe up/down , can be recognized direction
    if(sender.direction == UISwipeGestureRecognizerDirectionUp)
    {
       [_mainCharacter.physicsBody applyImpulse:ccp(0, 100)];
        NSLog(@"UP");
        
    }
    else if(sender.direction == UISwipeGestureRecognizerDirectionDown)
    {
        NSLog(@"DOWN");
        //_myChar.position = ccp(_myChar.position.x, _myChar.position.y-10.0);
            }
    else if(sender.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        CCNode *fire = [CCBReader load:@"FireBall"];
        
        // position the penguin at the bowl of the catapult
        fire.position = ccpAdd(ccpAdd(_myChar.position,_mainCharacter.position), ccp(-50, 0));
        //_levelNode.position = ccpAdd(_levelNode.position, ccp(90, 0));
        [_physicsNode addChild:fire];
        
        // manually create & apply a force to launch the penguin
        CGPoint launchDirection = ccp(-1, 0);
        CGPoint force = ccpMult(launchDirection, 8000);
        [fire.physicsBody applyForce:force];

//        CGPoint launchDirection = ccp(1, 0);
//        CGPoint force = ccpMult(launchDirection, 80);
//        [_mainCharacter.physicsBody applyForce:force];
        NSLog(@"LEFT");
        // add scene transition logic
    }
    else if(sender.direction == UISwipeGestureRecognizerDirectionRight)
    {
        CCNode *fire = [CCBReader load:@"FireBall"];
        
        // position the penguin at the bowl of the catapult
        fire.position = ccpAdd(ccpAdd(_myChar.position,_mainCharacter.position), ccp(50, 0));
        //_levelNode.position = ccpAdd(_levelNode.position, ccp(90, 0));
        [_physicsNode addChild:fire];
        
        // manually create & apply a force to launch the penguin
        CGPoint launchDirection = ccp(1, 0);
        CGPoint force = ccpMult(launchDirection, 8000);
        [fire.physicsBody applyForce:force];

        NSLog(@"RIGHT");
        // add scene transition logic
    }
    
}



//
//- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
//    
//    CGPoint touchLocation = [touch locationInView: [touch view]];
//    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
//    touchLocation = [self convertToNodeSpace:touchLocation];
//    // todo: figure out touch location
//    CGPoint playerPos = _mainCharacter.position;
//    CGPoint diff = ccpSub(touchLocation, playerPos);
//    if (abs(diff.x) > abs(diff.y)) {
//        if (diff.x > 0) {
//            playerPos.x += 10.0;
//        } else {
//            playerPos.x -= 10.0;
//        }
//    } else {
//        if (diff.y > 0) {
//            //playerPos.y += _tileMap.tileSize.height;
//        } else {
//            //playerPos.y -= _tileMap.tileSize.height;
//        }
//    }
//    
//    
//}
- (void)onEnter {
    [super onEnter];
    
  
follow = [CCActionFollow actionWithTarget:_mainCharacter worldBoundary:[_levelNode.children[0] boundingBox]];
    _physicsNode.position = [follow currentOffset];
    [_physicsNode runAction:follow];
}

//- (void)up {
//   // _mainCharacter.position = ccp(_mainCharacter.position.x, _mainCharacter.position.y+10.0);
//   [_mainCharacter.physicsBody applyImpulse:ccp(0, 4)];
//  
//}
//- (void)down {
//    //_myChar.position = ccp(_myChar.position.x, _myChar.position.y-10.0);
//    CCNode *fire = [CCBReader load:@"FireBall"];
//    
//    // position the penguin at the bowl of the catapult
//    fire.position = ccpAdd(ccpAdd(_myChar.position,_mainCharacter.position), ccp(90, 0));
//    //_levelNode.position = ccpAdd(_levelNode.position, ccp(90, 0));
//    [_physicsNode addChild:fire];
//    
//    // manually create & apply a force to launch the penguin
//    CGPoint launchDirection = ccp(1, 0);
//    CGPoint force = ccpMult(launchDirection, 8000);
//    [fire.physicsBody applyForce:force];
//}
//- (void)right {
//    _mainCharacter.position = ccp(_mainCharacter.position.x+10.0, _mainCharacter.position.y);
//    
//}
//- (void)left {
//    _mainCharacter.position = ccp(_mainCharacter.position.x-10.0, _mainCharacter.position.y);
//}
- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair fireBall:(CCSprite *)nodeA wildcard:(Creature *)nodeB {
    NSLog(@"It works");
       [[_physicsNode space] addPostStepBlock:^{
    
    //spawn if there are currently no creatures under that spawnnode
    if(_spawnNode.children.count!=0){
    [nodeA removeFromParent];
    [nodeB removeFromParent];
        
        db = (DeadBody *)[CCBReader load:@"DeadBody"];
        db.ccbDirectory = nodeB.ccbDirectory;
        [_spawnNode addChild:db];
        /*
         To Benji:
         The maincharacer is temporary removed
         */
//        [_mainCharacter removeFromParent];
//        
//        /*
//         To Benji:
//         the main character now takes a new ccb file that is the same as the creature killed
//         */
//        _mainCharacter =(Creature *)[CCBReader load:nodeB.ccbDirectory];
//        
//        //_mainCharacter.physicsBody.allowsRotation = true;
//        /*
//         To Benji:
//         reloads the new ccb filed maincharacter on to map
//         */
//        [_myChar addChild:_mainCharacter];
//        
//    
//        
//        
//        follow = [CCActionFollow actionWithTarget:_mainCharacter worldBoundary:[_levelNode.children[0] boundingBox]];
//        _physicsNode.position = [follow currentOffset];
//        [_physicsNode runAction:follow];
 
    spawned = false;
    }
            } key:nodeA];
}


- (void)update:(CCTime)delta
{
    
     enemy.position = ccp(enemy.position.x-(flip*1.0),enemy.position.y);
    limit++;
    if(limit>50)
    {
        flip = flip*-1;
        limit=0;
    }
    if(moving)
    {
        [self moveCharacter:_mainCharacter];
    }
    _timeSinceGameStart+=delta;
   
    if(!spawned&&_spawnNode.children.count==0&&((int)_timeSinceGameStart)%10==0)
    {
        spawned = true;
        //if(_spawnNode.children.count==0)
       // {
         NSLog(@"spwaned");
        enemy = (Creature *)[CCBReader load:creatures[arc4random()%3]];
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
