//
//  CreatureQueue.h
//  SPG
//
//  Created by mike bando on 7/21/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "CreatureNode.h"

@interface CreatureQueue : CCNode
@property(nonatomic,strong) CreatureNode* head;
-(void) add:(Creature*) c1;
-(void) deleteDead;
@end
