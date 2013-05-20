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
    self.cityTextField.delegate = self;
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendRequest:(id)sender {
    NSString *bizName = @"";
    [api searchBizWithCity:self.cityTextField.text
                     Query:bizName
                   Address:@""
                  Category:@""
                       Lng:[NSString stringWithFormat:@"%f",self.location.coordinate.longitude]
                       Lat:[NSString stringWithFormat:@"%f",self.location.coordinate.latitude]
                    Radius:@"5000"
                  Rankcode:@"0"
                      From:@"1"
                        To:@"10"];
}

-(void) requestDidFinishWithData:(NSData*)data aibangApi:(id)aibangApi{
    NSError *error;
    NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    //NSLog(@"%@",result);
    NSLog(@"%@",resultDictionary);
}

-(void) requestDidFailedWithError:(NSError*)error aibangApi:(id)aibangApi{
    NSLog(@"%@",error);//    textView.text = error.code;
}
- (void)viewDidUnload {
    [self setCityTextField:nil];
    [super viewDidUnload];
}
@end
