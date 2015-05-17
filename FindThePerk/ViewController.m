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
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ((AppsaholicSDK*)[AppsaholicSDK sharedManager]).rootViewController = self;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgImg.jpg"]];
    
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 361, 120,50)];
    [nextButton setTitle:@"Let's Start" forState:UIControlStateNormal];
    nextButton.backgroundColor = [UIColor blackColor];
    nextButton.titleLabel.textColor = [UIColor whiteColor];
    nextButton.layer.masksToBounds = YES;
    nextButton.layer.cornerRadius = 5.0f;
    nextButton.layer.borderColor = [UIColor redColor].CGColor;
    nextButton.layer.borderWidth = 2.0f;
    [nextButton addTarget:self action:@selector(goAhead:) forControlEvents:UIControlEventTouchUpInside];
    
    // Custom Textfield to Enter User Name
    
    enterName = [[UITextField alloc]initWithFrame:CGRectMake(50, 249, 225, 30)];
    enterName.delegate = self;
    enterName.backgroundColor = [UIColor clearColor];
    enterName.placeholder = @"Enter Name";
    enterName.textColor = [UIColor colorWithRed:159/255.0 green:138/255.0 blue:252/255.0 alpha:1.0];
    enterName.textAlignment = NSTextAlignmentCenter;
    
    // Bottom border of Text Field ****
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0, 29, 225, 1);
    bottomBorder.backgroundColor = [UIColor colorWithRed:190/255.0f green:54/255.0f blue:178/255.0f alpha:1.0f].CGColor;
    [enterName.layer addSublayer:bottomBorder];
    
    // Custom Label for Showing A Message
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(30, 50, 250, 150)];
    label2.backgroundColor = [UIColor clearColor];
    label2.text = @"Welcome to the World of Inception, Enter Your Name , Go Ahead and Earn Points by Answering the Simple Questions. Each Question will Give You A Point.";
    [label2 setFont:[UIFont fontWithName:@"Heiti SC" size:20]];
    label2.numberOfLines = 10;
    label2.textColor = [UIColor colorWithRed:159/255.0 green:138/255.0 blue:252/255.0 alpha:1.0];
    label2.textAlignment = NSTextAlignmentCenter;
    
    // Add All Custom Views to Our View
    
    [self.view addSubview:label2];
    [self.view addSubview:nextButton];
    [self.view addSubview:enterName];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadQuestion) name:BEACON_NOTIFICATION object:nil];
    
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
    [self loadQuestion];
    
}
-(void)loadQuestion
{
    //if([[QuestionManager createSingleTon] didFoundCurrectBeaconForQuestion:[NSNumber numberWithInt:QUESNUM_1 ]])
    //{
        //[[NSNotificationCenter defaultCenter] removeObserver:self];
        PlaceOrderViewController * moving = [[ PlaceOrderViewController alloc]initWithNibName:@"PlaceOrderViewController" bundle:nil];
        [self.navigationController pushViewController:moving animated:YES];
        
    //}
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
