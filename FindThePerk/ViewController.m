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

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UILabel *thankYouLable;

@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ((AppsaholicSDK*)[AppsaholicSDK sharedManager]).rootViewController = self;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgImg.jpg"]];
    self.nameField.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(challengeCompleted) name:CHALLENGE_COMPLETED object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    self.nameField.hidden = YES;
    self.goButton.hidden = YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)startClicked:(UIButton *)sender
{
    _goButton.hidden = NO;
    _nameField.hidden = NO;
}
- (IBAction)goButtonClicked:(UIButton *)sender
{
    if ([_nameField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Your Name" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        [[BeaconManager createSingleTon] startRanging];
        PlaceOrderViewController * moving = [[ PlaceOrderViewController alloc]initWithNibName:@"PlaceOrderViewController" bundle:nil];
        moving.title = _nameField.text;
        [self.navigationController pushViewController:moving animated:YES];
    }
}
-(void) challengeCompleted
{
    self.thankYouLable.hidden = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
