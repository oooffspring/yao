//
//  LocationViewController.h
//  yaofan
//
//  Created by offspring on 13-4-16.
//  Copyright (c) 2013年 offspring. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DPAPI.h"

@interface LocationViewController : UIViewController<CLLocationManagerDelegate,DPRequestDelegate>

- (IBAction)sendRequest:(id)sender;

@end
