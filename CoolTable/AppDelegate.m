//
//  AppDelegate.m
//  CoolTable
//
//  Created by offspring on 13-1-11.
//  Copyright (c) 2013年 offspring. All rights reserved.
//

#import "AppDelegate.h"
#import <NewRelicAgent/NewRelicAgent.h>
#import "AibangApi.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [AibangApi setAppkey:@"f41c8afccc586de03a99c86097e98ccb"];
    [NewRelicAgent startWithApplicationToken:@"AA826142fe59addd2824ceb51e6d6df37ac09a96aa"];
    return YES;
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
