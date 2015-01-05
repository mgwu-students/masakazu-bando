//
//  DemoScene.m
//  Parasitic Souls
//
//  Created by sloot on 8/16/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "DemoScene.h"
#import "Creature.h"

@implementation DemoScene
{
    CCNode* _spawn;
    NSArray* char1;
    
}
-(void)onEnter
{
    [super onEnter];
 
    char1 = [NSArray arrayWithObjects:@"Spider",@"Mage",@"Bat",@"Ghost",@"Goblin",@"Golemn",@"Wizard",@"DarkMonster",@"Wolf", nil];
       [self creature];
}
-(void)creature
{
   int k =  arc4random()%char1.count;
    Creature* enemy=(Creature *)[CCBReader load:char1[k]];
    [_spawn addChild:enemy];
    [enemy.animationManager runAnimationsForSequenceNamed:@"WalkL"];
    [self performSelector:@selector(remove1:) withObject:enemy afterDelay:1.0f];
    [self performSelector:@selector(creature) withObject:nil afterDelay:1.0f];

}
-(void)remove1:(Creature*)c1
{
   [c1 removeFromParent];
}
@end
