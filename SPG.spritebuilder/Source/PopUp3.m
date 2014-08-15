//
//  PopUp3.m
//  Parasitic Souls
//
//  Created by sloot on 8/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "PopUp3.h"

@implementation PopUp3
-(void)Yes
{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"didFinishTutorial"];
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
