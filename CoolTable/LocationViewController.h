//
//  LocationViewController.h
//  yaofan
//
//  Created by offspring on 13-4-16.
//  Copyright (c) 2013年 offspring. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AibangApi.h"

@interface LocationViewController : UIViewController<CLLocationManagerDelegate>{
    AibangApi *api;
}

- (IBAction)sendRequest:(id)sender;

@end
