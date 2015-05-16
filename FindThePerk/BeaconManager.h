//
//  BeaconManager.h
//  FindThePerk
//
//  Created by Amit Shil on 16/05/15.
//  Copyright (c) 2015 Amit Shil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface BeaconManager : NSObject

+(BeaconManager *) createSingleTon;
-(void)startRanging;
-(CLBeacon*)currentBeacon;

@end
