//
//  PlaceOrderViewController.m
//  slideInOut
//
//  Created by mmad apps on 16/05/15.
//  Copyright (c) 2015 mmadapps. All rights reserved.
//

#import "PlaceOrderViewController.h"
#import "ViewController.h"
#import "Contants.h"
#import "QuestionManager.h"
#import "AppsaholicSDK.h"
#import "WovenStar.h"
#import "FinalViewController.h"

@interface PlaceOrderViewController ()
{
    UIButton* answerBUtton[4];
    UILabel *ansreLable;
    NSMutableArray *questionArray;
    NSMutableArray *questionNumArray;
    NSMutableArray *imageArray;
    NSMutableArray *optionArray1;
    NSMutableArray *optionArray2;
    NSMutableArray *optionArray3;
    NSMutableArray *optionArray4;
    NSMutableArray *optionArray5;
    NSDictionary *optionDict;
    NSMutableArray *answerArray;
    NSMutableArray *eventArray;
    
    UIView * QUATIONVIEW;
    UIImageView * tabIconImageView;
    UIButton* OkButton;
    WovenStar * ws;
    BOOL bAnswerSubmitted;
    NSString *selectedAnswer;
    NSTimer *timer;
}

@end

@implementation PlaceOrderViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgImg.jpg"]];

    [self setValues];
    [self setUIComponents];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadQuestion) name:BEACON_NOTIFICATION object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

-(void)setValues
{
    //for(int i=0;i<)
    questionArray = [[NSMutableArray alloc]initWithObjects:QUESTION1,QUESTION2,QUESTION3,QUESTION4,QUESTION5, nil];
    questionNumArray = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:QUESNUM_1],[NSNumber numberWithInt:QUESNUM_2],[NSNumber numberWithInt:QUESNUM_3],[NSNumber numberWithInt:QUESNUM_4],[NSNumber numberWithInt:QUESNUM_5], nil];
    optionArray1 = [[NSMutableArray alloc]initWithObjects:Option1_Ques1,Option2_Ques1,Option3_Ques1,Option4_Ques1, nil];
    optionArray2 = [[NSMutableArray alloc]initWithObjects:Option1_Ques2,Option2_Ques2,Option3_Ques2,Option4_Ques2, nil];
    optionArray3 = [[NSMutableArray alloc]initWithObjects:Option1_Ques3,Option2_Ques3,Option3_Ques3,Option4_Ques3, nil];
    optionArray4 = [[NSMutableArray alloc]initWithObjects:Option1_Ques4,Option2_Ques4,Option3_Ques4,Option4_Ques4, nil];
    optionArray5 = [[NSMutableArray alloc]initWithObjects:Option1_Ques5,Option2_Ques5,Option3_Ques5,Option4_Ques5, nil];
    optionDict = [NSDictionary dictionaryWithObjectsAndKeys:optionArray1,[questionArray objectAtIndex:0],optionArray2,[questionArray objectAtIndex:1], optionArray3,[questionArray objectAtIndex:2], optionArray4,[questionArray objectAtIndex:3], optionArray5,[questionArray objectAtIndex:4],nil];
    answerArray = [[NSMutableArray alloc]initWithObjects:ANS_QUES1,ANS_QUES2,ANS_QUES3,ANS_QUES4,ANS_QUES5,nil];
    imageArray = [[NSMutableArray alloc]initWithObjects:Image1,Image2,Image3,Image4,Image5, nil];
    eventArray = [[NSMutableArray alloc]initWithObjects:EVENT1,EVENT2,EVENT3,EVENT4,EVENT5, nil];
    bAnswerSubmitted = NO;
    selectedAnswer = NOT_SELECTED;
    
}

-(void) setUIComponents
{
    UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(36, 20, 248, 41)];
    nameLable.backgroundColor = [UIColor clearColor];
    nameLable.text = APP_NAME;
    
    nameLable.font = [ UIFont fontWithName:RB size:21];
    nameLable.textColor = [UIColor darkGrayColor];
    nameLable.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:nameLable];
    [self loadFirstQuestion];
}

