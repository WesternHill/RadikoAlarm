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


-(void)play{
    NSLog(@"Start playing");
    
    NSURL *podcastUrl = [[NSURL alloc] initFileURLWithPath:@"/Users/tetsurou/Music/iTunes/iTunes Media/Podcasts/English News - NHK WORLD RADIO JAPAN/NHK WORLD RADIO JAPAN - English News at 14_01 (JST), August 28.mp3"];
    NSError *err;
    if([podcastUrl checkResourceIsReachableAndReturnError:&err]==NO){
        NSLog(@"URL is incorrect");
        [[NSAlert alertWithError:err] runModal];
        return;
    }
    
    AVPlayerItem *playItem = [AVPlayerItem playerItemWithURL:podcastUrl];
    [playItem addObserver:self forKeyPath:@"PlayStatus" options:0 context:NULL];
    
    player = [AVPlayer playerWithPlayerItem:playItem];
    
    [player play];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if([keyPath isEqual:@"PlayStatus"]){
        NSLog(@"Something went wrong with players");
    }
}

@end
