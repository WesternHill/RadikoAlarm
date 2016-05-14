//
//  AppDelegate.h
//  RadikoAlarm
//
//  Created by Tetsurou Nishioka on 4/19/14.
//  Copyright (c) 2014 Teturou Nishioka. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSViewController <NSApplicationDelegate,NSDatePickerCellDelegate>{
	IBOutlet NSButton *bootRadikoButton;
	IBOutlet NSButton *killRadikoButton;
	IBOutlet NSTextField *clkField;
	IBOutlet NSTextField *dateField;
    IBOutlet NSTextField *nextRingDate; // NOT implemented yet
	IBOutlet NSDatePicker *startTime;
	IBOutlet NSDatePicker *endTime;
	IBOutlet NSButton *sun;
	IBOutlet NSButton *mon;
	IBOutlet NSButton *tue;
	IBOutlet NSButton *wed;
	IBOutlet NSButton *thr;
	IBOutlet NSButton *fri;
	IBOutlet NSButton *sat;
    IBOutlet NSProgressIndicator *leftTimeIndicator;// NOT implemented yet

	NSTimer *timer;
}

-(void)bootRadiko;
-(void)killRadiko;

@property (assign) IBOutlet NSWindow *window;
@property (readwrite) IBOutlet NSButton *bootRadikoButton;
@property (readwrite) IBOutlet NSButton *killRadikoButton;

@end
