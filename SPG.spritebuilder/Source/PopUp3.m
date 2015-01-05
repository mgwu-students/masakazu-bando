//
//  PopUp3.m
//  Parasitic Souls
//
//  Created by sloot on 8/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "PopUp3.h"
#import "GameData.h"
@implementation PopUp3
{
    GameData* data;
}
-(void)Yes
{
    data = [GameData sharedData];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:[NSString stringWithFormat: @"%@%@",@"didFinishTutorial",data.dataType]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self removeFromParent];
}

-(void)No
{
        [self removeFromParent];
}

- (void)onEnter
{

    [super onEnter];

    self.userInteractionEnabled = YES;

}




#pragma mark-
-(void)touchBegan:(UITouch *)touches withEvent:(UIEvent *)event
{
    
}
@end
