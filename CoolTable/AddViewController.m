//
//  AddViewController.m
//  CoolTable
//
//  Created by offspring on 13-3-9.
//  Copyright (c) 2013年 offspring. All rights reserved.
//

#import "AddViewController.h"
#import "QBFlatButton.h"
#import "HMSegmentedControl.h"
#import <QuartzCore/QuartzCore.h>

@interface AddViewController ()

@end

@implementation AddViewController

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
    self.title = @"添加新饭";
    [super viewDidLoad];
    self.mealName.delegate = self;
    
    //自定义按钮
    self.btn = [QBFlatButton buttonWithType:UIButtonTypeCustom];
    self.btn.frame = CGRectMake(60, 290, 200, 60);
    self.btn.faceColor = [UIColor lightGrayColor];
    self.btn.sideColor = [UIColor darkGrayColor];
    self.btn.radius = 6.0;
    self.btn.margin = 4.0;
    self.btn.depth = 6.0;
    [self.btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.btn setTitle:@"请先输入饭名" forState:UIControlStateNormal];
    [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(doneAdding:) forControlEvents:UIControlEventTouchUpInside];
    self.btn.enabled = NO;
    
    //自定义segment
    self.mySegmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"早餐", @"午餐", @"晚餐"]];
    [self.mySegmentedControl setFrame:CGRectMake(20, 175, 280, 60)];
    self.mySegmentedControl.backgroundColor = [UIColor colorWithRed:86.0/255.0 green:161.0/255.0 blue:217.0/255.0 alpha:1.0];
    [self.mySegmentedControl setTextColor:[UIColor whiteColor]];
    self.mySegmentedControl.layer.cornerRadius = 10;
    self.mySegmentedControl.layer.masksToBounds = YES;
    
    [self.mySegmentedControl setSelectionIndicatorColor:[UIColor whiteColor]];
    [self.mySegmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.mySegmentedControl];
    [self.view addSubview:self.btn];

	// Do any additional setup after loading the view.
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    [self changeColorSelected:segmentedControl.selectedIndex];
}

- (void)changeColorSelected:(NSInteger)selectedIndex{
    switch (selectedIndex) {
        case 0:
            self.mySegmentedControl.backgroundColor = [UIColor colorWithRed:86.0/255.0 green:161.0/255.0 blue:217.0/255.0 alpha:1.0];
            if (self.btn.enabled == YES) {
                self.btn.faceColor = [UIColor colorWithRed:86.0/255.0 green:161.0/255.0 blue:217.0/255.0 alpha:1.0];
                self.btn.sideColor = [UIColor colorWithRed:79.0/255.0 green:127.0/255.0 blue:179.0/255.0 alpha:1.0];
            }
            [self.mySegmentedControl setNeedsDisplay];
            [self.btn setNeedsDisplay];
            break;
        case 1:
            self.mySegmentedControl.backgroundColor = [UIColor colorWithRed:147.0/255.0 green:105.0/255.0 blue:216.0/255.0 alpha:1.0];
            if (self.btn.enabled == YES) {
                self.btn.faceColor = [UIColor colorWithRed:147.0/255.0 green:105.0/255.0 blue:216.0/255.0 alpha:1.0];
                self.btn.sideColor = [UIColor colorWithRed:72.0/255.0 green:22.0/255.0 blue:137.0/255.0 alpha:1.0];
            }
            [self.mySegmentedControl setNeedsDisplay];
            [self.btn setNeedsDisplay];
            break;
        case 2:
            self.mySegmentedControl.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:0.0/0.0 blue:0.0/0.0 alpha:1.0];
            if (self.btn.enabled == YES) {
                self.btn.faceColor = [UIColor colorWithRed:200.0/255.0 green:0.0/0.0 blue:0.0/0.0 alpha:1.0];
                self.btn.sideColor = [UIColor colorWithRed:150.0/255.0 green:0.0/0.0 blue:0.0/0.0 alpha:1.0];
            }
            [self.mySegmentedControl setNeedsDisplay];
            [self.btn setNeedsDisplay];
            break;
            
        default:
            break;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMySegmentedControl:nil];
    [self setMealName:nil];
    [super viewDidUnload];
}
- (void)doneAdding:(id)sender {
    [self.delegate addNewDisk:self.mealName.text forMeal:self.mySegmentedControl.selectedIndex];
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (![textField.text isEqualToString:@""]) {
        self.btn.margin = 7;
        self.btn.enabled = YES;
        [self changeColorSelected:self.mySegmentedControl.selectedIndex];
        self.btn.titleLabel.text = @"确认添加";
    }
    [textField resignFirstResponder];
    return YES;
}
@end
