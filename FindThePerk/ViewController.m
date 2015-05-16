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
#import "BeaconManager.h"
#import "PlaceOrderViewController.h"
#import "QuestionManager.h"

@interface ViewController (){
    BeaconManager *beaconManager;
}

@property (strong, nonatomic) UITextField *enterName;

@end

@implementation ViewController
@synthesize enterName;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    ((AppsaholicSDK*)[AppsaholicSDK sharedManager]).rootViewController = self;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgImg.jpg"]];
    
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(123, 361, 73, 39)];
    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    nextButton.backgroundColor = [UIColor blackColor];
    nextButton.titleLabel.textColor = [UIColor whiteColor];
    nextButton.layer.masksToBounds = YES;
    nextButton.layer.cornerRadius = 5.0f;
    [nextButton addTarget:self action:@selector(goAhead:) forControlEvents:UIControlEventTouchUpInside];
    
    enterName = [[UITextField alloc]initWithFrame:CGRectMake(64, 249, 192, 30)];
    enterName.delegate = self;
    enterName.backgroundColor = [UIColor colorWithRed:159/255.0 green:138/255.0 blue:252/255.0 alpha:1.0];
    enterName.textColor = [UIColor whiteColor];
    enterName.textAlignment = NSTextAlignmentCenter;
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(36, 154, 248, 41)];
    label1.backgroundColor = [UIColor colorWithRed:159/255.0 green:138/255.0 blue:252/255.0 alpha:1.0];
    label1.text = @"Enter Your Name To Go Ahead";
    label1.textColor = [UIColor whiteColor];
    label1.textAlignment = NSTextAlignmentCenter;
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(102, 54, 117, 34)];
    label2.backgroundColor = [UIColor colorWithRed:159/255.0 green:138/255.0 blue:252/255.0 alpha:1.0];
    label2.text = @"Find The Perk";
    label2.textColor = [UIColor whiteColor];
    label2.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:label1];
    [self.view addSubview:label2];
    [self.view addSubview:nextButton];
    [self.view addSubview:enterName];
    

    // Do any additional setup after loading the view, typically from a nib.
}

-(void)goAhead:(id)sender
{
    /* if ([enterName.text isEqualToString:@""])
     {
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Your Name" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
     [alert show];
     }
     else
     {
     PlaceOrderViewController * moving = [[ PlaceOrderViewController alloc]initWithNibName:@"PlaceOrderViewController" bundle:nil];
     [self.navigationController pushViewController:moving animated:YES];
     }*/
    
    [[BeaconManager createSingleTon] startRanging];
    
    
    
    
}
-(void)loadQuestion
{
    if([[QuestionManager createSingleTon] didFoundCurrectBeaconForQuestion:QUESNUM_1])
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
      //  [[QuestionManager createSingleTon] setState:[NSNumber numberWithInt:1]];
        PlaceOrderViewController * moving = [[ PlaceOrderViewController alloc]initWithNibName:@"PlaceOrderViewController" bundle:nil];
        [self.navigationController pushViewController:moving animated:YES];
        
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadQuestion) name:BEACON_NOTIFICATION object:nil];

}


/*- (IBAction)goClicked:(id)sender {
    
    [[AppsaholicSDK sharedManager] trackEvent:EVENT2 notificationType:NO withController:self withSuccess:^(BOOL success, NSString *notificationtext, NSNumber *pointEarned) {
    
    }];

}*/


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
