//
//  settingViewController.h
//  ChatApp
//
//  Created by Faizan on 01/09/12.
//  Copyright (c) 2012 ronak@itechcoders.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCellForList.h"

@interface settingViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
    IBOutlet UIScrollView *scrollview;
    NSString *strid;
    int ipath;
}

@property (retain, nonatomic) IBOutlet UITableView *myTable;
@property(nonatomic,retain)IBOutlet CustomCellForList *objCell;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

- (IBAction)buttonPressed:(id)sender;
- (IBAction)doneSetting:(id)sender;
-(IBAction)remove:(id)sender;

@end