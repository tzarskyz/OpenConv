//
//  OpenConvAppDelegate.m
//  OpenConv
//
//  Copyright (c) 2013 Cai, Zhi-Wei. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

#import "OpenConvAppDelegate.h"

@implementation OpenConvAppDelegate

@synthesize win_mainWindow=_win_mainWindow;

#pragma mark - Basic

+ (void) initialize
{
    // Hello world! :D
}

- (void)applicationWillFinishLaunching:(NSNotification *)aNotification
{
    // Debug Output.
    [self openConvErrorLog:@"DEBUG MODE."];
    
    // Push things via Notification Center.
    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
    
    [self performSelectorInBackground:@selector(checkUpdateWithFeedback:) withObject:[NSNumber numberWithBool:NO]];
    
    // Define objects.
    BOOL            bool_olderUserDefaultsVersionExisted;
    NSDecimalNumber *string_UserDefaultsVersionCurrent, *string_UserDefaultsVersionExisted;
    
    // Gathering information.
    defaults_UserDefaults = [NSUserDefaults standardUserDefaults];
    string_UserDefaultsVersionCurrent = [NSDecimalNumber decimalNumberWithString:define_UserDefaultsVersion];
    string_UserDefaultsVersionExisted = [NSDecimalNumber decimalNumberWithString:
                                         [defaults_UserDefaults objectForKey:@"UserDefaultsVersion"]];
    bool_olderUserDefaultsVersionExisted = [[string_UserDefaultsVersionCurrent decimalNumberBySubtracting:string_UserDefaultsVersionExisted] boolValue];
    
    // Reset UserDefaults for older versions if needed.
    if ( define_UserDefaultsResetIsNeeded && bool_olderUserDefaultsVersionExisted ) {
        [defaults_UserDefaults removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
        defaults_UserDefaults = [NSUserDefaults standardUserDefaults];
        // Debug Output.
        [self openConvErrorLog:@"UserDefaults Reset"];
    }
    
    // Create default UserDefaults values
    NSDictionary *dict_userDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [NSNumber numberWithBool:NO],    @"DisableNotificationCenter",
                                       [NSNumber numberWithBool:NO],    @"DisableUTF8Output",
                                       [NSNumber numberWithBool:NO],    @"ForceChineseSimplifiedOutput",
                                       [NSNumber numberWithBool:NO],    @"ForceChineseTraditionalInput",
                                       [NSNumber numberWithBool:NO],    @"NameMode",
                                       [NSNumber numberWithBool:YES],   @"PasteboardConversionEnabled",
                                       [NSNumber numberWithBool:NO],    @"RightClickPasteboardChineseTraditional",
                                       define_UserDefaultsVersion,      @"UserDefaultsVersion",
                                       nil];
    // Debug Output.
    [self openConvErrorLog:[NSString stringWithFormat:@"UserDefaults Dictionary: %@", dict_userDefaults]];
    
    // Updating the UserDefaults for newly add keys.
    id id_key;
    NSEnumerator *enum_keys = [dict_userDefaults keyEnumerator];
    
    while ( (id_key = [enum_keys nextObject]) ) {
        if ( ![defaults_UserDefaults objectForKey:id_key] ) {
            // Debug Output.
            [self openConvErrorLog:[NSString stringWithFormat:@"Adding UserDefaults: %@",
                                    [dict_userDefaults objectForKey:id_key]]];
            [defaults_UserDefaults setObject:[dict_userDefaults objectForKey:id_key]
                                      forKey:id_key];
        }
    }
    
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // TBA.
}

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification
{
    // Push things via Notification Center.
    return YES;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
    // Shut down the application when the main window closed.
	return YES;
}

