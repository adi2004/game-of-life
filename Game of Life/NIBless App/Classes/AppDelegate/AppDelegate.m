//
//  AppDelegate.m
//  Game of Life
//
//  Created by Adrian Florescu on 27.04.16.
//  Copyright (c) 2016 infloresc.ro. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

// Constants
// static NSString * const kSomeLocalConstant = @"SomeValue";

@implementation AppDelegate

@synthesize window = _window;

#pragma mark -
#pragma mark Static methods

#pragma mark -
#pragma mark Init and dealloc

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Public methods

#pragma mark - 
#pragma mark Private methods

#pragma mark - 
#pragma mark Delegate methods

#pragma mark UIApplicationDelegate

- (BOOL)application:(__unused UIApplication *)application didFinishLaunchingWithOptions:(__unused NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = nil;
    
    [self.window makeKeyAndVisible];
	return YES;
}

#pragma mark -
#pragma mark Handlers

@end
