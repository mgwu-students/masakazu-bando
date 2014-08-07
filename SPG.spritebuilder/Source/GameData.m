//
//  GameData.m
//  SPG
//
//  Created by sloot on 7/31/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameData.h"


@implementation GameData
static GameData *sharedData = nil;
+(GameData*) sharedData{
    if(sharedData == nil){
        sharedData = [[GameData alloc]init];
    }
    return sharedData;
}
@end
