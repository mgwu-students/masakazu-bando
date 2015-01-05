//
//  SwipeSet.m
//  SPG
//
//  Created by mike bando on 7/12/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "SwipeSet.h"
#import "MyScrollView.h"
#import "Tutorial.h"
#import "GameData.h"
#import "LevelUp.h"

@implementation SwipeSet{
    CCNode* _front;
    CCNode* _back;
    MoveNode* _attemptingMove;
    NSString* movePattern;
    MoveNode* _myMoves;
    CGPoint _current;
    
    BOOL doubleTap;
    float box;
    BOOL _touchInitiated;
    CCNode* _moveMap;
    BOOL _paused;
    int left,right,up,down;
    BOOL _failed;
       NSUInteger tapCount;
    BOOL _swipeInitiated;
    BOOL _configuringMap;
    BOOL _configuringButtons;
    NSString* _selectedAttack;
    CCScrollView* _myScrollView;
    CCSprite* _grid;
    CCLabelTTF* _label;
     CCLabelTTF* _label2;
    GameData* data;
    int maxRight, maxLeft,maxUp,maxDown;
    BOOL _finishedMove;
    NSString* dataType;
    
}
-(void)setMoveNode: (MoveNode*) mn
{
    _myMoves = mn;
}
-(void)update:(CCTime)delta
{
    if([_myScrollView.children[0] myAttack]==nil)
    {
        _grid.opacity = 0.0;
    }
    else
    {
        _grid.opacity = 100.0;
        _label.string = [_myScrollView.children[0] myAttack];
        _label2.string =  [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat: @"%@%@",[_myScrollView.children[0] myAttack],dataType]];
        
    }
    
}

- (void)onEnter
{
    
      data= [GameData sharedData];
    dataType = data.dataType;
    _swipeInitiated = false;
    tapCount = 0;
    [super onEnter];
    _touchInitiated = false;

    doubleTap = false;
    // accept touches on the grid
    self.userInteractionEnabled = YES;
    NSLog(@"gucci");
    [self cursorStart];
    [self addTutorial];
    ((MyScrollView*)([[_myScrollView children] objectAtIndex:0])).front = _front;
    
    
}
-(void)addTutorial
{
    Tutorial* myTutorial = (Tutorial*)[CCBReader load:@"TutorialBackground"];
    myTutorial.physNode = self.physicsNode;
    [self addChild:myTutorial];
}
-(void)didLoadFromCCB
{
    self._isPaused = false;
    box = 83.0;
    
    NSLog(@"loaded");
    
}


#pragma mark-
-(void)touchBegan:(UITouch *)touches withEvent:(UIEvent *)event {
    movePattern=@"";
    
    CGPoint touchPoint = [touches locationInNode:self];
   
   
    if([_myScrollView.children[0] myAttack]!=nil)
    {
     
        _failed = false;
        
        tapCount = [touches tapCount];
        
        NSLog(@"touchbegan");
        _touchInitiated = true;
        
        right = 0;
        up = 0;
        
        _current = touchPoint;
        
        _moveMap = [CCBReader load:@"Star"];
        ((CCNode*)([[_moveMap children] objectAtIndex:0])).visible = false;
        _moveMap.position = touchPoint;
       
        
        
        CCNode* s2 = [CCBReader load:@"Star"];
        [_moveMap addChild:s2];
        s2.position = ccp(s2.position.x+50.0*right+12.0,s2.position.y+50.0*up+12.0);
        
        
      
        [self addChild:_moveMap];
        _attemptingMove =self.myMoveNode;
        maxRight=0;
        maxLeft = 0;
        maxUp=0;
        maxDown = 0;
           _finishedMove = false;
    }
    
}

-(void)Save
{
    [self saveAttack: [_myScrollView.children[0] myAttack] withPattern:movePattern];
}
-(void)Choose
{
    _front.position = ccp(_front.position.x-1.0f,_front.position.y);

}
- (void)touchMoved:(UITouch *)touches withEvent:(UIEvent *)event {
    if([_myScrollView.children[0] myAttack]!=nil&&!_finishedMove)
    {
        NSLog(@"touchmoved");
        CGPoint positionInScene = [touches locationInNode:self];
        
        if(positionInScene.x-_current.x>box/2)
        {
            if(maxRight-maxLeft>1&&right==maxRight)
            {
                _finishedMove = true;

            }
            else
            {
                movePattern = [NSString stringWithFormat:@"%@r", movePattern ];
                
                _swipeInitiated = true;
              
                _current = ccp(_current.x+box, _current.y);
                right++;
                if(right>maxRight)
                {
                    maxRight = right;
                }
                CCNode* s2 = [CCBReader load:@"Star"];
                [_moveMap addChild:s2];
                s2.position = ccp(s2.position.x+box*right+12.0,s2.position.y+box*up+12.0);

            }
            
        }
        else if(positionInScene.x-_current.x<-box/2)
        {
            if(maxRight-maxLeft>1&&right==maxLeft)
            {
                _finishedMove = true;

            }
            else
            {
                movePattern = [NSString stringWithFormat:@"%@l", movePattern ];
                
                _swipeInitiated = true;
               
                _current = ccp(_current.x-box, _current.y);
                right--;
                if(right<maxLeft)
                {
                    maxLeft = right;
                }
                CCNode* s2 = [CCBReader load:@"Star"];
                [_moveMap addChild:s2];
                s2.position = ccp(s2.position.x+box*right+12.0,s2.position.y+box*up+12.0);

            }
            
        }
        else if(positionInScene.y-_current.y>box/2)
        {
            if(maxUp-maxDown>1&&up==maxUp)
            {
                _finishedMove = true;

            }
            else
            {
                
                movePattern = [NSString stringWithFormat:@"%@u", movePattern ];
                
                _swipeInitiated = true;
                
                _current = ccp(_current.x, _current.y+box);
                up++;
                if(up>maxUp)
                {
                    maxUp = up;
                }
                CCNode* s2 = [CCBReader load:@"Star"];
                [_moveMap addChild:s2];
                s2.position = ccp(s2.position.x+box*right+12.0,s2.position.y+box*up+12.0);

            }
        }
        else if(positionInScene.y-_current.y<-box/2)
        {
            if(maxUp-maxDown>1&&up==maxDown)
            {
                _finishedMove = true;

            }
            else
            {
                
                
                movePattern = [NSString stringWithFormat:@"%@d", movePattern ];
                
                
                _swipeInitiated = true;
                
                
                // add scene transition logic
                
                
                _current = ccp(_current.x, _current.y-box);
                up--;
                if(up<maxDown)
                {
                    maxDown = up;
                }
                CCNode* s2 = [CCBReader load:@"Star"];
                [_moveMap addChild:s2];
                s2.position = ccp(s2.position.x+box*right+12.0,s2.position.y+box*up+12.0);
            }
        }
        
    }

}

