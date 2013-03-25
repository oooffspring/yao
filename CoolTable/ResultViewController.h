//
//  RusultViewController.h
//  摇饭
//
//  Created by offspring on 13-3-22.
//  Copyright (c) 2013年 offspring. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController

@property (nonatomic, copy) void(^comeBack)(void);
@property (strong, nonatomic) IBOutlet UILabel *diskName;
@property (nonatomic, copy) NSString *diskNameString;

@end
