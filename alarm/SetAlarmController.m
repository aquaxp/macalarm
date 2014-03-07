//
//  SetAlarmController.m
//  alarm
//
//  Created by mindworm on 11/01/14.
//  Copyright (c) 2014 mindworm. All rights reserved.
//

#import "SetAlarmController.h"
#import <CoreAudio/CoreAudio.h>
#import "iTunes.h"

@interface SetAlarmController ()

@end

@implementation SetAlarmController

- (id)init{
    return [super initWithWindowNibName:@"SetAlarmController"];
}

- (id)initWith:(NSStatusItem*)statusbar and:(NSMenuItem*)setItem and:(NSMenuItem*)resetItem{
    self.statusbar = statusbar;
    self.setItem = setItem;
    self.resetItem = resetItem;
    return [super initWithWindowNibName:@"SetAlarmController"];
}

-(void)showWindow:(id)sender{
    //[super showWindow:sender];
    [[super window] orderFrontRegardless];
    NSDate *current = [[NSDate alloc] init];
    [[self DatePicker] setDateValue:current];
}

- (IBAction)setAlarm:(id)sender {
    NSDate *fireDate;
    NSTimeInterval timeDifference = [[[self DatePicker] dateValue] timeIntervalSinceDate:[[NSDate alloc] init]];
    if (timeDifference <= 0){
        fireDate = [[NSDate alloc] initWithTimeInterval:(24*60*60) sinceDate:[[self DatePicker] dateValue]];
    }
    else{
        fireDate = [[self DatePicker] dateValue];
    }
    self.timer = [[NSTimer alloc] initWithFireDate:fireDate interval:(0.0) target:self selector:@selector(onTick:) userInfo:[NSArray arrayWithObjects:[self volumeSystem], [self volumeITunes], nil] repeats:NO];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    NSLog(@"Alarm sheduled to %@", [fireDate descriptionWithLocale:[NSLocale currentLocale]]);
    
    [self.statusbar setTitle:[[[self DatePicker] dateValue] descriptionWithCalendarFormat:@"%H:%M" timeZone:[NSTimeZone defaultTimeZone] locale:[NSLocale currentLocale]]];
    [self.setItem setHidden:YES];
    [self.resetItem setHidden:NO];
    [self.view.window close];
}

- (void)cancelAction:(id)sender{
    [self.view.window close];
}

- (IBAction)systemVolumeA:(id)sender {
    //stub
}

-(void)onTick:(NSTimer*)timer
{
    iTunesApplication* iTunes;
    iTunes = [SBApplication applicationWithBundleIdentifier:@"com.apple.iTunes"];
    [iTunes resume];
    
    NSLog(@"Tick...");
    
    setVolume([[timer userInfo][0] doubleValue]);
    
    if([iTunes isRunning]){
        switch ([iTunes playerState]) {
            case iTunesEPlSPaused:
                [iTunes playpause];
                [iTunes setSoundVolume:([[timer userInfo][1] doubleValue])*100];
                break;
            case iTunesEPlSPlaying:
                [iTunes setSoundVolume:([[timer userInfo][1] doubleValue])*100];
                break;
            default:
                break;
        }
    }else{
        [iTunes run];
        [iTunes playpause];
        [iTunes setSoundVolume:([[timer userInfo][1] doubleValue])*100];
    }
    
    [self.setItem setHidden:NO];
    [self.resetItem setHidden:YES];
    [self.statusbar setTitle:nil];
}

void setVolume(Float32 value){
    UInt32 size = sizeof(Float32);
    AudioDeviceID device = getDefaultOutputDevice();
    
    // left chanell
    AudioObjectPropertyAddress address0 = {
        kAudioDevicePropertyVolumeScalar,
        kAudioDevicePropertyScopeOutput,
        1};
    // right chanell
    AudioObjectPropertyAddress address1 = {
        kAudioDevicePropertyVolumeScalar,
        kAudioDevicePropertyScopeOutput,
        2};
    
    //    OSStatus error1 =
    AudioObjectSetPropertyData(device, &address0, 0, NULL, size, &value);
    //    OSStatus error2 =
    AudioObjectSetPropertyData(device, &address1, 0, NULL, size, &value);
    // TODO: handle errors
}

AudioDeviceID getDefaultOutputDevice(){
    AudioDeviceID device = 0;
    UInt32 theSize = sizeof(AudioDeviceID);
    AudioObjectPropertyAddress theAddress = { kAudioHardwarePropertyDefaultOutputDevice,
        kAudioObjectPropertyScopeGlobal,
        kAudioObjectPropertyElementMaster };
    
    //    OSStatus theError =
    AudioObjectGetPropertyData(kAudioObjectSystemObject,
                               &theAddress,
                               0,
                               NULL,
                               &theSize,
                               &device);
    // TODO: handle errors
    return device;
}

@end



