//
//  MainScene.h
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "CCScene.h"

@interface MainScene : CCScene <CCPhysicsCollisionDelegate>
@property(nonatomic,assign) int numOfSpawnNodes;

@property(nonatomic,weak) NSString* levelName;
-(BOOL)playerMoved;
@end
