//
//  CustomCellForList.h
//  ChatApp
//
//  Created by Kartik Arora on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface CustomCellForList : UITableViewCell

@property(nonatomic,retain)IBOutlet UILabel *lblName;
@property(nonatomic,retain)IBOutlet UILabel *lblTime;
@property(nonatomic,retain)IBOutlet UILabel *lblDescription;
@property(nonatomic,retain)IBOutlet EGOImageView *imgUser;
@property (nonatomic,assign) UIView *customCallOut;
@property(nonatomic,retain)IBOutlet UIButton *btnremove;

@end