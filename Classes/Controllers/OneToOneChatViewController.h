//  OneToOneChatViewController.h
//  FileTransfer
//  Created by Admin on 10/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.

#import <UIKit/UIKit.h>
#import "XMPPUserCoreDataStorageObject.h"

@interface OneToOneChatViewController : UIViewController <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>{
    XMPPUserCoreDataStorageObject *user_;
    NSFetchedResultsController *fetchedResultsController;
    BOOL keyboardVisible;
}

@property (nonatomic,retain) XMPPUserCoreDataStorageObject *user;
@property (nonatomic,retain) IBOutlet UITableView *mainTable;
@property (nonatomic,retain) IBOutlet UITextField *inputTextField;
@property (nonatomic,retain) IBOutlet UIButton *sendButton;
@property (nonatomic,retain) IBOutlet UIView *inputTextView;

- (IBAction)sendAction:(id)sender;
- (NSFetchedResultsController *)fetchedResultsController;

@end