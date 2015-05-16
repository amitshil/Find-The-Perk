//
//  StepFourViewController.h
//  slideInOut
//
//  Created by mmad apps on 22/04/15.
//  Copyright (c) 2015 mmadapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepFourViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    BOOL viewProfileFound;
    UIView* viewProfileTransparentView ;
     UITableView * bankTableView;
}
@end