- (void)touchEnded:(UITouch *)touches withEvent:(UIEvent *)event {


  
    if([_myScrollView.children[0] myAttack]!=nil)
    {
        NSLog(@"touchended");
        
        
        if(!_swipeInitiated)
        {

            
        }
        else{
            NSLog(@"DONE");
    
            _attemptingMove.attack = [_myScrollView.children[0] myAttack];
            
            if(data.currentTutorialProgress==1)
            {
                data.gameProgress = 2;
            }
            
            
            
            
            _swipeInitiated = false;
        }
        
        tapCount = 0;
        _touchInitiated = false;
        [_moveMap removeFromParent];
        _moveMap = nil;
        
        
    }
}


-(void)Back
{
    [self removeFromParent];
}
-(void)cursorStart
{
    if(self.tutorialProgress==2)
    {
        CCNode* pointer = (CCNode*)[CCBReader load:@"Pointer"];
        pointer.position = ccp(370,-10);
        [[[_back children] objectAtIndex:0] addChild:pointer];
        
        [self performSelector:@selector(cursorEnd) withObject:nil afterDelay:.3];
    }
    
    
}
-(void)cursorEnd
{
    [[[_back children] objectAtIndex:0] removeAllChildren];
    
    [self performSelector:@selector(cursorStart) withObject:nil afterDelay:.3];
}
-(void)saveAttack:(NSString*)attk withPattern:(NSString*) str
{
    MoveNode* _move = data.myMoves;
    NSString* moveString = str;
    while(moveString.length>0)
    {
        
        if([moveString characterAtIndex:(0)]=='r')
        {
            if(_move.Right==nil)
            {
                _move.Right = [[MoveNode alloc] init];
                
            }
            _move = _move.Right;
            
            
        }
        else if([moveString characterAtIndex:(0)]=='l')
        {
            if(_move.Left==nil)
            {
                _move.Left = [[MoveNode alloc] init];
                
            }
            _move = _move.Left;
            
        }
        else if([moveString characterAtIndex:(0)]=='u')
        {
            if(_move.Up==nil)
            {
                _move.Up = [[MoveNode alloc] init];
                
            }
            _move = _move.Up;
            
        }
        
        else if([moveString characterAtIndex:(0)]=='d')
        {
            if(_move.Down==nil)
            {
                _move.Down = [[MoveNode alloc] init];
                
            }
            _move = _move.Down;
            
        }
        moveString = [moveString substringFromIndex:(1)];
    }
    
    if(_move.attack==nil)
    {

        if([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat: @"%@%@",attk,dataType]]==nil)
        {
            _move.attack = attk;
            [[NSUserDefaults standardUserDefaults] setObject:str forKey:[NSString stringWithFormat: @"%@%@",attk,dataType]];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else
        {
            _move.attack = attk;
            [self eraseMove:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat: @"%@%@",attk,dataType]]];
            [[NSUserDefaults standardUserDefaults] setObject:str forKey:[NSString stringWithFormat: @"%@%@",attk,dataType]];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
    }
    else
    {
        LevelUp* yeh = (LevelUp*)[CCBReader load:@"PopUp2" owner:self];
        ((CCLabelTTF*)[[yeh.children[0] children] objectAtIndex:0]).fontSize = (10.0);
        ((CCLabelTTF*)[[yeh.children[0] children] objectAtIndex:0]).string = [NSString stringWithFormat:@"That pattern is currently used for your attack: %@", _move.attack];
        [self addChild:yeh];
    }
  
    
}
-(void)eraseMove:(NSString*) str
{
    MoveNode* _tempmove = data.myMoves;
    NSString* moveString = str;
    while(moveString.length>0)
    {
        
        if([moveString characterAtIndex:(0)]=='r')
        {
            
            _tempmove = _tempmove.Right;
            
            
        }
        else if([moveString characterAtIndex:(0)]=='l')
        {
            _tempmove = _tempmove.Left;
        }
        else if([moveString characterAtIndex:(0)]=='u')
        {
            _tempmove = _tempmove.Up;
        }
        
        else if([moveString characterAtIndex:(0)]=='d')
        {
            _tempmove = _tempmove.Down;
        }
        moveString = [moveString substringFromIndex:(1)];
    }
    
    _tempmove.attack = nil;
}
@end
