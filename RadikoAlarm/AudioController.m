//
//  Players.m
//  RadikoAlarm
//
//  Created by tetsurou on 5/4/16.
//  Copyright © 2016 Teturou Nishioka. All rights reserved.
//

#import "AudioController.h"

@import AVFoundation;

@implementation AudioController


-(void)play:(NSString *)path{
    NSLog(@"Start playing");
    
    NSURL *podcastUrl = [[NSURL alloc] initFileURLWithPath:path];
    NSError *err;
    if([podcastUrl checkResourceIsReachableAndReturnError:&err]==NO){
        NSLog(@"URL is incorrect");
        [[NSAlert alertWithError:err] runModal];
        return;
    }
    
    player = [[AVPlayer alloc] initWithURL:podcastUrl];
    
    [player play];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if([keyPath isEqual:@"PlayStatus"]){
        NSLog(@"Something went wrong with players");
    }
}

@end
