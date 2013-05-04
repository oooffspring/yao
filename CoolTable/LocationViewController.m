//
//  LocationViewController.m
//  yaofan
//
//  Created by offspring on 13-4-16.
//  Copyright (c) 2013年 offspring. All rights reserved.
//

#import "LocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import "AFNetworking.h"

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
    api = [[AibangApi alloc] init];
    api.delegate = self;
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

- (IBAction)sendRequest:(id)sender {
    NSString *cityName = @"上海";
    NSString *bizName = @"";
    [api searchBizWithCity:cityName
                     Query:bizName
                   Address:@""
                  Category:@""
                       Lng:[NSString stringWithFormat:@"%f",self.location.coordinate.longitude]
                       Lat:[NSString stringWithFormat:@"%f",self.location.coordinate.latitude]
                    Radius:@"5000"
                  Rankcode:@"0"
                      From:@"1"
                        To:@"10"];
    
//    NSLog(@"%@",self.location);
//    NSString *urlString = @"http://openapi.aibang.com/search?app_key=9943467fcd43a74d39b28f2c76d6703e&lng=116.337&lat=39.993&q=%E9%A4%90%E9%A6%86&alt=json";
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
//        NSLog(@"%@",JSON);
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response,NSError *error, id JSON){
//        NSLog(@"%@",error);
//    }];
//    
//    [operation start];
    //NSString *url = @"v1/metadata/get_categories_with_businesses";
    //NSString *params = [NSString stringWithFormat:@"city=北京&region=海淀区&category=火锅&has_coupon=1&sort=2&limit=20"];
    //NSString *params = [NSString stringWithFormat:@"latitude=%f&longitude=%f&category=火锅&sort=2&limit=20",self.location.coordinate.latitude,self.location.coordinate.longitude];
    //[[[AppDelegate instance] dpapi] requestWithURL:url paramsString:nil delegate:self];
}

-(void) requestDidFinishWithData:(NSData*)data aibangApi:(id)aibangApi{
    NSString *result = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    NSLog(@"%@",result);
}

-(void) requestDidFailedWithError:(NSError*)error aibangApi:(id)aibangApi{
    NSLog(@"%@",error);//    textView.text = error.code;
}
- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
