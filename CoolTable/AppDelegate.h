//
//  AppDelegate.h
//  CoolTable
//
//  Created by offspring on 13-1-11.
//  Copyright (c) 2013年 offspring. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPAPI.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, nonatomic) DPAPI *dpapi;
@property (strong, nonatomic) NSString *appKey;
@property (strong, nonatomic) NSString *appSecret;

+ (AppDelegate *)instance; 

@end

