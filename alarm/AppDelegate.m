//
//  AppDelegate.m
//  alarm
//
//  Created by mindworm on 10/01/14.
//  Copyright (c) 2014 mindworm. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setImage:[NSImage imageNamed:@"Image"]];
    [statusItem setHighlightMode:YES];
    [statusItem setMenu:_tray];
}


- (IBAction)setAlarm:(id)sender {
    if(!setAlarmWindow){
        setAlarmWindow = [[SetAlarmController alloc] initWith:(statusItem) and:[self setItem] and:[self resetItem]];
    }
    [setAlarmWindow showWindow:self];
}

- (IBAction)unsetAlarm:(id)sender {
    NSLog(@"Alarm was reseted");
    [setAlarmWindow.timer invalidate];
    [[self resetItem] setHidden:YES];
    [[self setItem] setHidden:NO];
    [statusItem setTitle:nil];
}


@end
