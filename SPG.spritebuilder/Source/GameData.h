//
//  GameData.h
//  SPG
//
//  Created by sloot on 7/31/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoveNode.h"

@interface GameData : NSObject

@property(nonatomic)NSString* levelname;

@property(nonatomic)MoveNode* myMoves;
@property(nonatomic)NSMutableArray* unlockedAttacks;
@property(nonatomic)NSMutableArray* unlockedCharacter;
@property(nonatomic)NSMutableArray* unlockedCharacterExp;
@property(nonatomic) int gameProgress;
@property(nonatomic) int currentTutorialProgress;
@property(nonatomic) NSString* data;
@property(nonatomic) NSString* dataType;
@property(nonatomic) int currentLevel;
@property(nonatomic) CGPoint cursorPosition;
+(GameData*) sharedData;


@end
