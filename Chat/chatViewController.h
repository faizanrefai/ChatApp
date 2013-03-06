//
//  chatViewController.h
//  ChatApp
//
//  Created by Faizan on 01/09/12.
//  Copyright (c) 2012 ronak@itechcoders.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
//#import "XMPPUserCoreDataStorageObject.h"

@interface chatViewController : UIViewController< UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    IBOutlet UIView *viewOption;
    IBOutlet UITableView *tblChat;
    NSMutableArray *messages;
    IBOutlet UITextField *field;
    IBOutlet UIToolbar *toolbar;
    
    
    IBOutlet UIButton *btnopen;
    IBOutlet UIButton *btnVoiceChat;
    IBOutlet UIButton *btnSendPic;
    IBOutlet UIButton *btnBlockUser;
    IBOutlet UIButton *btntext;
    IBOutlet UIButton *btnREportAbuse;
    IBOutlet UIScrollView *scrollview;
    
  //  XMPPUserCoreDataStorageObject *user_;
   // NSFetchedResultsController *fetchedResultsController;
    BOOL keyboardVisible;
}

-(IBAction)OpenOptions:(id)sender;
-(IBAction)VoiceChat:(id)sender;
-(IBAction)SendPic:(id)sender;
-(IBAction)BlockUser:(id)sender;
-(IBAction)Text:(id)sender;
-(IBAction)ReportAbuse:(id)sender;
-(IBAction)Send:(id)sender;
-(void)hidekeyboard;

//@property (nonatomic,retain) XMPPUserCoreDataStorageObject *user;
@property (nonatomic,retain) IBOutlet UIView *inputTextView;
@property (nonatomic,retain) IBOutlet UITableView *tblChat;
@property (nonatomic,retain) IBOutlet UITextField *field;
@property (nonatomic,retain) IBOutlet UIButton *sendButton;

@end