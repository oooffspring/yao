//
//  AddViewController.h
//  CoolTable
//
//  Created by offspring on 13-3-9.
//  Copyright (c) 2013年 offspring. All rights reserved.
//
@protocol addDelegate <NSObject>

@required -(void)addNewDisk:(NSString *)diskName forMeal:(NSInteger)meal;

@end

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"
#import "QBFlatButton.h"

@interface AddViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) HMSegmentedControl *mySegmentedControl;
@property (strong, nonatomic) QBFlatButton *btn;
@property (strong, nonatomic) IBOutlet UITextField *mealName;
@property (weak, nonatomic) id <addDelegate> delegate;
- (IBAction)doneAdding:(UIButton *)sender;

@end
