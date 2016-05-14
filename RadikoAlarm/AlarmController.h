//
//  AlarmController.h
//  RadikoAlarm
//
//  Created by tetsurou on 5/13/16.
//  Copyright © 2016 Teturou Nishioka. All rights reserved.
//

#ifndef AlarmController_h
#define AlarmController_h

//This class save,configure and invoke alarm
@interface AlarmController : NSObject
{
    BOOL active; //TRUE= this alarm is active
    BOOL snooze;
    BOOL repeatWeekDay[7]; //TRUE=weekday to ring
    NSDate *startTime;
    NSDate *endTime;
}

@property (readwrite) BOOL enabled;

@end

#endif /* AlarmController_h */
