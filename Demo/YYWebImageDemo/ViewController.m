//
//  ViewController.m
//  YYWebImageDemo
//
//  Created by ibireme on 15/10/30.
//  Copyright © 2015 ibireme. All rights reserved.
//

#import "ViewController.h"
#import "YYImageExample.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YYImageExample *vc = [YYImageExample new];
    [self pushViewController:vc animated:NO];
}

@end
