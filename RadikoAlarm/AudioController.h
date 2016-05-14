//
//  Players.h
//  RadikoAlarm
//
//  Created by tetsurou on 5/4/16.
//  Copyright © 2016 Teturou Nishioka. All rights reserved.
//

#import <Foundation/Foundation.h>

@import AVFoundation;

@interface AudioController: NSObject{
    AVPlayer *player;
}

-(void)play;

@end
