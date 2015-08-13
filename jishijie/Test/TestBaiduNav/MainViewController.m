//
//  MainViewController.m
//  NaviDemo
//
//  Created by Baidu on 15/1/14.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import "MainViewController.h"
#import "ExternalGPSViewController.h"
#import "PhoneGPSViewController.h"

@interface MainViewController ()

@property (strong, nonatomic) NSArray* menuData;

@end

@implementation MainViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:style])
    {
        self.menuData = [[NSArray alloc] initWithObjects:@"手机GPS导航",@"外部GPS导航", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"百度导航SDK Demo";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.textLabel.text = self.menuData[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        [self.navigationController pushViewController:[[PhoneGPSViewController alloc] initWithNibName:nil bundle:nil] animated:YES];
    }
    else if (indexPath.row == 1)
    {
        [self.navigationController pushViewController:[[ExternalGPSViewController alloc] initWithNibName:nil bundle:nil] animated:YES];
    }
}


@end
