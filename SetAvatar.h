//
//  SetAvatar.h
//  ChatApp
//
//  Created by Faizan on 02/09/12.
//  Copyright (c) 2012 ronak@itechcoders.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetAvatar : UIViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate> {
    IBOutlet UIActivityIndicatorView *indicator;
    UIImageView *img;
}
@property (strong, nonatomic) IBOutlet UIButton *btnImage;

- (IBAction)SelectPhoto:(id)sender;

@end