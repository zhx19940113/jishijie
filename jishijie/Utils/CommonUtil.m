//
//  CommonUtil.m
//  jishijie
//
//  Created by zhx on 15/8/8.
//  Copyright (c) 2015年 zhx. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil

//根据指定的颜色画直线
+(void)addLine:(int)x tox:(int)toX y:(int)y toY:(int)toY lineColor:(UIColor*)color mview:(UIView *)mview
{
    CAShapeLayer *lineShape = nil;
    CGMutablePathRef linePath = nil;
    linePath = CGPathCreateMutable();
    lineShape = [CAShapeLayer layer];
    lineShape.lineWidth = 0.2f;
    lineShape.lineCap = kCALineCapRound;
    if(color==nil)
        lineShape.strokeColor = [UIColor whiteColor].CGColor;
    else lineShape.strokeColor = color.CGColor;
    CGPathMoveToPoint(linePath, NULL, x, y);
    CGPathAddLineToPoint(linePath, NULL, toX, toY);
    lineShape.path = linePath;
    CGPathRelease(linePath);
    [mview.layer addSublayer:lineShape];
}

@end
