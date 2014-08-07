//
//  CreatureNode.m
//  SPG
//
//  Created by sloot on 7/22/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CreatureNode.h"

@implementation CreatureNode
-(CreatureNode*)initWithData: (Creature*) d1 andNext:(CreatureNode*)n1
{
    self = [super init];
    if(self)
    {
        self.data = d1;
        self.next = n1;

    }
        return self;
}
-(void)setNext:(CreatureNode*) n1
{
    self.next = n1;
}
-(void)setData:(Creature*) n1
{
    self.data = n1;
}
@end
