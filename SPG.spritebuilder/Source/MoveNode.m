//
//  MoveNode.m
//  SPG
//
//  Created by mike bando on 7/12/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "MoveNode.h"

@implementation MoveNode

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.Right = nil;
        self.Left = nil;
        self.Up = nil;
        self.Down = nil;
        self.attack = nil;
        
        return self;
    }
    
    return self;
}

@end
