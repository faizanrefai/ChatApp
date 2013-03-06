//
//  AddressBookDialogScreen.h
//  ChatApp
//
//  Created by Faizan on 08/09/12.
//  Copyright (c) 2012 ronak@itechcoders.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>

@interface AddressBookDialogScreen : UIViewController

@property (nonatomic,strong) id delegation;

- (IBAction)closeClicked:(id)sender;

@end