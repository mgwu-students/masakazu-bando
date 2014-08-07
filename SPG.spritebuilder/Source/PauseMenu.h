//
//  PauseMenu.h
//  SPG
//
//  Created by sloot on 7/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCScene.h"
#import "MoveNode.h"

@interface PauseMenu : CCScene

@property(nonatomic,weak) CCPhysicsNode* physNode;
@property(nonatomic,weak) MoveNode* myMoveNode;
@property(nonatomic,assign) int tutorialProgress;

@end
