//
//  AddressBookDialogScreen.m
//  ChatApp
//
//  Created by Faizan on 08/09/12.
//  Copyright (c) 2012 ronak@itechcoders.com. All rights reserved.
//

#import "AddressBookDialogScreen.h"
#import <AddressBook/AddressBook.h>

@interface AddressBookDialogScreen ()

@end

@implementation AddressBookDialogScreen

@synthesize delegation = _delegation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Tableview 
// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    // Configure the cell.
    cell.textLabel.text = @"Contact test";
    return cell;
}

#pragma mark - Button Action
- (IBAction)closeClicked:(id)sender {
    [self.view removeFromSuperview];
}

@end