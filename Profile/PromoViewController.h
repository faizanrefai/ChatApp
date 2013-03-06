//
//  PromoViewController.h
//  ChatApp
//
//  Created by Faizan on 01/09/12.
//  Copyright (c) 2012 ronak@itechcoders.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromoViewController : UIViewController<UIAlertViewDelegate> {
	NSCalendar *Mycal;
	NSDateComponents *compA;
	NSDateComponents *currentHighLightDateComp;
	NSInteger currentDay; 
	NSInteger currentMonth;
	NSArray	 * _dayNames;
	NSArray  * _monthNames;  
    NSInteger globWeekDay;

	UIButton *btnDay;
    UILabel *lblDay;
	UIImageView* buttonImage;
	
	IBOutlet UIView* MainView;
	IBOutlet UIButton *btnNext;
	IBOutlet UIButton *btnPrevious;
	IBOutlet UILabel* lblMonth;
	IBOutlet UILabel* lblSun;
	IBOutlet UILabel* lblMon;
	IBOutlet UILabel* lblTue;
	IBOutlet UILabel* lblWed;
	IBOutlet UILabel* lblThu;
	IBOutlet UILabel* lblFri;
	IBOutlet UILabel* lblSat;
	IBOutlet UILabel* lblShowdatetime;
}
@property(nonatomic, retain)NSString* strCalDate;
@property(nonatomic, retain)NSString* strShoeInfoDate;

-(IBAction)nextMonth:(id)sender;
-(IBAction)preMonth:(id)sender;
-(void)DrawMonthInPortraitView;
-(void)BtnDayClicked:(id)sender;
-(BOOL)isCurrentDate;
-(void)showPortraitView;
-(void)showLandscapeView;
-(void)viewLoad;
-(void)showMode;

@end