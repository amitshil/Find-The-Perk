//
//  SteptwoViewController.m
//  slideInOut
//
//  Created by mmad apps on 16/05/15.
//  Copyright (c) 2015 mmadapps. All rights reserved.
//

#import "SteptwoViewController.h"
#import "StepThreeViewController.h"
#import "ViewController.h"
#import "Contants.h"
#define RB   @"ROBOTO-BOLD"
#define  RR   @"ROBOTO-REGULAR"

@interface SteptwoViewController ()
{
   
  
    UIButton* answerBUtton[4];
    UILabel *ansreLable;
    NSMutableArray *optionArray;

}
@end

@implementation SteptwoViewController

- (void)viewDidLoad {

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgImg.jpg"]];
    optionArray = [[NSMutableArray alloc]initWithObjects:Option1_Ques2,Option2_Ques2,Option3_Ques2,Option4_Ques2, nil];

    
    UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(36, 20, 248, 41)];
    nameLable.backgroundColor = [UIColor clearColor];
    nameLable.text = APP_NAME;
    nameLable.textColor = [UIColor darkGrayColor];
    nameLable.font = [ UIFont fontWithName:RB size:21];
    nameLable.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:nameLable];
    
    
    UIImageView * tabIconImageView = [[ UIImageView alloc]initWithFrame:CGRectMake(0, 63, 320, 40)];
    tabIconImageView.image = [UIImage imageNamed:@"stepX2"];
    tabIconImageView.userInteractionEnabled = NO;
    [self.view addSubview:tabIconImageView];


    
    
    UIView * QUATIONVIEW = [[UIView alloc]initWithFrame:CGRectMake(0,120, 320, 350)];
    QUATIONVIEW.backgroundColor = [ UIColor whiteColor];
    
    QUATIONVIEW.layer.borderColor = [UIColor redColor].CGColor;
    QUATIONVIEW.layer.borderWidth = 2;
    [self.view addSubview:QUATIONVIEW];
    
    
    UILabel *quation1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 300, 60)];
    quation1.backgroundColor = [UIColor clearColor];
    quation1.text =[NSString stringWithFormat:@"Q2: %@", QUESTION2];
    
    quation1.numberOfLines = 3;
    quation1.textColor = [UIColor darkGrayColor];
    quation1.font = [ UIFont fontWithName:RB size:10];
    quation1.textAlignment = NSTextAlignmentLeft;
    
    [QUATIONVIEW addSubview:quation1];
    
    
    
    int y = 75;
    for (int k = 0; k<optionArray.count; k++) {
        
        
        answerBUtton[k] = [UIButton buttonWithType:UIButtonTypeCustom];
        answerBUtton[k] .backgroundColor = [UIColor redColor];
        answerBUtton[k].frame = CGRectMake(10, y, 150, 30);
        [answerBUtton[k] setTitle:[optionArray objectAtIndex:k] forState:UIControlStateNormal];
        //PREVIOUS.titleLabel.font = [UIFont fontWithName:RB size:20];
        [answerBUtton[k] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        answerBUtton[k].tag = k;
        answerBUtton[k].selected = YES;
        [answerBUtton[k] addTarget:self action:@selector(answerBUttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [QUATIONVIEW addSubview:answerBUtton[k]];
        
        y+=40;
    }
    
    ansreLable = [[UILabel alloc] initWithFrame:CGRectMake(25, y+20, 100, 60)];
    ansreLable.backgroundColor = [UIColor clearColor];
    ansreLable.text = @"Select the answer";
    
    ansreLable.numberOfLines = 3;
    ansreLable.textColor = [UIColor darkGrayColor];
    ansreLable.font = [ UIFont fontWithName:RB size:10];
    ansreLable.textAlignment = NSTextAlignmentLeft;
    
    [QUATIONVIEW addSubview:ansreLable];
    
    
    
    UIButton* yesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    yesButton .backgroundColor = [UIColor greenColor];
    yesButton.frame = CGRectMake(160, ansreLable.frame.origin.y+20, 40, 30);
    [yesButton setTitle:@"Y" forState:UIControlStateNormal];
    //OkButton.titleLabel.font = [UIFont fontWithName:RB size:20];
    [yesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yesButton addTarget:self action:@selector(yesAction:) forControlEvents:UIControlEventTouchUpInside];
    [QUATIONVIEW addSubview:yesButton];
    
    
    UIButton* yesButtonN = [UIButton buttonWithType:UIButtonTypeCustom];
    yesButtonN .backgroundColor = [UIColor redColor];
    yesButtonN.frame = CGRectMake(160 +70, ansreLable.frame.origin.y+20, 40, 30);
    [yesButtonN setTitle:@"N" forState:UIControlStateNormal];
    //OkButton.titleLabel.font = [UIFont fontWithName:RB size:20];
    [yesButtonN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yesButtonN addTarget:self action:@selector(Noction:) forControlEvents:UIControlEventTouchUpInside];
    [QUATIONVIEW addSubview:yesButtonN];
  
}

-(void)Noction:(UIButton *)action{
    
    if(![ansreLable.text isEqualToString:@"Select the answer"])
    {
        for(UIViewController * view in self.navigationController.viewControllers)
        {
            NSLog(@"view::%@",view);
            if([view isKindOfClass:[ViewController class]])
            {
                [self.navigationController popToViewController:view animated:YES];
            }
        }
    }
    
    
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please select any option" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}
-(void)yesAction:(UIButton *)action{
    
    if(![ansreLable.text isEqualToString:@"Select the answer"])
    {
        UIButton* OkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        OkButton .backgroundColor = [UIColor colorWithRed:252.0/255.0 green:78.0/255.0 blue:10.0/255.0 alpha:1];
        OkButton.frame = CGRectMake(0, 523, 320, 45);
        [OkButton setTitle:@"NEXT" forState:UIControlStateNormal];
        //OkButton.titleLabel.font = [UIFont fontWithName:RB size:20];
        [OkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [OkButton addTarget:self action:@selector(OkButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:OkButton];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please select any option" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    
    
    
}

-(void)answerBUttonAction:(UIButton *)action{
    
    
    NSLog(@"checkin %ld",(long)action.tag);
    
    int l = 0;
    
    while (l<optionArray.count) {
        
        if (action.tag == l) {
            answerBUtton[l].backgroundColor = [ UIColor greenColor];
            ansreLable.text = answerBUtton[l].titleLabel.text;
            
        }
        else{
            answerBUtton[l].backgroundColor = [ UIColor redColor];
        }
        l++;
    }
    
    
}



-(void)OkButtonAction:(id)sender{
    StepThreeViewController *pMainViewController = [[StepThreeViewController alloc]initWithNibName:@"StepThreeViewController" bundle:nil];
    [self.navigationController pushViewController:pMainViewController animated:NO];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
   // viewProfileFound = YES;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
