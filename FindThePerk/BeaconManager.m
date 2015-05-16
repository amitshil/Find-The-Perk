//
//  BeaconManager.m
//  FindThePerk
//
//  Created by Amit Shil on 16/05/15.
//  Copyright (c) 2015 Amit Shil. All rights reserved.
//

#import "BeaconManager.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "Contants.h"


@interface BeaconManager () <CLLocationManagerDelegate, CBPeripheralManagerDelegate>
{
    BOOL bFirstBeaconFound;
}

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CBPeripheralManager *peripheralManager;
@property CLBeaconRegion *beaconRegion;
@property (strong,nonatomic)  CLBeacon *currentBeacon;


@end

@implementation BeaconManager

+(BeaconManager *) createSingleTon
{
    static BeaconManager *single= nil;
    if (single == nil)
    {
        single = [[BeaconManager alloc] init];
    }
    return single;
}

-(id)init
{
    self = [super init];
    if(self)
    {
        _currentBeacon=[[CLBeacon alloc] init];
        bFirstBeaconFound = NO;
        
    }
    return self;
}

-(void)startRanging
{
    NSUUID *uuid=[[NSUUID alloc]initWithUUIDString:BEACON_UUID];
    _beaconRegion=[[CLBeaconRegion alloc]initWithProximityUUID:uuid identifier:@"beaconUUID"];
    _locationManager=[[CLLocationManager alloc] init];
    _locationManager.delegate=self;
    [_locationManager startMonitoringForRegion:_beaconRegion];
    if(IS_OS_8_OR_LATER)
    {
        [_locationManager requestAlwaysAuthorization];
        [_locationManager requestWhenInUseAuthorization];
    }
    if([CLLocationManager isRangingAvailable])
    {
        [_locationManager startRangingBeaconsInRegion:_beaconRegion];
    }
}

-(CLBeacon*)currentBeacon
{
    NSLog(@"minor %@",_currentBeacon.minor);
    return _currentBeacon;
}

#pragma mark CLLocationMangaerDelegate methods
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
}

-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    
}
-(void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}
-(void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    
}
- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region
{
    
}
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    
}

- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region
{
    for(CLBeacon *beacon in beacons)
    {
       /* NSLog(@"Beacon found - \nUUID: %@, \nMajor: %@, \nMinor: %@, \nProximity:%ld, \nRSSI: %ld, \nAccuracy: %f",
              beacon.proximityUUID,beacon.major,beacon.minor,beacon.proximity,(long)beacon.rssi,beacon.accuracy);*/
        //if(!bFirstBeaconFound){
          //  _currentBeacon = beacon;
           // bFirstBeaconFound=YES;
            //[[NSNotificationCenter defaultCenter] postNotificationName:BEACON_NOTIFICATION object:nil];
        //}
        //if(_currentBeacon.major != beacon.major && _currentBeacon.minor != beacon.minor)
        //{
            _currentBeacon = beacon;
        
            [[NSNotificationCenter defaultCenter] postNotificationName:BEACON_NOTIFICATION object:nil];
        //}
        
    }
    
}

-(void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error
{
    
}

#pragma mark - CBPeripheralManagerDelegate methods
-(void)peripheralManagerDidUpdateState:(CBPeripheralManager*)peripheral
{
    
}

@end
