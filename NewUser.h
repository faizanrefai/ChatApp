//
//  NewUser.h
//  ChatApp
//
//  Created by Kartik Arora on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListScreen.h"

@interface NewUser : UIViewController<UITextFieldDelegate> {
    NSString *strGender;
    IBOutlet UIActivityIndicatorView *indicator;
    NSMutableArray *Mainarry;
    ListScreen *objListScreen;
}
@property (retain, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UISegmentedControl *Gender;

- (IBAction)Condition:(UIButton*)sender;
- (IBAction)SegiClick:(id)sender;
- (IBAction)Register:(id)sender;
-(IBAction)Back:(id)sender;
-(void)hidekeyboard;

@end