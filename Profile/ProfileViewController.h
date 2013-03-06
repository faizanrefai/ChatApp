//
//  ProfileViewController.h
//  ChatApp
//
//  Created by Faizan on 01/09/12.
//  Copyright (c) 2012 ronak@itechcoders.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SetAvatar.h"
#import "SetStatus.h"
#import "settingViewController.h"
#import "EGOImageView.h"
#import "MyPeofileViewController.h"

@interface ProfileViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
    AppDelegate *deleAPP;
    IBOutlet UITableView *myTable;

    settingViewController *objSettingScreen;
    MyPeofileViewController *objprofileview;
    SetAvatar *objSetAvatar;
    SetStatus *objSetStatus;
    UIImageView *img;
}

@property (unsafe_unretained,nonatomic)__unsafe_unretained id   delegat;

@end