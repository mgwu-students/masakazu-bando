//
//  DeadBody.h
//  SPG
//
//  Created by mike bando on 7/11/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface DeadBody : CCSprite
    @property(nonatomic,strong) NSString* ccbDirectory;
@property(nonatomic,assign) int spawnNodeNum;
@end

