//
//  MyScrollView.m
//  SPG
//
//  Created by sloot on 7/27/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "MyScrollView.h"
#import "GameData.h"
#import "MoveButton.h"

@implementation MyScrollView
{

    GameData* data;
    MyScrollView* _me;
}
-(void)shift
{
    self.front.position = ccp(self.front.position.x+1.0f,self.front.position.y);

}
-(void)NinjaStar
{
    
    self.myAttack = @"NinjaStar";
    
    [self shift];
 
    
}
-(void)Punch
{
    
    self.myAttack = @"Punch";
    
    [self shift];
}
-(void)BodySwap
{
    self.myAttack = @"BodySwap";
    if(data.currentTutorialProgress==0)
    {
        data.currentTutorialProgress = 1;
    }
    
    [self shift];
}
-(void)Bomb
{
    self.myAttack = @"Bomb";
    if(data.gameProgress==4)
    {
        data.gameProgress=5;
    }
    
    [self shift];
}
-(void)Barrier
{
    
    self.myAttack = @"Barrier";
    
    [self shift];
}
-(void)RockSlide
{
    
    self.myAttack = @"RockSlide";
    
  [self shift];
}
- (void)onEnter
{
    
    [super onEnter];
    self.userInteractionEnabled = YES;
    data= [GameData sharedData];
    //self.scaleY= .5;
    if([data.unlockedAttacks count]>5)
    {
        float a = 0;
        a+=[data.unlockedAttacks count];
        self.contentSize = CGSizeMake(self.contentSize.width,self.contentSize.height*(a/5.0));
    }
    
    
    //[self convertContentSizeToPoints:CGSizeMake(200, 200) type:self.contentSizeType];
    
    //[self convertContentSizeToPoints:<#(CGSize)#> type:]
    
    for(int i = 0; i<[data.unlockedAttacks count];i++)
    {
        
        
        MoveButton* myButton = (MoveButton*)[CCBReader load:@"MyButton"];
        
        [((CCButton*)(myButton.children[0])) label].string = [data.unlockedAttacks objectAtIndex:i];
        
        
        if([[data.unlockedAttacks objectAtIndex:i] isEqualToString:@"BodySwap"])
        {
            [((CCButton*)(myButton.children[0])) setTarget:self selector:@selector(BodySwap)];
        }
        else if([[data.unlockedAttacks objectAtIndex:i] isEqualToString:@"NinjaStar"])
        {
            [((CCButton*)(myButton.children[0])) setTarget:self selector:@selector(NinjaStar)];
  
        }
        else if([[data.unlockedAttacks objectAtIndex:i] isEqualToString:@"Bomb"])
        {
            [((CCButton*)(myButton.children[0])) setTarget:self selector:@selector(Bomb)];
        }
        else if([[data.unlockedAttacks objectAtIndex:i] isEqualToString:@"RockSlide"])
        {
            [((CCButton*)(myButton.children[0])) setTarget:self selector:@selector(RockSlide)];
        }
        else if([[data.unlockedAttacks objectAtIndex:i] isEqualToString:@"Barrier"])
        {
            [((CCButton*)(myButton.children[0])) setTarget:self selector:@selector(Barrier)];
        }
        else if([[data.unlockedAttacks objectAtIndex:i] isEqualToString:@"Punch"])
        {
            [((CCButton*)(myButton.children[0])) setTarget:self selector:@selector(Punch)];
        }
        
        
 
        myButton.position = ccp(64,(self.contentSize.height)*320-64.0*i-32.0);
        [self addChild:myButton];
//        CCButton *backButton = [CCButton buttonWithTitle:@"[ Back ]" fontName:@"Verdana-Bold" fontSize:18.0f];
//        backButton.positionType = CCPositionTypeNormalized;
//        backButton.position = ccp(0.95f, 0.95f); // Top Right of screen
//        [backButton setTarget:self selector:@selector(BackClicked:)];
//        [self addChild:backButton];
        
    }
 
}
-(void)BackClicked
{
    
    NSLog(@"SWAGER");
}

-(void)touchBegan:(UITouch *)touches withEvent:(UIEvent *)event
{
    NSLog(@"fck this shit");
}

@end
