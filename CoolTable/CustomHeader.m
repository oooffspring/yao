//
//  CustomHeader.m
//  CoolTable
//
//  Created by offspring on 13-1-12.
//  Copyright (c) 2013年 offspring. All rights reserved.
//

#import "CustomHeader.h"
#import "Common.h"

@interface CustomHeader()

@end

@implementation CustomHeader
@synthesize titleLabel = _titleLabel;
@synthesize lightColor = _lightColor;
@synthesize darkColor = _darkColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) layoutSubviews{
    CGFloat coloredBoxMargin = 6.0;
    CGFloat coloredBoxHeight = 40.0;
    _coloredBoxRect = CGRectMake(coloredBoxMargin, coloredBoxMargin, self.bounds.size.width - coloredBoxMargin*2, coloredBoxHeight);
    
    CGFloat paperMargin = 9.0;
    _paperRect = CGRectMake(paperMargin, CGRectGetMaxY(_coloredBoxRect), self.bounds.size.width - paperMargin*2, self.bounds.size.height - CGRectGetMaxY(_coloredBoxRect));
    
    _titleLabel.frame = _coloredBoxRect;
}

- (id)init{
    if ((self = [super init])) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.opaque = NO;
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [[self titleLabel] setFont:[UIFont boldSystemFontOfSize:20.0]];
        [[self titleLabel] setTextColor:[UIColor whiteColor]];
        [[self titleLabel] setShadowColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        [[self titleLabel] setShadowOffset:CGSizeMake(0, -1)];
        [self addSubview:[self titleLabel]];
        [self setLightColor:[UIColor colorWithRed:105.0f/255.0f green:179.0f/255.0f blue:216.0f/255.0f alpha:1.0]];
        [self setDarkColor:[UIColor colorWithRed:21.0/255.0 green:92.0/255.0 blue:136.0/255.0 alpha:1.0]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorRef whiteColor = [[UIColor whiteColor] CGColor];
    //CGColorRef shadowColor = [[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.5] CGColor];
    float components[4] = {0, 0, 0, 1.0/3.0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef shadowColor = CGColorCreate( colorSpace, components);
    
    CGContextSetFillColorWithColor(context, whiteColor);
    CGContextFillRect(context,_paperRect);
    
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, shadowColor);
    CGContextSetFillColorWithColor(context, [self.lightColor CGColor]);
    CGContextFillRect(context,_coloredBoxRect);
    CGContextRestoreGState(context);
    
    drawGlossAndGradient(context, _coloredBoxRect, self.lightColor, self.darkColor);
    
    CGContextSetStrokeColorWithColor(context, [self.darkColor CGColor]);
    CGContextSetLineWidth(context, 1.0);
    CGContextStrokeRect(context, rectFor1PxStroke(_coloredBoxRect));
}

@end
