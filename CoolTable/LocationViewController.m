//
//  LocationViewController.m
//  yaofan
//
//  Created by offspring on 13-4-16.
//  Copyright (c) 2013年 offspring. All rights reserved.
//

#import "LocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "DPAPI.h"
#import "AppDelegate.h"

@interface LocationViewController ()

@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation LocationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.title = @"摇周边";
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [self startStandardUpdates];
    [super viewDidAppear:animated];
}

- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // Set a movement threshold for new events.
    self.locationManager.distanceFilter = 500;
    
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    self.location = [locations lastObject];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)sendRequest:(id)sender {
//    NSString *url = @"v1/business/find_businesses";
//    //NSString *params = [NSString stringWithFormat:@"city=北京&region=海淀区&category=火锅&has_coupon=1&sort=2&limit=20"];
//    NSString *params = [NSString stringWithFormat:@"latitude=%f&longitude=%f&category=火锅&sort=2&limit=20",self.location.coordinate.latitude,self.location.coordinate.longitude];
//    [[[AppDelegate instance] dpapi] requestWithURL:url paramsString:params delegate:self];
//}

- (IBAction)sendRequest:(id)sender {
    NSString *url = @"v1/metadata/get_categories_with_businesses";
    //NSString *params = [NSString stringWithFormat:@"city=北京&region=海淀区&category=火锅&has_coupon=1&sort=2&limit=20"];
    //NSString *params = [NSString stringWithFormat:@"latitude=%f&longitude=%f&category=火锅&sort=2&limit=20",self.location.coordinate.latitude,self.location.coordinate.longitude];
    [[[AppDelegate instance] dpapi] requestWithURL:url paramsString:nil delegate:self];
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"%@",error);
}

//- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result {
//    NSArray *array = [(NSDictionary*)result objectForKey:@"businesses"];
//    NSDictionary *oneBusiness = array[1];
//    NSString *businessName = [oneBusiness objectForKey:@"name"];
//    NSLog(@"%@",businessName);
//}
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result {
    NSLog(@"%@",result);
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
