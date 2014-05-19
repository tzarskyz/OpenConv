//
//  OpenConvAppDelegate.h
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

#import <Cocoa/Cocoa.h>
#import "GlassWindow.h"

#define CONST_DEVELOPER_URL       @"http://reversi.ng"
#define CONST_RELEASE_NOTE_URL    @"https://github.com/x43x61x69/OpenConv#changelog"
#define CONST_SUPPORT_URL         @"https://github.com/x43x61x69/OpenConv/issues"
#define CONST_UPDATE_CHECK_URL    @"https://raw.githubusercontent.com/x43x61x69/OpenConv/master/Source/OpenConv/OpenConv-Info.plist"
#define CONST_UPDATE_DOWNLOAD_URL @"https://github.com/x43x61x69/OpenConv/raw/master/Release/OpenConv.zip"
#define define_UserDefaultsVersion         @"1.0"
#define define_UserDefaultsResetIsNeeded   NO

@interface OpenConvAppDelegate : NSObject <NSApplicationDelegate, NSUserNotificationCenterDelegate> {
    
    NSUserDefaults          *defaults_UserDefaults;
    GlassWindow             *win_mainWindow;
    
}

// UI related.
@property (strong) IBOutlet GlassWindow     *win_mainWindow;

// IB actions.
- (IBAction)update:(id)sender;
- (IBAction)getSupport:(id)sender;
- (IBAction)developerWebsite:(id)sender;

@end
