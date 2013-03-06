//
//  CustomCellForList.m
//  ChatApp
//
//  Created by Kartik Arora on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomCellForList.h"

@implementation CustomCellForList
@synthesize lblName,lblTime,lblDescription,imgUser,btnremove;

@synthesize customCallOut;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end