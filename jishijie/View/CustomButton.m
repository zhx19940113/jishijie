//
//  CustomButton.m
//  jishijie
//
//  Created by zhx on 15/3/12.
//  Copyright (c) 2015年 zhx. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tField = [[UITextField alloc] initWithFrame:frame];
        _tField.backgroundColor = [UIColor clearColor];
  
        _imgView = [[UIImageView alloc] initWithFrame:frame];

        [self addSubview:_tField];
        [self addSubview:_imgView];
        
    }
    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    //    TabBar
    //    CGFloat imageW = contentRect.size.width*0.3;
    //    CGFloat imageH = contentRect.size.height*0.3;
    
    //    Tabar
    CGFloat imageW = contentRect.size.width*0.3;
    CGFloat imageH = contentRect.size.height*0.5;
    
    return CGRectMake(5, 3, imageW, imageH);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height *0.3;
    CGFloat titleW = contentRect.size.width*0.6;
    CGFloat titleH = contentRect.size.height*0.8 - titleY;
    
    return CGRectMake(28+2, 3, titleW, titleH);
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
