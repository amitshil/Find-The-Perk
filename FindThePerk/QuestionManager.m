//
//  QuestionManager.m
//  FindThePerk
//
//  Created by Amit Shil on 16/05/15.
//  Copyright (c) 2015 Amit Shil. All rights reserved.
//

#import "QuestionManager.h"
#import "BeaconManager.h"
#import "Contants.h"
#import <CoreLocation/CoreLocation.h>


@implementation QuestionManager
+(QuestionManager *) createSingleTon
{
    static QuestionManager *single= nil;
    if (single == nil)
    {
        single = [[QuestionManager alloc] init];
    }
    return single;
}

-(id)init
{
    self = [super init];
    if(self)
    {
        
        
    }
    return self;
}

-(NSNumber*)getState
{
    return _currentState;
}
-(void)setState:(NSNumber*)state
{
    _currentState = state;
}
-(BOOL)didFoundCurrectBeaconForQuestion:(NSNumber*)QuestionNum
{
    CLBeacon *beacon = [[BeaconManager createSingleTon] currentBeacon];
    
    switch (QuestionNum.intValue) {
        case 1:
            if([beacon.minor isEqualToNumber:[NSNumber numberWithInt:MINOR_1]])
            {
                return YES;
            }
            break;
            
        case 2:
            if([beacon.minor isEqualToNumber:[NSNumber numberWithInt:MINOR_2]])
                return YES;
            break;
            
        case 3:
            if([beacon.minor isEqualToNumber:[NSNumber numberWithInt:MINOR_3]])
                return YES;
            break;
            
        case 4:
            if([beacon.minor isEqualToNumber:[NSNumber numberWithInt:MINOR_4]])
                return YES;
            break;
            
        case 5:
            if([beacon.minor isEqualToNumber:[NSNumber numberWithInt:MINOR_5]])
                return YES;
            break;
        default:
            break;
    }
    return NO;
}



@end
