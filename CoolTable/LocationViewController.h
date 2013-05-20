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

@interface LocationViewController : UIViewController<CLLocationManagerDelegate,UITextFieldDelegate>{
    AibangApi *api;
}
@property (strong, nonatomic) IBOutlet UITextField *cityTextField;

- (IBAction)sendRequest:(id)sender;

@end
