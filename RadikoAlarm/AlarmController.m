//
//  AlarmController.m
//  RadikoAlarm
//
//  Created by tetsurou on 5/13/16.
//  Copyright © 2016 Teturou Nishioka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlarmController.h"

@implementation AlarmController : NSObject

-(id)init{
    active = NO;
    snooze = NO;
    startTime=[NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)0];
    endTime=[NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)0];
    return self;
}

-(id)initWithTime:(NSDate *)date{
    id returnee = self.init;
    [self SetTime:date];
    active=YES;
    return returnee;
}

-(void)SetTime:(NSDate *)date{
    startTime = date;
    endTime = [NSDate dateWithTimeInterval:10 sinceDate:startTime];
}

-(void)SetEverydayActive{
    
}

@end
