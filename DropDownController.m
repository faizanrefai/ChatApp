//
//  DropDownController.m
//  ChatApp
//
//  Created by Faizan on 08/09/12.
//  Copyright (c) 2012 ronak@itechcoders.com. All rights reserved.
//

#import "DropDownController.h"

@interface DropDownController () {
    NSMutableArray *dropDownArray;
}

@end

@implementation DropDownController

@synthesize delegation=_delegation;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

-(void)selectRow:(NSString*)str {

}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    dropDownArray=[[NSMutableArray alloc]initWithObjects:@"By Proximity",@"By Age",@"By Range",@"By Ethnicity", nil];
    
    NSMutableArray *addressBookArray = [NSMutableArray new];
    [addressBookArray addObject:@"sample"];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dropDownArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    // Configure the cell...
    cell.textLabel.text = [dropDownArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_delegation selectRow:[dropDownArray objectAtIndex:indexPath.row]];
}

@end