//
//  AppDelegate.m
//  RadikoAlarm
//
//  Created by Tetsurou Nishioka on 4/19/14.
//  Copyright (c) 2014 Teturou Nishioka. All rights reserved.
//

#import "AppDelegate.h"
#import "AudioController.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	//bootRadikoボタンのセットアップ
	[bootRadikoButton setTitle:@"Launch Radiko"];
	[bootRadikoButton setEnabled:YES];
	[bootRadikoButton setTarget:self];
	[bootRadikoButton setAction:@selector(bootRadiko)];
	
	//killRadikoボタンのセットアップ
	[killRadikoButton setTitle:@"Kill Radiko"];
	[killRadikoButton setEnabled:YES];
	[killRadikoButton setTarget:self];
	[killRadikoButton setAction:@selector(killRadiko)];
	
	//Data&ClkFieldのセットアップ
	[dateField setFont:[NSFont fontWithName:@"Arial" size:20]];
	[clkField setFont:[NSFont fontWithName:@"Arial" size:50]];
	timer = [NSTimer scheduledTimerWithTimeInterval:1.0
																					 target:self
																				 selector:@selector(refleshClock)
																				 userInfo:nil
																					repeats:YES];
	[self refleshClock];
	

	//アラームのNSDataPickerのセットアップ
	[startTime setDelegate:self];
	[endTime setDelegate:self];
}


/* radiko起動 */
-(void)bootRadiko{
	NSLog(@"Launching radiko.");

	NSTask *task = [[NSTask alloc] init];
	[task setLaunchPath:@"/Volumes/Macintosh HD/Applications/radiko_player_air.app/Contents/MacOS/radiko_player_air"];
//	[task setArguments:[NSArray arrayWithObject:@"radiko_player_air"]];
	//	[task launch];
    AudioController *avplayer = [[AudioController alloc] init];
    [avplayer play];

}

/* radiko終了 */
-(void)killRadiko{
	NSLog(@"Killing radiko.");
	NSTask *task = [[NSTask alloc] init];
	[task setLaunchPath:@"/usr/bin/killall"];
	[task setArguments:[NSArray arrayWithObject:@"radiko_player_air"]];

	[task launch];

}

/*radikoが起動しているか*/
-(BOOL)radikoIsRunning{
	 NSWorkspace* ws = [NSWorkspace sharedWorkspace];
	NSArray *runningApps = [ws runningApplications];
	for(int i = 0; i < runningApps.count;i++){
		if([[[runningApps objectAtIndex:i] localizedName] isEqualToString:@"radiko_player_air"]) return YES;
	}
	return NO;
}

/* 時刻フィールドの更新 */
-(void)refleshClock{
	NSDate *now = [NSDate date];
	NSCalendar *cal = [NSCalendar currentCalendar];
	NSDateComponents *dateCmpo;
	static NSInteger lastmin = 0;
	
	NSUInteger flags= NSYearCalendarUnit|NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit|NSSecondCalendarUnit;
	dateCmpo = [cal components:flags fromDate:now];
	NSInteger year = dateCmpo.year;
	NSInteger month = dateCmpo.month;
	NSInteger day = dateCmpo.day;
	NSInteger hour = dateCmpo.hour;
	NSInteger min  = dateCmpo.minute;
	NSInteger sec = dateCmpo.second;
	
	NSString *dateString  =[NSString stringWithFormat:@"%ld/%ld/%ld",year,month,day];
	NSString *clkString = [NSString stringWithFormat:@"%ld:%.2ld:%.2ld",(long)hour,(long)min,(long)sec];
	[clkField setStringValue:clkString];
	[dateField setStringValue:dateString];
	
	//毎分，アラーム鳴動確認
	if(lastmin != min){
		lastmin = min;
		[self ringAlarm];
	}
}

//アラーム鳴動
-(void)ringAlarm{
	if([self alarmShouldRing]){
        if(![self radikoIsRunning]){
         [self bootRadiko];
        }
	}else{
		if([self radikoIsRunning]) [self killRadiko];
	}
}

/*アラーム鳴動期間か？*/
-(BOOL)alarmShouldRing{
	NSDate *now = [NSDate date];
	NSCalendar *cal = [NSCalendar currentCalendar];
	NSDateComponents *dateCmpo;
	
	/*現在時刻の取得*/
	NSUInteger flags= NSHourCalendarUnit | NSMinuteCalendarUnit|NSWeekdayCalendarUnit;
	dateCmpo = [cal components:flags fromDate:now];
	
	NSInteger hour = dateCmpo.hour;
	NSInteger min  = dateCmpo.minute;
	NSInteger weekday = dateCmpo.weekday;
	
	/*アラーム鳴動時間の取得*/
	NSDateComponents *alarmStartDateCompo = [[NSCalendar currentCalendar] components:NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:[startTime dateValue]];
	NSDateComponents *alarmEndDateCompo =  [[NSCalendar currentCalendar] components:NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:[endTime dateValue]];
	NSInteger alarmStartHour = alarmStartDateCompo.hour;
	NSInteger alarmStartMinute = alarmStartDateCompo.minute;
	NSInteger alarmEndHour = alarmEndDateCompo.hour;
	NSInteger alarmEndMinute = alarmEndDateCompo.minute;
	
	/*鳴動時間内か判定*/
	if (alarmStartHour <= hour && hour <= alarmEndHour) {
		if(alarmStartHour == hour){
			if(min < alarmStartMinute)return NO;
		}
		if(alarmEndHour == hour){
			if(alarmEndMinute < min)return NO;
		}
		
		switch (weekday) {
			case 1:
				if([sun state]==NSOnState) return YES;
				break;
			case 2:
				if([mon state]==NSOnState) return YES;
				break;
			case 3:
				if([tue state]==NSOnState) return YES;
				break;
			case 4:
				if([wed state]==NSOnState) return YES;
				break;
			case 5:
				if([thr state]==NSOnState) return YES;
				break;
			case 6:
				if([fri state]==NSOnState) return YES;
				break;
			case 7:
				if([sat state]==NSOnState) return YES;
				break;
			default:
				break;
		}
	}
	
	return NO;
}

@synthesize window,bootRadikoButton,killRadikoButton;
@end
