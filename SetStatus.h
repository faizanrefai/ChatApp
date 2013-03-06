//
//  SetStatus.h
//  ChatApp
//
//  Created by Faizan on 02/09/12.
//  Copyright (c) 2012 ronak@itechcoders.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetStatus : UIViewController<UITextViewDelegate> {
    IBOutlet UIActivityIndicatorView *indicator;
}

@property(nonatomic,retain)IBOutlet UITextView *txtstatus;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollview;

- (IBAction)doneStatus:(id)sender;

@end