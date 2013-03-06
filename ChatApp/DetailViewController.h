//
//  DetailViewController.h
//  ChatApp
//
//  Created by Kartik Arora on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewUser.h"
#import "ListScreen.h"  

@interface DetailViewController : UIViewController<UITextFieldDelegate> {
    NewUser *objNewUser;
    ListScreen *objListScreen;
     IBOutlet UIActivityIndicatorView *indicator;
}

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong, nonatomic) IBOutlet UITextField *txtUsername;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
- (IBAction)Login:(id)sender;
- (IBAction)NewUSer:(id)sender;
-(void)hidekeyboard;

@end