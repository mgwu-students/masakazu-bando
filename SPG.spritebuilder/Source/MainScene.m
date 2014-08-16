//
//  MainScene.m
//  PROJECTNA_mainCharacter
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Creature.h"
#include <stdlib.h>
#import "CCActionFollow+CurrentOffset.h"
#define CP_ALLOW_PRIVATE_ACCESS 1
#import "CCPhysics+ObjectiveChipmunk.h"
#import "MoveNode.h"
#import "PauseMenu.h"
#import "GameData.h"
#import "Tutorial.h"
#import "LevelUp.h"
@implementation MainScene
{
    int _killedEnemyCount;
    NSString* _currentWorkingAttack;
    int _currentCreatureExp;
    CCNode* _gem;
    CCNode* tempatk;
    CCNode *currentCloseAttack;
    CCNode* _hurt;
    
    int _closeAttack;
    BOOL _closeAttackActivated;
    BOOL _jumped;
    int maxRight;
    int maxLeft,maxUp,maxDown;
    BOOL _finishedMove;

    BOOL _userPressedPause;
    CCNode* _forest;
    CCSprite* _ownHPbar;
    CCSprite* _enemyHPbar;
    CCSprite* _mpBar;
    CCSprite* _expBar;
    CCSprite* _enemyHPBack;
    
    NSString* touchedBody;
    BOOL doubleTap;
    NSUInteger tapCount;
    BOOL _touchInitiated;
    BOOL _swipeInitiated;
    CCPhysicsNode* _physicsNode;
    MoveNode* _attemptingMove;
    MoveNode* _myMoves;
    double _timeSinceGameStart;
    CCNode *_spawnNode;
     CCNode *_myChar;
    CCProgressNode *health;
    float detectRange;
    CGPoint _current;
    CCNode* _moveMap;
    int myhp, enemyhp;
    BOOL _touchedDB;
    BOOL _gameOver;
    
    Creature *_mainCharacter;
    NSMutableArray* _setOfAttacks;

    NSMutableArray* _myUnlockedMoveList;
    NSMutableArray* _aliveSetOfCreatures;
    NSMutableArray* _setOfDeadBodies;
    NSMutableArray* _deadSetOfCreatures;
    NSDictionary *tempdic;
    
    NSArray *creatures;
    NSArray *attacks;
    
    BOOL spawned;
    CCNode *_levelNode;
    CCActionFollow *follow;
    float targetXPoint;
    BOOL moving;
    float speed;
    float flip;
    int limit;
    
    int _numOfCoins;
    int hp1,hp2;
    CCLabelTTF *_myHP;
    CCLabelTTF *_enemyHP;
    CCLabelTTF *_coinLabel;
    CCLabelTTF *_prompt;
    float box;
    BOOL _paused;
    int left,right,up,down;
    BOOL _failed;
    int numOfEnemies;
    BOOL _jumpable;
    BOOL _clickedOnEnemy;
    BOOL _hasMoved;
    BOOL _gotHit;
    int _expSpider;
    int numOfEnem;
 
    GameData* data;
}
-(void)initialize
{
    
    
    data= [GameData sharedData];
    
    _numOfCoins = [[NSUserDefaults standardUserDefaults] integerForKey:@"Coins"];
    _coinLabel.string = [NSString stringWithFormat:@"%d", _numOfCoins];
    
    //JESSICA WAS HERE <3
    
    [_levelNode addChild:[CCBReader load:data.levelname owner:self]];
    
    
    if([data.levelname isEqualToString:@"LocationForest"])
    {
        [self loadCreaturesWithNum:3];
       // creatures = [NSArray arrayWithObjects: @"Spider",@"Golemn",@"Mage",@"Wolf",@"Goblin", nil];
        NSString* nigah = @"Spider";
         creatures = [NSArray arrayWithObjects: nigah,@"Goblin", nil];
        NSString* swoop = @"Bomb";
        attacks = [NSArray arrayWithObjects: swoop,@"NinjaStar", nil];

    }
    else if([data.levelname isEqualToString:@"LocationSky"])
    {
        [self loadCreaturesWithNum:3];
        // creatures = [NSArray arrayWithObjects: @"Spider",@"Golemn",@"Mage",@"Wolf",@"Goblin", nil];
        NSString* nigah = @"Spider";
        creatures = [NSArray arrayWithObjects: nigah,@"Mage", nil];
        NSString* swoop = @"Bomb";
        attacks = [NSArray arrayWithObjects: swoop,@"Barrier", nil];
        
        
    }
    else if([data.levelname isEqualToString:@"LocationSea"])
    {
        [self loadCreaturesWithNum:3];
        // creatures = [NSArray arrayWithObjects: @"Spider",@"Golemn",@"Mage",@"Wolf",@"Goblin", nil];
        NSString* nigah = @"Spider";
        creatures = [NSArray arrayWithObjects: nigah,@"Mage", nil];
        NSString* swoop = @"Bomb";
        attacks = [NSArray arrayWithObjects: swoop,@"Barrier", nil];
        
        
    }
    else if([data.levelname isEqualToString:@"LocationFactory"])
    {
        [self loadCreaturesWithNum:3];
        // creatures = [NSArray arrayWithObjects: @"Spider",@"Golemn",@"Mage",@"Wolf",@"Goblin", nil];
        NSString* nigah = @"Golemn";
        creatures = [NSArray arrayWithObjects: nigah,nigah,nigah,nigah,nigah, nil];
        NSString* swoop = @"RockSlide";
        attacks = [NSArray arrayWithObjects: swoop,swoop,swoop,swoop,swoop, nil];
        
        
    }
    else if([data.levelname isEqualToString:@"LocationMountain"])
    {
        
        [self loadCreaturesWithNum:3];
        // creatures = [NSArray arrayWithObjects: @"Spider",@"Golemn",@"Mage",@"Wolf",@"Goblin", nil];
        NSString* nigah = @"Spider";
        creatures = [NSArray arrayWithObjects: nigah,@"Golemn", nil];
        NSString* swoop = @"Bomb";
        attacks = [NSArray arrayWithObjects: swoop,@"RockSlide", nil];
        
        
    }
    else if([data.levelname isEqualToString:@"Maze"])
    {
        [self loadCreaturesWithNum:0];
        creatures = [NSArray arrayWithObjects: @"Spider",@"Golemn",@"Mage",@"Wolf",@"Goblin", nil];
        attacks = [NSArray arrayWithObjects: @"Bomb",@"RockSlide",@"NinjaStar",@"NinjaStar",@"Bomb", nil];
        
    }

    _mainCharacter =(Creature*)[CCBReader load:[[NSUserDefaults standardUserDefaults] objectForKey:@"CreatureType"]];
    _mainCharacter.ccbDirectory =  [[NSUserDefaults standardUserDefaults] objectForKey:@"CreatureType"];
    _currentWorkingAttack = [[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentProgressAttack"];
    
    _myHP.string = [[NSUserDefaults standardUserDefaults] objectForKey:@"CreatureType"];

        _myMoves = data.myMoves;
    
    if( [[NSUserDefaults standardUserDefaults] objectForKey:@"didFinishTutorial"]!=nil)
    {
        
        [self updateExpBars2];
       
    }
    else
    {
         _coinLabel.visible = false;
    }
    
}
-(void)saveData
{
    

  
    data.myMoves = _myMoves;


    [[NSUserDefaults standardUserDefaults] setInteger:_numOfCoins forKey:@"Coins"];
    
    [[NSUserDefaults standardUserDefaults] setObject:_mainCharacter.ccbDirectory forKey:@"CreatureType"];
    [[NSUserDefaults standardUserDefaults] setObject:_currentWorkingAttack forKey:@"CurrentProgressAttack"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
-(BOOL)playerMoved
{
    return _hasMoved;
}
-(void)didLoadFromCCB
{
   
//NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    if([prefs objectForKey:@"Username"]==nil)
//    {
//        [prefs setObject:@"Name" forKey:@"Username"];
//    }
//    
//    
//    NSString* me = [prefs objectForKey:@"Username"];
//    
//    
//    [prefs setObject:@"wapp" forKey:@"Username"];
//    [prefs synchronize];
  
//    int score;
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    
//    if([prefs objectForKey:@"HighScore"]==nil)
//    {
//        [prefs setInteger:0 forKey:@"HighScore"];
//        [prefs synchronize];
//    }
//    
//    
//    if(score>[prefs integerForKey:@"HighScore"])
//    {
//        [prefs setInteger:score forKey:@"HighScore"];
//        [prefs synchronize];
//    }
//    
    

    [self loadData];
    
    
      _jumpable = true;
    
    _setOfAttacks = [NSMutableArray array];
    _setOfDeadBodies = [NSMutableArray array];
    _myUnlockedMoveList = [NSMutableArray array];
    
    _aliveSetOfCreatures = [NSMutableArray array];
    _deadSetOfCreatures = [NSMutableArray array];
    

    _ownHPbar.scaleX = 5;
    _enemyHPbar.scaleX = 5;
    detectRange = 150.0;
    _mpBar.scaleX = 7;
    _expBar.scaleX = 0;


    
    flip = 1.0;
    speed = 3.0;
    
    //enable physics
    _physicsNode.collisionDelegate = self;
    
    
   

     [self initialize];

    
    

    


    

}
-(void)Menu
{
    _userPressedPause = true;
    _physicsNode.paused = true;
    _userPressedPause = false;
    

    
    
    // _pauseScreen.position = ccp(_pauseScreen.position.x,_pauseScreen.position.y+1.0);
    _physicsNode.paused = true;
    PauseMenu* myPauseMenu =(PauseMenu*)[CCBReader load:@"PauseMenu"];
    //  myPauseMenu.myMoveNode =
    myPauseMenu.myMoveNode = _myMoves;
    myPauseMenu.physNode = _physicsNode;
    data.currentTutorialProgress = 0;
    
    [self addChild:myPauseMenu];
}
- (void)onEnter {
    
    [super onEnter];
    

    // accept touches on the grid
    self.userInteractionEnabled = YES;

    
    box = 50.0;
    
    
    _mainCharacter.physicsBody.sensor = true;
    _mainCharacter.maxhealth = 20;
    _mainCharacter.physicsBody.collisionGroup = @"good";
    _mainCharacter.health = _mainCharacter.maxhealth;
    _mainCharacter.targetXPoint = 0.0;
    _mainCharacter.position = _myChar.position;
    
    _mainCharacter.right = 1;
    CCNode* aura =[CCBReader load:@"Aura"];
    aura.position = ccp(30,20);
    [_mainCharacter addChild:aura];
    
    


    
    [_levelNode.children[0] addChild:_mainCharacter];
    
    //follow = [CCActionFollow actionWithTarget:_mainCharacter worldBoundary:[_levelNode.children[0] boundingBox]];
    //[_physicsNode runAction:follow];
    [self addTutorial];

}



-(void)addTutorial
{
    
    Tutorial* myTutorial = (Tutorial*)[CCBReader load:@"TutorialBackground"];
    myTutorial.me = _mainCharacter;
    myTutorial.physNode = _physicsNode;
    myTutorial.myMoves = _myMoves;
    [self addChild:myTutorial];
    
}
-(void)loadCreaturesWithNum:(int)kkk
{
        for(int i1 = 1; i1<=kkk ; i1++)
        {
            [_deadSetOfCreatures addObject:[NSNumber numberWithInt:i1]];
        }
}

-(void)loadData
{

    
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:@"Property List.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"Property List" ofType:@"plist"];
    }
    
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    tempdic = (NSDictionary *)[NSPropertyListSerialization
                            propertyListFromData:plistXML
                            mutabilityOption:NSPropertyListMutableContainersAndLeaves
                            format:&format
                            errorDescription:&errorDesc];
    if (!tempdic) {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
}
#pragma mark-
-(void)touchBegan:(UITouch *)touches withEvent:(UIEvent *)event {
//     _mainCharacter.physicsBody.body.body->velocity_func = creatureMover;
    
    
   
    CGPoint touchPoint2 = [touches locationInNode:self];
    
  

//    if( touchPoint2.x<40&&touchPoint2.y>280)
//    {
//
//        _userPressedPause = true;
//        _physicsNode.paused = true;
//        
//    }
    if(!_userPressedPause)
    {
        CGPoint touchPoint = [touches locationInNode:_levelNode.children[0]];

        if(1==1||!_paused)
        {
            _failed = false;
            
            tapCount = [touches tapCount];
            
            NSLog(@"touchbegan");
            _touchInitiated = true;
            
            right = 0;
            up = 0;        _current = touchPoint;
            _moveMap = [CCBReader load:@"Star"];
            ((CCNode*)([[_moveMap children] objectAtIndex:0])).visible = false;
            _moveMap.position = touchPoint;
            [_levelNode.children[0] addChild:_moveMap];
            
            
            CCNode* s2 = [CCBReader load:@"Star"];
            [_moveMap addChild:s2];
            s2.position = ccp(s2.position.x+50.0*right+12.0,s2.position.y+50.0*up+12.0);
            
            _attemptingMove = _myMoves;
              _finishedMove = false;
            maxRight=0;
            maxLeft = 0;
            maxUp=0;
            maxDown = 0;
            
        }

    }
    
}

- (void)touchMoved:(UITouch *)touches withEvent:(UIEvent *)event {
    if(!_userPressedPause&&!_finishedMove)
    {
        NSLog(@"touchmoved");
        CGPoint positionInScene = [touches locationInNode:_levelNode.children[0]];
        
        if(positionInScene.x-_current.x>box/2)
        {
            if(maxRight-maxLeft>1&&right==maxRight)
            {
                _finishedMove = true;
                if(_attemptingMove.attack!=nil)
                {
                    //_attemptingMove.attack = [[Attack alloc] init];
                    NSLog(@"SWAGGER");
                    
                    [self creature:(_mainCharacter)attack:(_attemptingMove.attack)];
                    
                    
                }
            }
            else
            {
                if(_attemptingMove.Right==nil)
                {
                    _attemptingMove.Right = [[MoveNode alloc] init];
                    NSLog(@"Right");
                    
                    //            CCNode* bar = [CCBReader load:@"LineH"];
                    //            bar.position = positionInScene;
                    //            [self addChild:bar];
                }
                _swipeInitiated = true;
                _attemptingMove = _attemptingMove.Right;
                _current = ccp(_current.x+box, _current.y);
                right++;
                if(right>maxRight)
                {
                    maxRight = right;
                }
                CCNode* s2 = [CCBReader load:@"Star"];
                [_moveMap addChild:s2];
                s2.position = ccp(s2.position.x+50.0*right+12.0,s2.position.y+50.0*up+12.0);
            }
    
        }
        else if(positionInScene.x-_current.x<-box/2)
        {
            if(maxRight-maxLeft>1&&right==maxLeft)
            {
                _finishedMove = true;
                if(_attemptingMove.attack!=nil)
                {
                    //_attemptingMove.attack = [[Attack alloc] init];
                    
                    
                    [self creature:(_mainCharacter)attack:(_attemptingMove.attack)];
                    
                    
                }
            }
            else
            {
                if(_attemptingMove.Left==nil)
                {
                    _attemptingMove.Left = [[MoveNode alloc] init];
                    NSLog(@"Left");
                    
                }
                
                _swipeInitiated = true;
                _attemptingMove = _attemptingMove.Left;
                _current = ccp(_current.x-box, _current.y);
                right--;
                if(right<maxLeft)
                {
                    maxLeft = right;
                }
                CCNode* s2 = [CCBReader load:@"Star"];
                [_moveMap addChild:s2];
                s2.position = ccp(s2.position.x+50.0*right+12.0,s2.position.y+50.0*up+12.0);
            }
            
        }
        else if(positionInScene.y-_current.y>box/2)
        {
            if(maxUp-maxDown>1&&up==maxUp)
            {
                _finishedMove = true;
                if(_attemptingMove.attack!=nil)
                {
                    //_attemptingMove.attack = [[Attack alloc] init];
                    
                    
                    [self creature:(_mainCharacter)attack:(_attemptingMove.attack)];
                    
                    
                }
            }
            else
            {
                
                if(_attemptingMove.Up==nil)
                {
                    _attemptingMove.Up = [[MoveNode alloc] init];
                    NSLog(@"Up");
                }
                
                _swipeInitiated = true;
                _attemptingMove = _attemptingMove.Up;
                _current = ccp(_current.x, _current.y+box);
                up++;
                if(up>maxUp)
                {
                    maxUp = up;
                }
                CCNode* s2 = [CCBReader load:@"Star"];
                [_moveMap addChild:s2];
                s2.position = ccp(s2.position.x+50.0*right+12.0,s2.position.y+50.0*up+12.0);
            }
        }
        else if(positionInScene.y-_current.y<-box/2)
        {
            if(maxUp-maxDown>1&&up==maxDown)
            {
                _finishedMove = true;
                if(_attemptingMove.attack!=nil)
                {
                    //_attemptingMove.attack = [[Attack alloc] init];
                    
                    
                    [self creature:(_mainCharacter)attack:(_attemptingMove.attack)];
                    
                    
                }
            }
            else
            {
                
                
                if(_attemptingMove.Down==nil)
                {
                    _attemptingMove.Down = [[MoveNode alloc] init];
                    NSLog(@"Down");
                }
                
                
                _swipeInitiated = true;
                
                
                // add scene transition logic
                
                _attemptingMove = _attemptingMove.Down;
                _current = ccp(_current.x, _current.y-box);
                up--;
                if(up<maxDown)
                {
                    maxDown = up;
                }
                CCNode* s2 = [CCBReader load:@"Star"];
                [_moveMap addChild:s2];
                s2.position = ccp(s2.position.x+50.0*right+12.0,s2.position.y+50.0*up+12.0);
            }
        }

    }
   }

- (void)touchEnded:(UITouch *)touches withEvent:(UIEvent *)event {
    
    if(!_userPressedPause)
    {
        NSLog(@"touchended");
        
        
        if(!_swipeInitiated)
        {
//            if(tapCount==1)
//            {
//                [self singleTap:touches];
//            }
//            else
//            {
//                doubleTap = true;
//                [self doubleTap];
//                
//            }
            [self singleTap:touches];
        }
        else{
            NSLog(@"DONE");
            if(!_paused)
            {
                
                if(_attemptingMove.attack!=nil&&!_finishedMove)
                {
                    //_attemptingMove.attack = [[Attack alloc] init];
                    
                    
                    [self creature:(_mainCharacter)attack:(_attemptingMove.attack)];
                    
                    
                }
            }

            
            
          
           
            _swipeInitiated = false;
        }
        tapCount = 0;
        _touchInitiated = false;
        [_moveMap removeFromParent];
        _moveMap = nil;
        

    }
    else
    {
        

//        _userPressedPause = false;
//        
//        
//        
//        
//        
//       // _pauseScreen.position = ccp(_pauseScreen.position.x,_pauseScreen.position.y+1.0);
//        _physicsNode.paused = true;
//        PauseMenu* myPauseMenu =(PauseMenu*)[CCBReader load:@"PauseMenu"];
//      //  myPauseMenu.myMoveNode =
//        myPauseMenu.myMoveNode = _myMoves;
//        myPauseMenu.physNode = _physicsNode;
//        data.currentTutorialProgress = 0;
//        
//        [self addChild:myPauseMenu];
//        
        
    }
}

-(NSArray*)createArrayWithAnimation:(NSString*)link andCharacter: (Creature*) c1
{
    NSArray * myDataArray = [NSArray arrayWithObjects:link,c1, nil];
    return myDataArray;
}
-(void)runAnimation:(NSArray*)arr
{
   
    [((Creature*)arr[1]).animationManager runAnimationsForSequenceNamed:((NSString*)arr[0])];
    
    float animationDuration;
    
    [self performSelector:@selector(runAnimation:) withObject:arr afterDelay:animationDuration];
}
-(void)singleTap:(UITouch*)touches
{
   
    
  
    CGPoint touchPoint = [touches locationInNode:_levelNode.children[0]];
   
    
    NSLog(@"enemyxpos->%f  enemyypos->%f",_mainCharacter.boundingBox.origin.x,_mainCharacter.boundingBox.origin.y);
    NSLog(@"touchxpos->%f  touchypos->%f",touchPoint.x,touchPoint.y);
    for(int i = 0; i<_aliveSetOfCreatures.count;i++)
    {
            if (CGRectContainsPoint([_aliveSetOfCreatures[i] boundingBox], touchPoint))
          {
               //some action if _part01 is touched
               NSLog(@"enemy is touched");
              _mainCharacter.target = _aliveSetOfCreatures[i];
              _enemyHP.string = _mainCharacter.target.ccbDirectory;
              //    if (CGRectContainsPoint(_mainCharacter.boundingBox, touchPoint))
              //    {
              //        //some action if _part01 is touched
              //        NSLog(@"enemy is touched");
              //    }
              _clickedOnEnemy = true;
            }
    }
    if(!_clickedOnEnemy)
    {
        
        if(_mainCharacter.position.x>touchPoint.x)
        {
            [_mainCharacter.animationManager runAnimationsForSequenceNamed:@"WalkL"];
            
            NSLog(@"move left");
            [_mainCharacter.physicsBody setVelocity:CGPointMake(-100.0, _mainCharacter.physicsBody.velocity.y)];

            _mainCharacter.right = -1;
            
            NSLog(@"%f",_mainCharacter.physicsBody.velocity.x);
            
        }
        else
        {
            [_mainCharacter.animationManager runAnimationsForSequenceNamed:@"WalkR"];
           // [_mainCharacter.animationManager ]
            NSLog(@"move right");
            _mainCharacter.right = 1;
            [_mainCharacter.physicsBody setVelocity:CGPointMake(100.0, _mainCharacter.physicsBody.velocity.y)];

            NSLog(@"%f",_mainCharacter.physicsBody.velocity.x);
        }
        _mainCharacter.targetXPoint = touchPoint.x;
        _mainCharacter.atTargetXPoint = false;
        [self flipped];
    }
    else
    {
        _clickedOnEnemy = false;
    }
//    else{
    

    
//}
    
    //targetXPoint = touchPoint.x-[_levelNode convertToWorldSpace: _mainCharacter.position ].x;
  
}

-(void)doubleTap{
    if (!_jumped) {
        [_mainCharacter.physicsBody setVelocity:CGPointMake(_mainCharacter.physicsBody.velocity.x, 160)];
//        [_mainCharacter.physicsBody setVelocity:CGPointMake(_mainCharacter.physicsBody.velocity.x,0)];
//        
//        [_mainCharacter.physicsBody applyImpulse:ccp(0, 600)];
        _jumped = TRUE;
           [self performSelector:@selector(allowJump) withObject:nil afterDelay:3.0f];

    }
   // NSLog(@"UP");
    
    //[self pause];
    
    


    
}


- (void)resetJump {
    if(abs(_mainCharacter.physicsBody.velocity.y)<.00001&&_jumpable)
        _jumped = FALSE;
}
-(void)allowJump
{
    _jumpable = true;
}

//-(void)pause{
//   NSLog(@"swag%f", _pauseScreen.position.y);
//    _paused = !_paused;
//    
//    _pauseScreen.position = ccp(_pauseScreen.position.x,_pauseScreen.position.y+1.0);
//}
-(void)updateAllEnemies:(NSMutableArray*)a1
{
    for(int i = 0; i<[a1 count]; i++)
    {
        [self updateEnemy:a1[i]];
    }
}
-(void)updateEnemy: (Creature*)c1
{
    if(c1!=nil)
    {
        if(c1.physicsBody.velocity.x>0)
        {
            if([c1.animationManager runningSequenceName]==nil)
            {
                [c1.animationManager runAnimationsForSequenceNamed:@"WalkR"];
            }
            
        }
        else if(c1.physicsBody.velocity.x<0)
        {
            if([c1.animationManager runningSequenceName]==nil)
            {
                      [c1.animationManager runAnimationsForSequenceNamed:@"WalkL"];
            }
            
            

        }
        
        if([self updateCreatureAttackDirection:c1])
        {
            [c1.physicsBody setVelocity:CGPointMake(0, c1.physicsBody.velocity.y)];
            if(c1.attackDelay<=0)
            {
                [self creature:c1 attack:c1.attack];
                c1.attackDelay = 25;
                c1.justFinishedAttacking = true;
            }
        }
        else
        {
            [self moveEnemy:(c1)];
        }
        c1.attackDelay--;
        //NSLog(@"updated enemy");
    }

}
-(BOOL)updateCreatureAttackDirection:(Creature*) c1
{
    if([c1.ccbDirectory isEqualToString:@"Spider"])
    {
        detectRange=10.0;
    }
    else
    {
        detectRange = 150.0;
        
    }

    if(c1.position.x>_mainCharacter.position.x&&abs(c1.position.x-_mainCharacter.position.x)<detectRange)
    {
        c1.right = -1;
        return true;
    }
    else if(c1.position.x<_mainCharacter.position.x&&abs(c1.position.x-_mainCharacter.position.x)<detectRange)
    {
        c1.right = 1;
        return true;
    }
    else
    {
        return false;
    }
}

-(void)updateCreatureLocation:(Creature*) c1
{

    if(!c1.atTargetXPoint&&abs(c1.targetXPoint-c1.position.x)<30.0)
    {
        
        NSLog(@"char stops moving");
        //creature.position = ccp(creature.position.x+targetXPoint,creature.position.y);
        [c1.physicsBody setVelocity:CGPointMake(0, c1.physicsBody.velocity.y)];

        
        c1.atTargetXPoint = true;
        c1.moveDirection = !c1.moveDirection;

        //[self moveCharacter:_mainCharacter];
        
    }

}
-(void)updateHealthBar
{
    _ownHPbar.scaleX = (_mainCharacter.health)/_mainCharacter.maxhealth;
    
    
    
    if(_mainCharacter.target !=nil)
    {
        _enemyHPBack.visible = true;
            _enemyHPbar.scaleX = (_mainCharacter.target.health)/_mainCharacter.target.maxhealth;
    }
    else
    {
        _enemyHPbar.scaleX = 0.0;
        _enemyHP.string = @"";
        _enemyHPBack.visible = false;
    }

}
-(void)moveEnemy:(Creature*) c1{
    float mspeed;
    if([c1.ccbDirectory isEqualToString:@"Spider"])
    {
        mspeed = 50.0;
    }
    else
    {
        mspeed = 25.0;
    }
    if(c1.atTargetXPoint)
    {
        
        if(c1.position.x>=_mainCharacter.position.x)
        {
        
                [c1.animationManager runAnimationsForSequenceNamed:@"WalkL"];
          
            NSLog(@"move left");
            [c1.physicsBody setVelocity:CGPointMake(-mspeed, c1.physicsBody.velocity.y)];
            //c1.targetXPoint = c1.position.x-50;
            
        }
        else
        {
        
            [c1.animationManager runAnimationsForSequenceNamed:@"WalkR"];
        
            NSLog(@"move right");
            [c1.physicsBody setVelocity:CGPointMake(mspeed, c1.physicsBody.velocity.y)];
            //c1.targetXPoint = c1.position.x+50;
        }
        c1.atTargetXPoint = false;
        c1.justFinishedAttacking = false;
    }
    else if(c1.justFinishedAttacking)
    {
        if(c1.position.x>=_mainCharacter.position.x)
        {
            
            [c1.animationManager runAnimationsForSequenceNamed:@"WalkL"];
            
            NSLog(@"move left");
            [c1.physicsBody setVelocity:CGPointMake(-mspeed, c1.physicsBody.velocity.y)];
            //c1.targetXPoint = c1.position.x-50;
            
        }
        else
        {
            
            [c1.animationManager runAnimationsForSequenceNamed:@"WalkR"];
            
            NSLog(@"move right");
            [c1.physicsBody setVelocity:CGPointMake(mspeed, c1.physicsBody.velocity.y)];
            //c1.targetXPoint = c1.position.x+50;
        }
        c1.justFinishedAttacking = false;
    }
    else
    {
        [self updateCreatureLocation:c1];
        c1.justFinishedAttacking = false;
    }
   }
- (BOOL)ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair HealthPotion:(CCSprite *)nodeA Creature:(Creature*)nodeB
{
    [[_physicsNode space] addPostStepBlock:^{
        
        NSLog(@"sup");
        
        //spawn if there are currently no creatures under that spawnnode
        if(nodeB==_mainCharacter)
        {
            
            _mainCharacter.health += 5;
            if(_mainCharacter.health>_mainCharacter.maxhealth)
            {
                _mainCharacter.health = _mainCharacter.maxhealth;
            }
            [nodeA removeFromParent];
        }
      
        
        
    }key:nodeA];
    return true;
}
- (BOOL)ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair Gem:(CCSprite *)nodeA Creature:(Creature*)nodeB
{
//    [[_physicsNode space] addPostStepBlock:^{
    if (!_gameOver&&nodeB==_mainCharacter) {
        if(data.gameProgress==5)
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"Done" forKey:@"didFinishTutorial"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
              [self saveData];
        
        CCScene *gameplayScene = [CCBReader loadAsScene:@"PopUp"];
        [[CCDirector sharedDirector] replaceScene:gameplayScene];
  
        _gameOver = TRUE;
        
        [[NSUserDefaults standardUserDefaults] setObject:@"Done" forKey:data.levelname];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
//    }key:nodeA];
    return true;
}
- (BOOL)ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair Coin:(CCSprite *)nodeA Creature:(Creature*)nodeB
{
    [[_physicsNode space] addPostStepBlock:^{
        
        if(nodeB==_mainCharacter)
        {
            _numOfCoins+=100;
            _coinLabel.string = [NSString stringWithFormat:@"%d", _numOfCoins];
            [nodeA removeFromParent];
            _hasMoved = true;
        }

        
        
    }key:nodeA];
    return true;
}

- (BOOL)ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair HarmBomb:(CCSprite *)nodeA Creature:(Creature*)nodeB
{
    [[_physicsNode space] addPostStepBlock:^{
        
        NSLog(@"sup");
        
        //spawn if there are currently no creatures under that spawnnode
        
        nodeA.physicsBody.collisionType = @"Bomb";
        
        [self getHit:nodeB];
        
    }key:nodeA];
    return true;
}
- (BOOL)ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair RockSlide:(CCSprite *)nodeA Creature:(Creature*)nodeB
{
    [[_physicsNode space] addPostStepBlock:^{
        
        NSLog(@"sup");
        
        //spawn if there are currently no creatures under that spawnnode
        
        [nodeA removeFromParent];
        [self getHit:nodeB];
    
    }key:nodeA];
    return true;
}
- (BOOL)ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair Attack:(CCSprite *)nodeA Creature:(Creature*)nodeB
{
    
    [[_physicsNode space] addPostStepBlock:^{

        NSLog(@"sup");

        //spawn if there are currently no creatures under that spawnnode
        
        [nodeA removeFromParent];
        nodeA.physicsBody.collisionType = @"deadattack";
        [self getHit:nodeB];
        
    
    }key:nodeA];
    return true;
}
- (BOOL)ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair Attack:(CCSprite *)nodeA dummy:(Creature*)nodeB
{
    
    [[_physicsNode space] addPostStepBlock:^{
        
        NSLog(@"sup");
        
        //spawn if there are currently no creatures under that spawnnode
        
        [nodeA removeFromParent];
        [self gainExp];

        if(data.gameProgress==0)
        {
            data.currentTutorialProgress=2;
            nodeB.isDead = true;
            nodeB.ccbDirectory = @"Spider";
            [nodeB.animationManager runAnimationsForSequenceNamed:(@"Die")];
            
            nodeB.physicsBody.collisionType = @"DummyDeadBody";
        }
        if(data.gameProgress==3)
        {
            _expSpider++;
            
            [self updateExpBars];

            [nodeB removeFromParent];
         
        }
        
        
    }key:nodeA];
    return true;
}
-(void)getHit:(Creature*) nodeB
{
    if(nodeB.health<2)
    {
          _killedEnemyCount++;
        if(_killedEnemyCount>=10)
        {
            LevelUp* yeh = [CCBReader load:@"PopUp2" owner:self];
            ((CCLabelTTF*)[[yeh.children[0] children] objectAtIndex:0]).fontSize = (10.0);
            ((CCLabelTTF*)[[yeh.children[0] children] objectAtIndex:0]).string = [NSString stringWithFormat:@"Level Complete!"];
            [self addChild:yeh];
            
            CCSprite* door = [CCBReader load:@"Gem"];
            door.position = _gem.position;
            [_physicsNode addChild:door];
        }
        

        
        nodeB.isDead = true;
        [nodeB.animationManager runAnimationsForSequenceNamed:(@"Die")];
        if(nodeB!=_mainCharacter)
        {
            nodeB.physicsBody.collisionType = @"DeadBody";
            [self gainExp];
            [self updateExpBars2];
            [self learnNewSkill];
            
            [_aliveSetOfCreatures removeObject:nodeB];
            
            _enemyHPbar.scaleX = 10;
            [nodeB.physicsBody setVelocity:ccp(0,0)];
            
            _mainCharacter.target = nil;
            [self performSelector:@selector(lootForCreature:) withObject:nodeB afterDelay:2.0];
            [self performSelector:@selector(removeObj:) withObject:nodeB afterDelay:10.0];
        }
        
    }
    else
    {
    
        ((Creature*)nodeB).health--;
        if(!((Creature*)nodeB==_mainCharacter))
        {
            _mainCharacter.target = (Creature*)nodeB;
            _enemyHP.string = _mainCharacter.target.ccbDirectory;
        }
    }
    if(((Creature*)nodeB==_mainCharacter))
    {
        _gotHit = true;
    }
}
-(void)hurt
{
    if(_gotHit)
    {
        if(_hurt.opacity<.2)
        {
                    _hurt.opacity+=.02;
        }
        else
        {
            _gotHit = false;
        }
    }
    else
    {
        if(_hurt.opacity>0.0)
        {
            _hurt.opacity-=.02;
        }
    }
}
-(void)removeObj:(Creature*)node
{
    if(node!=nil)
    {
        [node removeFromParent];
    }
}
-(void)lootForCreature:(Creature*)nodeB
{
    //LOOT
    if(arc4random()%2==1)
    {
        CCNode *healthPotion = [CCBReader load:@"HealthPotion"];
        healthPotion.physicsBody.sensor = true;
        healthPotion.position =nodeB.position;
        [_levelNode.children[0] addChild:healthPotion];
        
    }
    //CCNode *coin = [CCBReader load:@"Coin"];
    //coin.physicsBody.sensor = true;
    //coin.position =nodeB.position;
    //[_levelNode.children[0] addChild:coin];
}
- (BOOL)ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair Attack:(CCSprite *)nodeA Barrier:(CCSprite*)nodeB
{
    [[_physicsNode space] addPostStepBlock:^{
            nodeA.physicsBody.collisionGroup = nodeB.physicsBody.collisionGroup;
               [nodeA.physicsBody setVelocity:CGPointMake(-nodeA.physicsBody.velocity.x, -nodeA.physicsBody.velocity.y)];
        
        
    }key:nodeA];
    return true;
}
- (BOOL)ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair Attack:(CCSprite *)nodeA BlockNinjaStar:(CCSprite*)nodeB
{
    [[_physicsNode space] addPostStepBlock:^{
        [nodeA removeFromParent];
        [nodeB removeFromParent];
        
    }key:nodeA];
    return true;
}

- (BOOL)ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair  DeadBody:(Creature *)nodeB BodySwap:(CCNode *)nodeA {

    [[_physicsNode space] addPostStepBlock:^{
        //[self checkForUpdate:nodeB.attack];
        
        [self checkForCharacter:nodeB];
        _closeAttackActivated = false;
        touchedBody = [NSString stringWithString:nodeB.ccbDirectory];
        _touchedDB = true;
        _mainCharacter.ccbDirectory = nodeB.ccbDirectory;
      
        _currentWorkingAttack = [NSString stringWithString:nodeB.attack];

        [self performSelector:@selector(spawnEnemyAtSpawnNode:) withObject:[NSNumber numberWithInt:nodeB.spawnNodeNum] afterDelay:15.0];
        [self updateExpBars2];
         [nodeB removeFromParent];
      
    } key:nodeA];
    return true;
}
- (BOOL)ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair  DummyDeadBody:(Creature *)nodeB BodySwap:(CCNode *)nodeA {
    
    [[_physicsNode space] addPostStepBlock:^{

        
_closeAttackActivated = false;
        touchedBody = [NSString stringWithString:nodeB.ccbDirectory];
        _touchedDB = true;
        _mainCharacter.ccbDirectory = nodeB.ccbDirectory;
        
        [self checkForCharacter:nodeB];
        
        if(data.gameProgress==2)
        {
            
            data.gameProgress=3;
            
        }
     [nodeB removeFromParent];
        
    } key:nodeA];
    
    
    return true;
}
-(void)flipped
{
    
    if(_closeAttackActivated)
    {
        _closeAttackActivated = false;
         [_mainCharacter.children[2] removeFromParent];
        CCNode *bodySwap = [CCBReader load:@"BodySwap"];
        // NinjaStar.physicsBody.collisionType = c1.physicsBody.collisionType;
        
        bodySwap.physicsBody.collisionGroup = _mainCharacter.physicsBody.collisionGroup;
        
        bodySwap.physicsBody.sensor = YES;
        
        bodySwap.position = ccp(_mainCharacter.right*40+30, 30);
        
        [_mainCharacter addChild:bodySwap];
        _closeAttackActivated = true;
    }
}
//
//-(void)removeDeadCreatures
//{
//    //Creature Died
//    for(int s = 0;s<_aliveSetOfCreatures.count;s++)
//    {
//        if([_aliveSetOfCreatures[s] isDead])
//        {
//            
//            DeadBody *db;
//            db = (DeadBody *)[CCBReader load:@"DeadBody"];
//            db.physicsBody.sensor = true;
//            db.ccbDirectory = [_aliveSetOfCreatures[s] ccbDirectory];
//            [_levelNode.children[0] addChild:db];
//            db.position = [_aliveSetOfCreatures[s] positionInPoints];
//            
//            //LOOT
//            if(arc4random()%2==1)
//            {
//                CCNode *healthPotion = [CCBReader load:@"HealthPotion"];
//                healthPotion.physicsBody.sensor = true;
//                healthPotion.position =[_aliveSetOfCreatures[s] positionInPoints];
//                [_levelNode.children[0] addChild:healthPotion];
//                
//            }
//            CCNode *coin = [CCBReader load:@"Coin"];
//            coin.physicsBody.sensor = true;
//            coin.position =[_aliveSetOfCreatures[s] positionInPoints];
//            [_levelNode.children[0] addChild:coin];
//            
//            
//            [_aliveSetOfCreatures[s] removeFromParent];
//            _enemyHPbar.scaleX = 0;
//            numOfEnemies --;
//            db.spawnNodeNum = [_aliveSetOfCreatures[s] spawnNodeNum];
//            int q = [_aliveSetOfCreatures[s] spawnNodeNum];
//            
//            [_aliveSetOfCreatures removeObjectAtIndex:s];
//            
//            _mainCharacter.target = nil;
//        }
//    }
////    if(_mainCharacter.target.isDead)
////    {
////        DeadBody *db;
////        db = (DeadBody *)[CCBReader load:@"DeadBody"];
////        db.ccbDirectory = _mainCharacter.target.ccbDirectory;
////        [_levelNode.children[0] addChild:db];
////        db.position = _mainCharacter.target.position;
////        [_mainCharacter.target removeFromParent];
////        _enemyHPbar.scaleX = 0;
////        numOfEnemies --;
////        _mainCharacter.target = nil;
////        
////    }
//}
-(void)checkIfPlayerDied
{
    //GAME OVER
    if(_mainCharacter.isDead&&!_gameOver)
    {
        CCScene *gameplayScene = [CCBReader loadAsScene:@"GameOver"];
        [[CCDirector sharedDirector] replaceScene:gameplayScene];
        _gameOver = true;
    }
}
-(void)checkForContactWithCloseAttack
{
    if(_closeAttack>0)
    {
        _closeAttack--;
    }
    if(_closeAttack<1&&_closeAttackActivated)
    {
        [_mainCharacter.children[2] removeFromParent];
        _closeAttackActivated = false;
        
    }
}
-(void)updateExpBars
{
    
    _expBar.scaleX = _expSpider/3.0;
    if(_expSpider==3)
    {
       
        LevelUp *new = (LevelUp*)[CCBReader loadAsScene:@"NewMove"];
        [self addChild:new];
        LevelUp *levelup = (LevelUp*)[CCBReader loadAsScene:@"LevelUp"];
        [self addChild:levelup];
        [data.unlockedAttacks addObject:@"Bomb"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"Bomb"];
                [[NSUserDefaults standardUserDefaults] setInteger:20 forKey:@"Spider"];
        [[NSUserDefaults standardUserDefaults] synchronize];

           data.gameProgress = 4;
    }
    
    
}
-(void)updateExpBars2
{
    if([[NSUserDefaults standardUserDefaults] integerForKey:_mainCharacter.ccbDirectory]<10)
    {
        float a = [[NSUserDefaults standardUserDefaults] integerForKey:_mainCharacter.ccbDirectory];
        
           _expBar.scaleX = a/10.0;

        
    }
    else
    {
            _expBar.scaleX = 1.0;
    }



    
    
}
-(void)checkForContactWithDeadBody
{
    if(_touchedDB)
    {
   
        float x1,y1;
        x1 = _mainCharacter.position.x;
        y1 = _mainCharacter.position.y;
        
        //spawn if there are currently no creatures under that spawnnode
            int temphp = _mainCharacter.health;
        [_mainCharacter removeFromParent];
        
        _mainCharacter =(Creature *)[CCBReader load:touchedBody];
        _mainCharacter.ccbDirectory = touchedBody;
        _mainCharacter.maxhealth = 20;
        _mainCharacter.physicsBody.collisionGroup = @"good";
        _mainCharacter.health = _mainCharacter.maxhealth;
          _mainCharacter.right = -1;
        _mainCharacter.position = _myChar.position;
        CCNode* aura =[CCBReader load:@"Aura"];
        aura.position = ccp(30,20);
        [_mainCharacter addChild:aura];
        [_levelNode.children[0] addChild:_mainCharacter];
        //follow = [CCActionFollow actionWithTarget:_mainCharacter worldBoundary:[_levelNode.children[0] boundingBox]];
        
        //_physicsNode.position = [follow currentOffset];
        //[_physicsNode runAction:follow];
               _mainCharacter.position = ccp(x1,y1);
        while(_mainCharacter.health!=temphp)
        {
            _mainCharacter.health--;
        }
        _myHP.string = _mainCharacter.ccbDirectory;
        spawned = false;
        
        _touchedDB = false;
    }

}
-(void)spawnEnemyAtSpawnNode: (NSNumber*) spawnnum
{
 
    NSInteger p = [spawnnum integerValue];

        int i = arc4random()%[creatures count];
    
        NSString *temp = creatures[i];
        Creature* enemy =  (Creature *)[CCBReader load:temp];
    enemy.attack = attacks[i];
        enemy.ccbDirectory = temp;
        enemy.target = _mainCharacter;
        enemy.physicsBody.sensor = true;
        enemy.physicsBody.affectedByGravity = false;
        enemy.physicsBody.collisionGroup = @"bad";
    if([enemy.ccbDirectory isEqualToString:@"Spider"])
    {
        enemy.health = 1.0;
        enemy.maxhealth =1.0;
    }
    else if([enemy.ccbDirectory isEqualToString:@"Goblin"])
    {
        enemy.health = 2.0;
        enemy.maxhealth =2.0;
    }
    else if([enemy.ccbDirectory isEqualToString:@"Mage"])
    {
        enemy.health = 3.0;
        enemy.maxhealth =3.0;
    }
    else if([enemy.ccbDirectory isEqualToString:@"Golemn"])
    {
        enemy.health = 4.0;
        enemy.maxhealth =4.0;
    }
    
        enemy.position = [([_levelNode.children[0] children][p]) positionInPoints];
    NSLog(@"%f",enemy.position.y);
   
        enemy.spawnNodeNum = p;

        [_levelNode.children[0] addChild:enemy];
        [_aliveSetOfCreatures addObject:enemy];
        
        // _mainCharacter.target = enemy;
    
        
        NSLog(@"%d",_spawnNode.children.count);
    


    
}

-(void)spawnEnemies
{
    //if(!spawned&&numOfEnemies==0&&((int)_timeSinceGameStart)%10==0)
    while(((int)_timeSinceGameStart)%10==0&&[_deadSetOfCreatures count]>0)
    {
        numOfEnemies++;
        spawned = true;
        //if(_spawnNode.children.count==0)
        // {
        NSLog(@"spwaned");
        int i = arc4random()%[creatures count];
        NSString *temp = creatures[i];
            Creature* enemy=(Creature *)[CCBReader load:temp];
         enemy.attack = attacks[i];
        enemy.ccbDirectory = temp;
        enemy.target = _mainCharacter;
        enemy.physicsBody.sensor = true;
        enemy.physicsBody.affectedByGravity = false;
                enemy.physicsBody.collisionGroup = @"bad";
        [_levelNode.children[0] addChild:enemy];
        //enemy.position = _spawnNode.position;
       int p = [[_deadSetOfCreatures objectAtIndex:0] integerValue];
        
       enemy.position = [([_levelNode.children[0] children][p]) positionInPoints];
        enemy.spawnNodeNum = p;
        [_deadSetOfCreatures removeObjectAtIndex:0];
        [_aliveSetOfCreatures addObject:enemy];

        
       // _mainCharacter.target = enemy;
        
        NSLog(@"%d",_spawnNode.children.count);
        
        //}
    }

}

- (void)update:(CCTime)delta
{
    _coinLabel.string = [NSString stringWithFormat:@"Kill %d Monsters", 10-_killedEnemyCount];
    NSLog(_mainCharacter.ccbDirectory);
        NSLog(@"my exp is %d", [[NSUserDefaults standardUserDefaults] integerForKey:_mainCharacter.ccbDirectory]);
    if(!_physicsNode.paused)
    {
//        if(_paused)
//        {
//            NSLog(@"called");
//                 _paused=false;
//            _physicsNode.paused = false;
//        }
   
        

        if(_closeAttackActivated)
        {
            
            [self updateAttack:_mainCharacter.children[2]];

        }
        if([_setOfAttacks count]>0)
        {
            for(int i = 0; i<[_setOfAttacks count];i++)
            {
                [self updateAttack:[_setOfAttacks objectAtIndex:i]];
            }
            
        }
        [self checkIfPlayerDied];
        //[self removeDeadCreatures];
        [self checkForContactWithDeadBody];
        
        //[self spawnEnemies];
        
        [self updateAllEnemies:_aliveSetOfCreatures];
        
        
        [self updateCreatureLocation:_mainCharacter];
        
        
        [self updateHealthBar];
        
        [self hurt];
        //[self updateExpBars];
        
        [self resetJump];
        [self checkPlayerWalk];
        
        
        [self checkForContactWithCloseAttack];
 
        _timeSinceGameStart+=delta;
        NSLog(@"%f",_timeSinceGameStart);
        
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"didFinishTutorial"]!=nil)
        {
                [self spawn];
        }
    
       
    }
}
-(void)checkPlayerWalk
{
    if(_mainCharacter.physicsBody.velocity.x>0)
    {
        if([_mainCharacter.animationManager runningSequenceName]==nil)
        {
            [_mainCharacter.animationManager runAnimationsForSequenceNamed:@"WalkR"];
        }
        
    }
    else if(_mainCharacter.physicsBody.velocity.x<0)
    {
        if([_mainCharacter.animationManager runningSequenceName]==nil)
        {
            [_mainCharacter.animationManager runAnimationsForSequenceNamed:@"WalkL"];
        }
        
        
        
    }
}
-(void)spawn
{
    if(_timeSinceGameStart>4.0)
    {
        _timeSinceGameStart=0.0;
        [self spawnEnemyAtSpawnNode:[NSNumber numberWithInt:(arc4random()%3)+1]];
    }
}

-(void)creature: (Creature*) c1 attack:(NSString*) str
{
    if([str isEqual:@"NinjaStar"])
    {
        CCNode *NinjaStar = [CCBReader load:@"FireBall"];
       // NinjaStar.physicsBody.collisionType = c1.physicsBody.collisionType;
         NinjaStar.physicsBody.collisionGroup = c1.physicsBody.collisionGroup;
       
        NinjaStar.physicsBody.sensor = YES;
        [NinjaStar.physicsBody setAngularVelocity:10.0];
        NinjaStar.position = ccpAdd(c1.position, ccp(0, 20));

        [_physicsNode addChild:NinjaStar];
        [NinjaStar.physicsBody setVelocity:CGPointMake(c1.right*80, 0)];
        [self performSelector:@selector(eraseAttack:) withObject:NinjaStar afterDelay:15.0f];
        
      
    }
    else if([str isEqual:@"BodySwap"])
    {
        
        if(!_closeAttackActivated)
        {
            CCNode *bodySwap = [CCBReader load:@"BodySwap"];
            // NinjaStar.physicsBody.collisionType = c1.physicsBody.collisionType;
            
            bodySwap.physicsBody.collisionGroup = c1.physicsBody.collisionGroup;
            
            bodySwap.physicsBody.sensor = YES;
            
            bodySwap.position = ccp(c1.right*40+30, 30);
         
            [c1 addChild:bodySwap];
            
            _closeAttackActivated = true;
//            
//            CCPhysicsJoint *myJoint  = [CCPhysicsJoint connectedDistanceJointWithBodyA:_mainCharacter.physicsBody bodyB: bodySwap.physicsBody anchorA:_mainCharacter.anchorPointInPoints anchorB:bodySwap.anchorPointInPoints minDistance:20.0 maxDistance:20.0];
           }
         _closeAttack = 70;
        

        

        
        //CGPoint launchDirection = ccp(c1.right, 0);
        //CGPoint force = ccpMult(launchDirection, 8000);
        //[NinjaStar.physicsBody applyForce:force];
}
    else if([str isEqual:@"Bomb"])
    {
        CCNode *bomb = [CCBReader load:@"Bomb"];
        // NinjaStar.physicsBody.collisionType = c1.physicsBody.collisionType;
        bomb.physicsBody.collisionGroup = c1.physicsBody.collisionGroup;
        
      
        
        bomb.physicsBody.sensor = true;
        bomb.position = c1.position;
        
        [_physicsNode addChild:bomb];
        
        [self performSelector:@selector(physicalizeAttack:) withObject:bomb afterDelay:1.0];
        
    }
    else if([str isEqual:@"Barrier"])
    {
        BOOL alreadyDone = false;

        for(int i = 0;i<[_setOfAttacks count];i++)
        {
            if([[[_setOfAttacks objectAtIndex:i] physicsBody].collisionType isEqualToString:str])
            {
                alreadyDone = true;
            }
        }
        if(!alreadyDone)
        {
            CCNode *a1 = [CCBReader load:str];
     
            a1.physicsBody.collisionGroup = c1.physicsBody.collisionGroup;
            
            
            a1.physicsBody.sensor = YES;
            
            
            a1.position = ccp([a1.children[0] contentSize].width/2,[a1.children[0] contentSize].height/2);
            
            [c1 addChild:a1];
            //[_setOfAttacks addObject:a1];
            [self followParent:a1];
            
            [self performSelector:@selector(eraseAttack:) withObject:a1 afterDelay:2.0];
        }

        
    }
    else if([str isEqual:@"RockSlide"])
    {
        if(c1==_mainCharacter)
        {
            if(_mainCharacter.target!=nil)
            {
                CCNode *a1 = [CCBReader load:str];
                
                a1.physicsBody.collisionGroup = c1.physicsBody.collisionGroup;
                
                [a1.physicsBody setAngularVelocity:10.0];
                [a1.physicsBody setVelocity:ccp(0,-10)];
                a1.physicsBody.sensor = YES;
                
                
                a1.position = ccp(c1.target.position.x,c1.target.position.y+100 );
                
                [_physicsNode addChild:a1];
                
                
                
                [self performSelector:@selector(eraseAttack:) withObject:a1 afterDelay:2.0];
            }
        }
        else
        {
            CCNode *a1 = [CCBReader load:str];
            
            a1.physicsBody.collisionGroup = c1.physicsBody.collisionGroup;
            
            [a1.physicsBody setAngularVelocity:10.0];
            [a1.physicsBody setVelocity:ccp(0,-10)];
            
            a1.physicsBody.sensor = YES;
            
            
            a1.position = ccp(c1.target.position.x,c1.target.position.y+100 );
            
            [_physicsNode addChild:a1];
            
            
            
            [self performSelector:@selector(eraseAttack:) withObject:a1 afterDelay:2.0];
        }
        
        
        
        
    }
    else if ([str isEqualToString:@"Punch"])
    {
        CCNode *a1 = [CCBReader load:str];
        a1.rotation = 45.0+c1.right*45.0;
        
        a1.physicsBody.collisionGroup = c1.physicsBody.collisionGroup;
        
        [a1.physicsBody setVelocity:ccp(c1.right*50.0,50.0)];
                a1.physicsBody.sensor = YES;
        
        
        a1.position = ccpAdd(c1.position,ccp(c1.right*20+15.0, 0));

        
        [_physicsNode addChild:a1];
        
        [self performSelector:@selector(eraseAttack:) withObject:a1 afterDelay:.5];
    }
}

-(void)updateAttack:(CCNode*)a1
{
    if(a1!=nil)
    {
        [a1.physicsBody setVelocity:ccp([[a1 parent] physicsBody].velocity.x,[[a1 parent] physicsBody].velocity.y)];
    }
}
-(void)followParent:(CCNode*) child
{
    if(child!=nil)
    {
        [child.physicsBody setVelocity:ccp([[child parent] physicsBody].velocity.x,[[child parent] physicsBody].velocity.y)];
        [self performSelector:@selector(followParent:) withObject:child afterDelay:.1f];
    }
    
}
-(void)physicalizeAttack:(CCNode*) bomb
{
    if(bomb!=nil)
    {
        bomb.physicsBody.collisionType = @"HarmBomb";
        [self performSelector:@selector(erasemyAttack:) withObject:bomb afterDelay:.5];
    }

}

-(void)eraseAttack:(CCNode*) attack
{
    if(attack!=nil)
    {
        [_setOfAttacks removeObject:attack];
        [attack removeFromParent];
    }
}
-(void)erasemyAttack:(CCNode*) bomb
{
    if(bomb!=nil)
    {
        [bomb removeFromParent];
    }
}


-(void)eraseMove:(NSString*) str
{
    _attemptingMove = _myMoves;
    NSString* moveString = str;
    while(moveString.length>0)
    {
        
        if([moveString characterAtIndex:(0)]=='r')
        {
            
            _attemptingMove = _attemptingMove.Right;
            
            
        }
        else if([moveString characterAtIndex:(0)]=='l')
        {
            _attemptingMove = _attemptingMove.Left;
        }
        else if([moveString characterAtIndex:(0)]=='u')
        {
            _attemptingMove = _attemptingMove.Up;
        }

        else if([moveString characterAtIndex:(0)]=='d')
        {
            _attemptingMove = _attemptingMove.Down;
        }
        moveString = [moveString substringFromIndex:(1)];
    }
    
    _attemptingMove.attack = nil;
}
-(void)checkForUpdate:(NSString*) str
{
    if(![data.unlockedAttacks containsObject:str])
    {
        [data.unlockedAttacks addObject:str];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:str];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
-(void)gainExp
{
    if(![_mainCharacter.ccbDirectory isEqualToString:@"Ghost"])
    {
       
        [[NSUserDefaults standardUserDefaults] setInteger: [[NSUserDefaults standardUserDefaults] integerForKey:_mainCharacter.ccbDirectory]+1 forKey: _mainCharacter.ccbDirectory];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    NSLog(@"my exp is %d", [[NSUserDefaults standardUserDefaults] integerForKey:_mainCharacter.ccbDirectory]);
}
-(void)checkForCharacter:(Creature*) crit
{
    if( [[NSUserDefaults standardUserDefaults] objectForKey:crit.ccbDirectory]==nil)
    {
        [[NSUserDefaults standardUserDefaults] setObject:0 forKey:crit.ccbDirectory];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    _currentCreatureExp = [[NSUserDefaults standardUserDefaults] integerForKey:crit.ccbDirectory];

}

-(void)learnNewSkill
{
    NSLog(@"%d",_currentCreatureExp);
    if([[NSUserDefaults standardUserDefaults] integerForKey:_mainCharacter.ccbDirectory]==10)
    {
        NSLog(@"yea");
        if(![data.unlockedAttacks containsObject:_currentWorkingAttack])
        {
            [data.unlockedAttacks addObject:_currentWorkingAttack];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:_currentWorkingAttack];
            [[NSUserDefaults standardUserDefaults] synchronize];
             
            LevelUp* yeh2 = [CCBReader load:@"PopUp2" owner:self];
            ((CCLabelTTF*)[[yeh2.children[0] children] objectAtIndex:0]).fontSize = (10.0);
            ((CCLabelTTF*)[[yeh2.children[0] children] objectAtIndex:0]).string = [NSString stringWithFormat:@"New Attack: %@", _currentWorkingAttack];
            [self addChild:yeh2];
            
            LevelUp* yeh = [CCBReader load:@"PopUp2" owner:self];
            ((CCLabelTTF*)[[yeh.children[0] children] objectAtIndex:0]).fontSize = (10.0);
            ((CCLabelTTF*)[[yeh.children[0] children] objectAtIndex:0]).string = [NSString stringWithFormat:@"%@ Mastery!", _mainCharacter.ccbDirectory];
            [self addChild:yeh];
            

        }
    }
}

@end
