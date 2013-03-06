//
//  UserDetailVC.h
//  ChatApp
//
//  Created by Faizan on 14/09/12.
//  Copyright (c) 2012 ronak@itechcoders.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "chatViewController.h"

@interface UserDetailVC : UIViewController <NSFetchedResultsControllerDelegate> {
    NSFetchedResultsController *fetchedResultsController;
    
     IBOutlet UIImageView *imageVieww;
     IBOutlet UIActivityIndicatorView *indicator;
    
     IBOutlet UILabel *emailLabel;
     IBOutlet UILabel *regTimeLaBEL;
     IBOutlet UILabel *lastLoginLBEL;
     IBOutlet UILabel *ageLable;
     IBOutlet UILabel *nameLabel;
     IBOutlet UILabel *statusLabel;
     IBOutlet UILabel *ethanictyLabel;
}
@property (nonatomic,assign)NSString *iUserID;

-(IBAction)back:(id)sender;
- (IBAction)chatNowClicked:(id)sender;
- (IBAction)abuseBtnClicked:(id)sender;
- (IBAction)blockedClicked:(id)sender;

@end