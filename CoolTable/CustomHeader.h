//
//  CustomHeader.h
//  CoolTable
//
//  Created by offspring on 13-1-12.
//  Copyright (c) 2013年 offspring. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomHeader : UIView{
    CGRect _coloredBoxRect;
    CGRect _paperRect;
}

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIColor *lightColor;
@property (nonatomic,strong)UIColor *darkColor;

@end