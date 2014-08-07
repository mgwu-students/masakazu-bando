//
//  Creature.m
//  SPG
//
//  Created by mike bando on 7/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Creature.h"

@implementation Creature
-(void)didLoadFromCCB
{
    self.right = 1;
    self.good = false;
    self.targetXPoint = 0.0;
    self.atTargetXPoint = true;
    self.justFinishedAttacking = false;
    self.maxMovement = 50.0;
    self.finishedMoving = true;
    self.moveDirection =1;
    self.attackDelay = 0;
    self.maxhealth = 5;
    self.health = self.maxhealth;
    self.isDead = false;
    NSLog(@"got called from ccb");
}
@end
