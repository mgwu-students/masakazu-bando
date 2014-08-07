//
//  CreatureQueue.m
//  SPG
//
//  Created by mike bando on 7/21/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CreatureQueue.h"


@implementation CreatureQueue
-(void) add:(Creature*) c1
{
        if(self.head==nil)
    {
        self.head = [[CreatureNode alloc]initWithData:(c1) andNext:nil];
    }
    else
    {
        self.head = [[CreatureNode alloc]initWithData:(c1) andNext:self.head];
    }
}
-(void) deleteDead
{
    
    if(self.head!=nil)
    {
      
        
        while(self.head.data.health<1)
        {
            self.head = self.head.next;
        }
        
        CreatureNode* pointer = self.head;
        while(pointer.next!=nil)
        {
            if(pointer.next.data.health<1)
            {
                [pointer setNext:pointer.next];
            }
            else
            {
                pointer = pointer.next;
            }
        }
        

    }


    
}
@end
