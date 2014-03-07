//
//  SetAlarmController.h
//  alarm
//
//  Created by mindworm on 11/01/14.
//  Copyright (c) 2014 mindworm. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SetAlarmController : NSWindowController
//- (id)initWith:(NSStatusItem*)statusbar;

- (id)initWith:(NSStatusItem*)statusbar and:(NSMenuItem*)setItem and:(NSMenuItem*)resetItem;

@property (weak) IBOutlet NSSlider *volumeITunes;
@property (weak) IBOutlet NSSlider *volumeSystem;

@property IBOutlet NSView *view;
@property (weak) IBOutlet NSDatePicker *DatePicker;

- (IBAction)setAlarm:(id)sender;
- (IBAction)cancelAction:(id)sender;

@property NSStatusItem *statusbar;
@property NSMenuItem *setItem;
@property NSMenuItem *resetItem;
@property NSTimer *timer;
@end
