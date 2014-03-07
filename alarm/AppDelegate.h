//
//  AppDelegate.h
//  alarm
//
//  Created by mindworm on 10/01/14.
//  Copyright (c) 2014 mindworm. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CoreAudio/CoreAudio.h>
#import <EventKit/EventKit.h>

#import "iTunes.h"
#import "SetAlarmController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    iTunesApplication* iTunes;
    NSStatusItem *statusItem;
    SetAlarmController *setAlarmWindow;
    NSTimer *curTimer;
}
@property (weak) IBOutlet NSMenuItem *setItem;
@property (weak) IBOutlet NSMenuItem *resetItem;

- (IBAction)setAlarm:(id)sender;

@property (weak) IBOutlet NSMenu *tray;
@end


