//
//  AppDelegate.m
//  NSTViewWarmuper
//
//  Created by Timur Bernikowich on 2/6/17.
//  Copyright © 2017 Timur Bernikovich. All rights reserved.
//

#import "AppDelegate.h"
#import "NSTViewWarmuper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[NSTWKWebViewWarmuper sharedViewWarmuper] prepare];
    [[NSTUIWebViewWarmuper sharedViewWarmuper] prepare];
    
    return YES;
}

@end
