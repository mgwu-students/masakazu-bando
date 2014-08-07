//
//  CreatureNode.h
//  SPG
//
//  Created by sloot on 7/22/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Creature.h"

@interface CreatureNode : CCNode
@property(nonatomic,weak) Creature* data;
@property(nonatomic,weak) CreatureNode* next;
-(CreatureNode*)initWithData: (Creature*) d1 andNext:(CreatureNode*)n1;
-(void)setNext:(CreatureNode*) n1;
-(void)setData:(Creature*) n1;
@end