-(void) loadFirstQuestion
{
    tabIconImageView = [[ UIImageView alloc]initWithFrame:CGRectMake(0, 63, 320, 40)];
    tabIconImageView.image = [UIImage imageNamed:Image1];
    tabIconImageView.userInteractionEnabled = NO;
    [self.view addSubview:tabIconImageView];
    
    
    QUATIONVIEW = [[UIView alloc]initWithFrame:CGRectMake(0,120, 320, 350)];
    QUATIONVIEW.backgroundColor = [ UIColor whiteColor];
    
    QUATIONVIEW.layer.borderColor = [UIColor redColor].CGColor;
    QUATIONVIEW.layer.borderWidth = 2;
    [self.view addSubview:QUATIONVIEW];
    
    
    UILabel *quation1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 300, 60)];
    quation1.backgroundColor = [UIColor clearColor];
    quation1.text =QUESTION1;
    
    quation1.numberOfLines = 3;
    quation1.textColor = [UIColor darkGrayColor];
    quation1.font = [ UIFont fontWithName:RB size:10];
    quation1.textAlignment = NSTextAlignmentLeft;
    
    [QUATIONVIEW addSubview:quation1];
    [[QuestionManager createSingleTon] setState:[NSNumber numberWithInt:1]];
    
    int y = 75;
    for (int k = 0; k<optionArray1.count; k++)
    {
        answerBUtton[k] = [UIButton buttonWithType:UIButtonTypeCustom];
        answerBUtton[k] .backgroundColor = [UIColor redColor];
        answerBUtton[k].frame = CGRectMake(10, y, 180, 30);
        [answerBUtton[k] setTitle:[optionArray1 objectAtIndex:k] forState:UIControlStateNormal];
        //PREVIOUS.titleLabel.font = [UIFont fontWithName:RB size:20];
        [answerBUtton[k] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        answerBUtton[k].tag = k;
        answerBUtton[k].selected = YES;
        [answerBUtton[k] addTarget:self action:@selector(optionSelected:) forControlEvents:UIControlEventTouchUpInside];
        answerBUtton[k].contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [QUATIONVIEW addSubview:answerBUtton[k]];
        
        y+=40;
    }
    
    ansreLable = [[UILabel alloc] initWithFrame:CGRectMake(25, y+20, 100, 60)];
    ansreLable.backgroundColor = [UIColor clearColor];
    ansreLable.text = selectedAnswer;
    ansreLable.numberOfLines = 1;
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
    [yesButton addTarget:self action:@selector(yesButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [QUATIONVIEW addSubview:yesButton];
    
    
    UIButton* yesButtonN = [UIButton buttonWithType:UIButtonTypeCustom];
    yesButtonN .backgroundColor = [UIColor redColor];
    yesButtonN.frame = CGRectMake(160 +70, ansreLable.frame.origin.y+20, 40, 30);
    [yesButtonN setTitle:@"N" forState:UIControlStateNormal];
    //OkButton.titleLabel.font = [UIFont fontWithName:RB size:20];
    [yesButtonN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yesButtonN addTarget:self action:@selector(noButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [QUATIONVIEW addSubview:yesButtonN];
}

-(void)nextQuation:(NSString*)question gettheOptions:(NSMutableArray* )array imageName:(NSString *)image
{
    [OkButton setHidden:YES];
    tabIconImageView = [[ UIImageView alloc]initWithFrame:CGRectMake(0, 63, 320, 40)];
    tabIconImageView.image = [UIImage imageNamed:image];
    tabIconImageView.userInteractionEnabled = NO;
    [self.view addSubview:tabIconImageView];
    
    QUATIONVIEW = [[UIView alloc]initWithFrame:CGRectMake(0,120, 320, 350)];
    QUATIONVIEW.backgroundColor = [ UIColor whiteColor];
    
    QUATIONVIEW.layer.borderColor = [UIColor redColor].CGColor;
    QUATIONVIEW.layer.borderWidth = 2;
    [self.view addSubview:QUATIONVIEW];
    
    UILabel *quation1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 300, 60)];
    quation1.backgroundColor = [UIColor clearColor];
    quation1.text = question;
    quation1.numberOfLines = 3;
    quation1.textColor = [UIColor darkGrayColor];
    quation1.font = [ UIFont fontWithName:RB size:10];
    quation1.textAlignment = NSTextAlignmentLeft;
    [QUATIONVIEW addSubview:quation1];
    
    int y = 75;
    for (int k = 0; k<array.count; k++)
    {
        answerBUtton[k] = [UIButton buttonWithType:UIButtonTypeCustom];
        answerBUtton[k] .backgroundColor = [UIColor redColor];
        answerBUtton[k].frame = CGRectMake(10, y, 150, 30);
        [answerBUtton[k] setTitle:[array objectAtIndex:k] forState:UIControlStateNormal];
        //PREVIOUS.titleLabel.font = [UIFont fontWithName:RB size:20];
        [answerBUtton[k] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        answerBUtton[k].tag = k;
        answerBUtton[k].selected = YES;
        [answerBUtton[k] addTarget:self action:@selector(optionSelected:) forControlEvents:UIControlEventTouchUpInside];
        answerBUtton[k].contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [QUATIONVIEW addSubview:answerBUtton[k]];
        
        y+=40;
    }
    
    ansreLable = [[UILabel alloc] initWithFrame:CGRectMake(25, y+20, 100, 60)];
    ansreLable.backgroundColor = [UIColor clearColor];
    ansreLable.text = selectedAnswer;
    
    ansreLable.numberOfLines = 1;
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
    [yesButton addTarget:self action:@selector(yesButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [QUATIONVIEW addSubview:yesButton];
    
    UIButton* yesButtonN = [UIButton buttonWithType:UIButtonTypeCustom];
    yesButtonN .backgroundColor = [UIColor redColor];
    yesButtonN.frame = CGRectMake(160 +70, ansreLable.frame.origin.y+20, 40, 30);
    [yesButtonN setTitle:@"N" forState:UIControlStateNormal];
    //OkButton.titleLabel.font = [UIFont fontWithName:RB size:20];
    [yesButtonN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yesButtonN addTarget:self action:@selector(noButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [QUATIONVIEW addSubview:yesButtonN];
    
}
-(void)noButtonClicked:(UIButton *)action
{
    if(![ansreLable.text isEqualToString:NOT_SELECTED])
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
-(void)yesButtonClicked:(UIButton *)action
{
    if(![ansreLable.text isEqualToString:NOT_SELECTED])
    {
        OkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        OkButton .backgroundColor = [UIColor colorWithRed:252.0/255.0 green:78.0/255.0 blue:10.0/255.0 alpha:1];
        OkButton.frame = CGRectMake(0, 523, 320, 45);
        [OkButton setTitle:@"CONTINUE" forState:UIControlStateNormal];
        //OkButton.titleLabel.font = [UIFont fontWithName:RB size:20];
        [OkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [OkButton addTarget:self action:@selector(okButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:OkButton];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please select any option" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)optionSelected:(UIButton *)action
{
    
    NSLog(@"checkin %ld",(long)action.tag);
    
    int l = 0;
    
    while (l<4)
    {
        if (action.tag == l)
        {
            answerBUtton[l].backgroundColor = [ UIColor greenColor];
            selectedAnswer = answerBUtton[l].titleLabel.text;
            ansreLable.text = selectedAnswer;

        }
        else
        {
           answerBUtton[l].backgroundColor = [ UIColor redColor];
        }
        l++;
    }
    
}

-(void)okButtonClicked:(id)sender
{
    if([OkButton.titleLabel.text isEqualToString:@"QUIT"])
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
    else
    {
        bAnswerSubmitted = YES;
        selectedAnswer = NOT_SELECTED;
        
        if([answerArray containsObject:ansreLable.text])
        {
            NSNumber *index=[[QuestionManager createSingleTon] getState];
            if(index.intValue<5)
            {
                [[AppsaholicSDK sharedManager] trackEvent:[eventArray objectAtIndex:[index intValue]] notificationType:NO withController:self withSuccess:^(BOOL success, NSString *notificationtext, NSNumber *pointEarned) {
                    
                }];
                [self startAnimation];
            }
            if(index.intValue == 5)
            {
                [[NSNotificationCenter defaultCenter] removeObserver:self];
                FinalViewController *finalVC = [[FinalViewController alloc] init];
                [self.navigationController pushViewController:finalVC animated:NO];
                
            }
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Wrong answer!!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
            [alert show];
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
    }
}

-(void)startAnimation
{
    ws = [[WovenStar alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [ws setForeColor:[UIColor colorWithRed:44.0/255 green:72.0/255 blue:108.0/255 alpha:1]
        andBackColor:[UIColor whiteColor]];
    [ws setCenter:self.view.center];
    [self.view addSubview:ws];
    [ws setPaused:NO];
    [OkButton setTitle:@"Find Next Question" forState:UIControlStateNormal];
    [OkButton setEnabled: NO];
    if(timer)
    {
        [timer invalidate];
    }
    timer=[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerMethod) userInfo:nil repeats:NO];
}
-(void)timerMethod
{
    [timer invalidate];
    [OkButton setTitle:@"QUIT" forState:UIControlStateNormal];
    [OkButton setEnabled:YES];
}
-(void)loadQuestion
{
    NSNumber *index=[[QuestionManager createSingleTon] getState];

    if(index.intValue!=5 && [[QuestionManager createSingleTon] didFoundCurrectBeaconForQuestion:[questionNumArray objectAtIndex:[index integerValue]]] && bAnswerSubmitted)
    {
        [ws setPaused:YES];
        NSString *question = [questionArray objectAtIndex:[index intValue]];
        [self nextQuation:question gettheOptions:[optionDict objectForKey:question]  imageName:[imageArray objectAtIndex:[index intValue] ]];
        
        [[QuestionManager createSingleTon] setState:[NSNumber numberWithInt:[index intValue]+1]];
        bAnswerSubmitted = NO;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Alert Button Actions


@end
