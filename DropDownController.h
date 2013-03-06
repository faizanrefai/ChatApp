//
//  DropDownController.h
//  ChatApp
//
//  Created by Faizan on 08/09/12.
//  Copyright (c) 2012 ronak@itechcoders.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownController : UITableViewController

@property (nonatomic,strong)  id delegation;

-(void)selectRow:(NSString*)str;

@end