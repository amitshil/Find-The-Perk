//
//  QuestionManager.h
//  FindThePerk
//
//  Created by Amit Shil on 16/05/15.
//  Copyright (c) 2015 Amit Shil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionManager : NSObject

@property NSNumber* currentState;
+(QuestionManager *) createSingleTon;
-(BOOL)didFoundCurrectBeaconForQuestion:(NSInteger)QuestionNum;
-(void)setState:(NSNumber*)state;
-(NSNumber*)getState;

@end
