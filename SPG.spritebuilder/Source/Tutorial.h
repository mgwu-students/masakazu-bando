//
//  Tutorial.h
//  SPG
//
//  Created by sloot on 8/5/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCScene.h"
#import "Creature.h"
#import "MoveNode.h"

@interface Tutorial : CCScene  <CCPhysicsCollisionDelegate>
@property(nonatomic,weak) Creature* me;
@property(nonatomic,weak) CCPhysicsNode* physNode;
@property(nonatomic,weak) MoveNode* myMoves;
@end