- (void)awakeFromNib
{
    // Store current window position.
    [_win_mainWindow setFrameUsingName: @"WindowFrame"];
    [_win_mainWindow setFrameAutosaveName: @"WindowFrame"];
    [_win_mainWindow setLevel:NSFloatingWindowLevel];
    
    // Define objects.
    BOOL            bool_olderUserDefaultsVersionExisted;
    NSDecimalNumber *string_UserDefaultsVersionCurrent, *string_UserDefaultsVersionExisted;
    
    // Gathering information.
    defaults_UserDefaults = [NSUserDefaults standardUserDefaults];
    string_UserDefaultsVersionCurrent = [NSDecimalNumber decimalNumberWithString:define_UserDefaultsVersion];
    string_UserDefaultsVersionExisted = [NSDecimalNumber decimalNumberWithString:
                                         [defaults_UserDefaults objectForKey:@"UserDefaultsVersion"]];
    bool_olderUserDefaultsVersionExisted = [string_UserDefaultsVersionCurrent intValue] - [string_UserDefaultsVersionExisted intValue];
    
    // Reset UserDefaults for older versions if needed.
    if ( define_UserDefaultsResetIsNeeded && bool_olderUserDefaultsVersionExisted ) {
        [defaults_UserDefaults removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
        defaults_UserDefaults = [NSUserDefaults standardUserDefaults];
        // Debug Output.
        [self openConvErrorLog:@"UserDefaults Reset"];
    }
    
    // Create default UserDefaults values
    NSDictionary *dict_userDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [NSNumber numberWithBool:NO],    @"DisableNotificationCenter",
                                       [NSNumber numberWithBool:NO],    @"DisableUTF8Output",
                                       [NSNumber numberWithBool:NO],    @"ForceChineseSimplifiedOutput",
                                       [NSNumber numberWithBool:NO],    @"ForceChineseTraditionalInput",
                                       [NSNumber numberWithBool:YES],   @"PasteboardConversionEnabled",
                                       [NSNumber numberWithBool:NO],    @"RightClickPasteboardChineseTraditional",
                                       define_UserDefaultsVersion,      @"UserDefaultsVersion",
                                       nil];
    // Debug Output.
    [self openConvErrorLog:[NSString stringWithFormat:@"UserDefaults Dictionary: %@", dict_userDefaults]];
    
    // Updating the UserDefaults for newly add keys.
    id id_key;
    NSEnumerator *enum_keys = [dict_userDefaults keyEnumerator];
    
    while ( (id_key = [enum_keys nextObject]) ) {
        if ( ![defaults_UserDefaults objectForKey:id_key] ) {
            // Debug Output.
            [self openConvErrorLog:[NSString stringWithFormat:@"Adding UserDefaults: %@",
                                    [dict_userDefaults objectForKey:id_key]]];
            [defaults_UserDefaults setObject:[dict_userDefaults objectForKey:id_key]
                                      forKey:id_key];
        }
    }
}

- (void)alertNoUpdateOnMainThread:(NSAlert *)theAlert
{
    [theAlert runModal];
}

- (void)alertUpdateOnMainThread:(NSAlert *)theAlert
{
    NSInteger returnCode = [theAlert runModal];
    if (returnCode == 1) {
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:CONST_UPDATE_DOWNLOAD_URL]];
    } else if (returnCode != 0) {
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:CONST_RELEASE_NOTE_URL]];
    } else {
        // Do nothing.
    }
}

- (void)checkUpdateWithFeedback:(BOOL)feedback
{
    NSURL *requestResult = [NSURL URLWithString:CONST_UPDATE_CHECK_URL];
    NSString *remoteCFBundleShortVersionString = [[NSDictionary dictionaryWithContentsOfURL:requestResult] objectForKey:@"CFBundleShortVersionString"];
    NSString *localCFBundleShortVersionString  = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if(remoteCFBundleShortVersionString) {
        if ([localCFBundleShortVersionString isEqualToString:remoteCFBundleShortVersionString]) {
            if (feedback) {
                NSAlert *alert = [NSAlert alertWithMessageText:@"We are up-to-date!"
                                                 defaultButton:@"Nice"
                                               alternateButton:nil
                                                   otherButton:nil
                                     informativeTextWithFormat:@"You are using the latest version of %@.\n", [[NSRunningApplication currentApplication] localizedName]];
                [alert setAlertStyle:NSWarningAlertStyle];
                [self performSelectorOnMainThread:@selector(alertNoUpdateOnMainThread:) withObject:alert waitUntilDone:NO];
            }
        } else {
            NSAlert *alert = [NSAlert alertWithMessageText:@"New Version Available!"
                                             defaultButton:@"Sure"
                                           alternateButton:@"Maybe Next Time"
                                               otherButton:@"Release Note"
                                 informativeTextWithFormat:@"There's a new version available for download:\n\nVersion %@ (You have %@)\n\nWould you like to download it now?\n",
                              remoteCFBundleShortVersionString,
                              localCFBundleShortVersionString];
            [alert setAlertStyle:NSWarningAlertStyle];
            [self performSelectorOnMainThread:@selector(alertUpdateOnMainThread:) withObject:alert waitUntilDone:NO];
        }
    }
}


#pragma mark - Misc

- (IBAction)update:(id)sender
{
    [self performSelectorInBackground:@selector(checkUpdateWithFeedback:) withObject:[NSNumber numberWithBool:YES]];
}

- (IBAction)getSupport:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:CONST_SUPPORT_URL]];
}

- (IBAction)developerWebsite:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:CONST_DEVELOPER_URL]];
}

- (void)openConvErrorLog:(NSString *)anError
{
    // Display debug information if in debug mode.
#ifdef DEBUG
    NSLog(@"[OpenConv Debug] %@", anError);
#endif
}

@end
