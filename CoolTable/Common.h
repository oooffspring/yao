//
//  Common.h
//  CoolTable
//
//  Created by offspring on 13-1-12.
//  Copyright (c) 2013年 offspring. All rights reserved.
//

#import <Foundation/Foundation.h>

void drawLinearGradient(CGContextRef context,CGRect rect,UIColor *startColor,UIColor *endColor);
CGRect rectFor1PxStroke(CGRect rect);
void draw1PxStroke(CGContextRef context,CGPoint startPoint,CGPoint endPoint,CGColorRef color);
void drawGlossAndGradient(CGContextRef context,CGRect rect,UIColor *startColor,UIColor *endColor);