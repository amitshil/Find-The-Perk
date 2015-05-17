//
//  WovenStar.h
//  WovenStar
//
//  Created by Sandy Lee on 10/16/14.
//  Copyright (c) 2014 iaomw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WovenStar : UIView

@property (getter=isPaused, nonatomic) BOOL paused;

@property (assign, nonatomic) CGFloat duration;

@property (assign, nonatomic) CGFloat eleLength;
@property (assign, nonatomic) CGFloat eleWidth;

@property (assign, nonatomic) BOOL debug;

- (void)setForeColor:(UIColor *)foreColor andBackColor:(UIColor*)backColor;

@end

// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net 
