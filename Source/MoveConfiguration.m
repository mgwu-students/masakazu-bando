//
//  MoveConfiguration.m
//  SPG
//
//  Created by mike bando on 7/12/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "MoveConfiguration.h"
#import "MoveNode.h"



@implementation MoveConfiguration
{
    
    MoveNode* _attemptingMove;
    MoveNode* _myMoves;
    CGPoint _current;
    
    
    float box;
    
}
-(void)didLoadFromCCB
{
    box = 100.0;
      self.userInteractionEnabled = YES;
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    _current = positionInScene;
    _attemptingMove = _myMoves;
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint positionInScene = [touch locationInNode:self];
    
	if(positionInScene.x-_current.x>box/2)
    {
        if(_attemptingMove.Right==nil)
        {
            _attemptingMove.Right = [[MoveNode alloc] init];
            NSLog(@"Right");
        }
        _attemptingMove = _attemptingMove.Right;
        _current = ccp(_current.x+box, _current.y);
    }
    else if(positionInScene.x-_current.x<-box/2)
    {
        if(_attemptingMove.Left==nil)
        {
            _attemptingMove.Left = [[MoveNode alloc] init];
             NSLog(@"Left");
        }
        _attemptingMove = _attemptingMove.Left;
        _current = ccp(_current.x-box, _current.y);
    }
    else if(positionInScene.y-_current.y>box/2)
    {
        if(_attemptingMove.Up==nil)
        {
            _attemptingMove.Up = [[MoveNode alloc] init];
             NSLog(@"Up");
        }
        _attemptingMove = _attemptingMove.Up;
        _current = ccp(_current.x, _current.y+box);
    }
    else if(positionInScene.y-_current.y<-box/2)
    {
        if(_attemptingMove.Down==nil)
        {
            _attemptingMove.Down = [[MoveNode alloc] init];
             NSLog(@"Down");
        }
        _attemptingMove = _attemptingMove.Down;
        _current = ccp(_current.x, _current.y-box);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(_attemptingMove.attack==nil)
    {
        //_attemptingMove.attack = [[Attack alloc] init];
        NSLog(@"DONE");
    }
}
@end
