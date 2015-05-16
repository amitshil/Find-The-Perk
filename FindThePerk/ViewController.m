//
//  ViewController.m
//  FindThePerk
//
//  Created by Amit Shil on 16/05/15.
//  Copyright (c) 2015 Amit Shil. All rights reserved.
//

#import "ViewController.h"
#import "AppsaholicSDK.h"
#import "Contants.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ((AppsaholicSDK*)[AppsaholicSDK sharedManager]).rootViewController = self;

    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)goClicked:(id)sender {
    
    [[AppsaholicSDK sharedManager] trackEvent:EVENT2 notificationType:NO withController:self withSuccess:^(BOOL success, NSString *notificationtext, NSNumber *pointEarned) {
    
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
