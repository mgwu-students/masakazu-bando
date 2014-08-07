//
//  MoveNode.h
//  SPG
//
//  Created by mike bando on 7/12/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"


@interface MoveNode : CCNode
    @property(nonatomic,strong) MoveNode* Right;
    @property(nonatomic,strong) MoveNode* Left;
    @property(nonatomic,strong) MoveNode* Up;
    @property(nonatomic,strong) MoveNode* Down;

    @property(nonatomic,weak) NSString* attack;


@end
