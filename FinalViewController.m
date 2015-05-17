//
//  FinalViewController.m
//  FindThePerk
//
//  Created by Amit Shil on 16/05/15.
//  Copyright (c) 2015 Amit Shil. All rights reserved.
//

#import "FinalViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Contants.h"
#import "AppsaholicSDK.h"
@interface FinalViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>
{
    MKMapView *mkMapView;
    CLLocationManager *locationManager;
}

@end

@implementation FinalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(36, 20, 248, 41)];
    nameLable.backgroundColor = [UIColor clearColor];
    nameLable.text = APP_NAME;
    
    nameLable.font = [ UIFont fontWithName:RB size:21];
    nameLable.textColor = [UIColor darkGrayColor];
    nameLable.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:nameLable];

    locationManager.delegate = self;
    
    //Work on Map View
    
    mkMapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 80, 320, 240)];
    mkMapView.delegate = self;
    mkMapView.showsUserLocation = NO;
    mkMapView.zoomEnabled = true;
    mkMapView.scrollEnabled = true;
    mkMapView.mapType = MKMapTypeStandard;
    NSLog(@" User Location : %@",mkMapView.userLocation.title);
    NSLog(@" User Location Latitutde : - %f",mkMapView.userLocation.location.coordinate.latitude);
    
    
    CLLocationCoordinate2D perkLocation = CLLocationCoordinate2DMake(12.935336,77.630869);
    mkMapView.centerCoordinate = perkLocation;
    mkMapView.region = MKCoordinateRegionMakeWithDistance(perkLocation, 100, 100);
    
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
    [myAnnotation setCoordinate:perkLocation];
    myAnnotation.title = @"Welcome To Perk";
    myAnnotation.subtitle = @"You are here!!!";
    
    [mkMapView addAnnotation:myAnnotation];
    
    [self.view addSubview:mkMapView];
    
    
    UIImageView *giftBox = [[UIImageView alloc] initWithFrame:CGRectMake(70, 320, 150, 150)];
    giftBox.image =[UIImage imageNamed:@"gift_box"];
    
    [self.view addSubview:giftBox];
    
    UIButton* clameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    clameButton .backgroundColor = [UIColor greenColor];
    clameButton.frame = CGRectMake(0, 520, 320, 40);
    [clameButton setTitle:@"CLAIM YOUR POINTS" forState:UIControlStateNormal];
    //OkButton.titleLabel.font = [UIFont fontWithName:RB size:20];
    [clameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [clameButton addTarget:self action:@selector(clameButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clameButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivePortalCloseNotification)
                                                 name:PORTAL_CLOSE_NOTIFICATION
                                               object:nil];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)clameButtonAction:(UIButton *)action
{
    [[AppsaholicSDK sharedManager] showPortal];
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    id <MKAnnotation> annotation = [view annotation];
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        NSLog(@"Clicked Perk Office");
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"You Won" message:@"Click OK to Get Your Gift" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertView show];
}

- (MKAnnotationView *)mapView:(MKMapView *)sender viewForAnnotation:(id < MKAnnotation >)annotation
{
    static NSString *reuseId = @"StandardPin";
    
    MKPinAnnotationView *aView = (MKPinAnnotationView *)[sender
                                                       dequeueReusableAnnotationViewWithIdentifier:reuseId];
    if (aView == nil)
    {
        aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                reuseIdentifier:reuseId] ;
        aView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Perk_LOGO_Black.png"]];
        aView.leftCalloutAccessoryView = iconView;
        aView.canShowCallout = YES;
    }
    
    aView.annotation = annotation;
    
    return aView;
}

-(void)receivePortalCloseNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:CHALLENGE_COMPLETED object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
