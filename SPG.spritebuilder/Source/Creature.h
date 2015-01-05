//
//  Creature.h
//  SPG
//
//  Created by mike bando on 7/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Creature : CCSprite
    @property(nonatomic,strong) NSString* ccbDirectory;
@property (nonatomic,assign) float health;
@property (nonatomic,assign) float maxhealth;
@property (nonatomic,assign) int right;
@property (nonatomic,assign) BOOL good;
@property (nonatomic,assign) float targetXPoint;
@property (nonatomic,assign) BOOL atTargetXPoint;
@property (nonatomic,assign) BOOL justFinishedAttacking;
@property (nonatomic,assign) float maxMovement;
@property (nonatomic,assign) float originalX;
@property (nonatomic,assign) BOOL finishedMoving;
@property (nonatomic,assign) BOOL moveDirection;
@property (nonatomic,assign) int attackDelay;
@property (nonatomic,assign) BOOL isDead;
@property (nonatomic,assign) int spawnNodeNum;
@property (nonatomic,strong) NSString* attack;
@property (nonatomic,weak) Creature* target;
@property (nonatomic,strong) NSString* workingAttack;
@property (nonatomic,assign) BOOL usingBarrier;
@property (nonatomic, assign) BOOL isBoss;
@end
