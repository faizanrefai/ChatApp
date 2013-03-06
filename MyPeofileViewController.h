//
//  MyPeofileViewController.h
//  ChatApp
//
//  Created by Faizan on 01/09/12.
//  Copyright (c) 2012 ronak@itechcoders.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPeofileViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource> {
    NSString *strSelect;
    NSString *segmentMale;
    
    IBOutlet UIToolbar *toolBarPicker;
    NSMutableArray *arrData;
    IBOutlet UILabel *lblEthnicity;

    IBOutlet UITextField *txtAge;
    IBOutlet UIActivityIndicatorView *indicator;
    IBOutlet UILabel *lblEndRange;
    IBOutlet UILabel *lblStratRange;
    
    IBOutlet UISegmentedControl *segmentMaleFemale;
}
@property (strong, nonatomic) IBOutlet UITextField *txtMingleID;
@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtInterestedAge;
@property (strong, nonatomic) IBOutlet UITextField *txtMyEthinicity;
@property (strong, nonatomic) IBOutlet UIScrollView *scrlProfile;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerData;

@property(nonatomic,retain)IBOutlet UISlider *personality;
@property(nonatomic,retain)IBOutlet UISlider *sensofhumar;
@property(nonatomic,retain)IBOutlet UISlider *looks;
@property(nonatomic,retain)IBOutlet UISlider *sexiness;
@property(nonatomic,retain)IBOutlet UISlider *inteligence;
@property(nonatomic,retain)IBOutlet UISlider *commonIntrest;

- (IBAction)segmentChange:(id)sender;
- (IBAction)switching:(id)sender;
- (IBAction)DonePicker:(id)sender;
- (IBAction)showPicker:(id)sender;
- (IBAction)showPickerEthencity:(id)sender;
-(IBAction)Back:(id)sender;
-(void)ehanicityList;
- (IBAction)SelectPhoto:(id)sender;
-(IBAction)SetPersonality:(id)sender;
-(IBAction)SetSensofHumar:(id)sender;
-(IBAction)SetLooks:(id)sender;
-(IBAction)SetSexiness:(id)sender;
-(IBAction)SetInteligence:(id)sender;
-(IBAction)SetCommonIntrest:(id)sender;
-(void)hidekeyboard;

@end