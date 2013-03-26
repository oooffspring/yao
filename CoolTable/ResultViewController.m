//
//  RusultViewController.m
//  摇饭
//
//  Created by offspring on 13-3-22.
//  Copyright (c) 2013年 offspring. All rights reserved.
//

#import "ResultViewController.h"
#import "QBFlatButton.h"

@interface ResultViewController ()

@property (nonatomic ,strong) QBFlatButton *btn;

@end

@implementation ResultViewController

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
    [super viewDidLoad];
    self.title = @"摇饭结果";
    self.diskName.text = self.diskNameString;
    //自定义按钮
    self.btn = [QBFlatButton buttonWithType:UIButtonTypeCustom];
    self.btn.frame = CGRectMake(60, 290, 200, 60);
    self.btn.faceColor = [UIColor redColor];
    self.btn.sideColor = [UIColor colorWithRed:150.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
    self.btn.radius = 6.0;
    self.btn.margin = 7.0;
    self.btn.depth = 6.0;
    [self.btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.btn setTitle:@"返回首页继续摇" forState:UIControlStateNormal];
    [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(doneShaking:) forControlEvents:UIControlEventTouchUpInside];
    self.btn.enabled = NO;
    
    [self.view addSubview:self.btn];
	// Do any additional setup after loading the view.
}

-(void)doneShaking:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setDiskName:nil];
    [super viewDidUnload];
}
@end
