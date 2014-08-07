//
//  SwipeSet.h
//  SPG
//
//  Created by mike bando on 7/12/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCScene.h"
#import "MoveNode.h"
@interface SwipeSet : CCScene


    @property(nonatomic,assign) BOOL _isPaused;
@property(nonatomic,weak) MoveNode* myMoveNode;
@property(nonatomic,assign) int tutorialProgress;
-(void)setMoveNode: (MoveNode*) mn;
@property(nonatomic,weak)CCPhysicsNode* physnode;


@end
