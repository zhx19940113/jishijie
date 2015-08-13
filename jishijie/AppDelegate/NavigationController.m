//
//  NavigationController.m
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 9/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "NavigationController.h"
#import "UIImage+Addition.h"

@interface NavigationController ()

@end

@implementation NavigationController
+ (void)initialize
{
    
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageWithColor:COLOR_BLUE] forBarMetrics:UIBarMetricsDefault];
}

@end
