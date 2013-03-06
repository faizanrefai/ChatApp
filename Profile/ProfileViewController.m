//
//  ProfileViewController.m
//  ChatApp
//
//  Created by Faizan on 01/09/12.
//  Copyright (c) 2012 ronak@itechcoders.com. All rights reserved.
//

#import "ProfileViewController.h"
#import "settingViewController.h"
#import "MyPeofileViewController.h"
#import "JSONParser.h"
#import "EGOImageView.h"

@interface ProfileViewController () {
    NSMutableArray *mainArry;
}

@end

@implementation ProfileViewController
@synthesize delegat = _delegat;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    mainArry = [[NSMutableArray alloc]initWithObjects:@"Stacy Williums",@"Set Status",@"Set Avatar",@"My Profile",@"Settings", nil];
    
    deleAPP = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [myTable reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [myTable reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [myTable reloadData];
}

- (void)viewDidUnload {
    myTable = nil;
    [super viewDidUnload];
    [self.navigationController setNavigationBarHidden:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Tableview 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return mainArry.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.textLabel.textColor = [UIColor whiteColor];
    }

    switch (indexPath.row) {
        case 0: {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            UILabel *lblname = [[UILabel alloc] initWithFrame:CGRectMake(60,0,250,25)];
            lblname.textColor = [UIColor whiteColor];
            lblname.backgroundColor = [UIColor clearColor];
            lblname.font = [UIFont fontWithName:@"Helvetica" size:18];
            lblname.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"userName"];
            [cell.contentView addSubview:lblname];
            
            UILabel *lblstatus = [[UILabel alloc] initWithFrame:CGRectMake(60, 24, 250, 19)];
            lblstatus.textColor =[UIColor whiteColor];
            lblstatus.backgroundColor = [UIColor clearColor];
            lblstatus.font = [UIFont fontWithName:@"Helvetica" size:15];
            lblstatus.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"tUserStatus"];
            [cell.contentView addSubview:lblstatus];

            NSString *strimage = [[NSUserDefaults standardUserDefaults]valueForKey:@"vAvatarThumb"];
            img = [[UIImageView alloc ]initWithFrame:CGRectMake(0, 0, 50, 44)];
            img.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:strimage]]];
           [cell.contentView addSubview:img];
             break;
        }
            cell.textLabel.font = [UIFont systemFontOfSize:17];
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"btn_SetStatus.png"];
            cell.textLabel.text = [mainArry objectAtIndex:indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_teer.png"]];
            break;
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"btn_SetAvatar.png"];
            cell.textLabel.text = [mainArry objectAtIndex:indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_teer.png"]];
            break;
        case 3:
            cell.imageView.image = [UIImage imageNamed:@"btn_0My-profile.png"];
            cell.textLabel.text = [mainArry objectAtIndex:indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_teer.png"]];
            break;
        case 4:
            cell.imageView.image = [UIImage imageNamed:@"btnSettings.png"];
            cell.textLabel.text = [mainArry objectAtIndex:indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_teer.png"]];
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row==0) {
             
    } else if (indexPath.row==1) {
        if (objSetStatus) {
             
        } else {
            objSetStatus =[[SetStatus alloc]initWithNibName:@"SetStatus" bundle:nil];
        }
        [deleAPP.navigationController pushViewController:objSetStatus animated:YES];
    } else if (indexPath.row==2) {
        if (objSetAvatar) {
            
        } else {
            objSetAvatar =[[SetAvatar alloc]initWithNibName:@"SetAvatar" bundle:nil];
        }        
        [deleAPP.navigationController pushViewController:objSetAvatar animated:YES];
    } else if (indexPath.row==3) {
        if (objprofileview) {
            
        } else {
            objprofileview = [[MyPeofileViewController alloc]initWithNibName:@"MyPeofileViewController" bundle:nil];
        }
        [deleAPP.navigationController pushViewController:objprofileview animated:YES];
    } else if (indexPath.row==4) {
        if (objSettingScreen) {
            
        } else {
            objSettingScreen =[[settingViewController alloc]initWithNibName:@"settingViewController" bundle:nil];
        }        
        [deleAPP.navigationController pushViewController:objSettingScreen animated:YES];
    }
}

@end