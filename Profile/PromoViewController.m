//
//  PromoViewController.m
//  ChatApp
//
//  Created by Faizan on 01/09/12.
//  Copyright (c) 2012 ronak@itechcoders.com. All rights reserved.
//

BOOL flag;
BOOL viewMode,viewMode1,FlagViewDidLoad=NO;
NSDate* today;
NSDate* currentHighlightDate; 
NSInteger monthMode;
NSDate* dateMode;
NSDate* FirstDateofMonth;
NSString *yearString;
NSInteger year, weekDay, month;
int DAY;
float x, y, width,height;
NSString *date;

#import "PromoViewController.h"

@implementation PromoViewController
@synthesize strCalDate;
@synthesize strShoeInfoDate;

#pragma mark - View Lifecycle
- (void)loadView {
    [super loadView];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
}

-(void)viewLoad {
	_dayNames = [[NSArray alloc] initWithObjects: @"Sun", @"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", nil];
	_monthNames = [[NSArray alloc] initWithObjects: @"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December", nil];
	
	Mycal = [NSCalendar currentCalendar];
	today = [NSDate date];
	compA =[Mycal components:(NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit) fromDate:today];	 
	FirstDateofMonth=[today dateByAddingTimeInterval:([compA day]-1)*(-24*60*60)];
	
	compA =[Mycal components:(NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit) fromDate:FirstDateofMonth];
	today = FirstDateofMonth;
	compA = [Mycal components:(NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit) fromDate:today];
	[compA setMonth:([compA month])];
	[self DrawMonthInPortraitView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    FlagViewDidLoad=YES;
	[self viewLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark - Button Action
//Remove view and create new view
-(void)removeView {
	for (UIView *v in MainView.subviews) {
		if ([v isKindOfClass:[UIButton class]])
			[v removeFromSuperview];
	}
}

//show next month calendar when next button press
-(IBAction)nextMonth:(id)sender {
	[self removeView];
	Mycal = [NSCalendar currentCalendar];
	compA = [Mycal components:(NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit) fromDate:today];
	[compA setMonth:([compA month]+1)];// it will increase month by 1 for next month;
	monthMode = [compA month];
	[self DrawMonthInPortraitView];
}

//show Previous month calendar when previous button press
-(IBAction)preMonth:(id)sender {
	[self removeView];
	Mycal = [NSCalendar currentCalendar];
	compA = [Mycal components:(NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit) fromDate:today];
	[compA setMonth:([compA month]-1)];// it will decrease month by 1 for previous month;
	monthMode = [compA month];
	[self DrawMonthInPortraitView];
}

// return true value of current date, current month
-(BOOL)isCurrentDate {
	Mycal = [NSCalendar currentCalendar];
	currentHighlightDate = [NSDate date];
	currentHighLightDateComp = [Mycal components:(NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit) fromDate:currentHighlightDate];
	currentDay = [currentHighLightDateComp day];
	currentMonth = [currentHighLightDateComp month];
	return YES;
}

// set the x and y coordinate and width and height of buttons in Portrait and LandScape
-(void)setPosition {
	if (viewMode) {
		if(x==411) {
			y+=height;
			x=0;
		} else {
			x+=width;
		}	
	} else {
		if(x==276) {
			y+=height;
			x=0;
		} else {
			x+=width;
		}	
	}
}

//create calender Portrait View 
-(void)DrawMonthInPortraitView {
	flag = [self isCurrentDate];
	today = [Mycal dateFromComponents:compA];
	compA = [Mycal components:(NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit) fromDate:today];
	
	weekDay = [compA weekday];
	month = [compA month];
	year = [compA year];
	DAY = [compA day];
	
	NSString* monthString = [_monthNames objectAtIndex:([compA month]-1)];
	NSString *yearString = [NSString stringWithFormat:@" %d",[compA year]];
	
	lblMonth.textAlignment =UITextAlignmentCenter; 
	lblMonth.text = [monthString stringByAppendingString:yearString];
	[self showMode];
}

// It show the view according to LandScape and Portrait
-(void)showMode {
	int i,day;
	year = [yearString intValue];
	if (viewMode) {
		[self removeView];
		x=(68.5*(weekDay-1)),y=38;
		width=68.5,height=38.2;
	}else {
		[self removeView];
		x=(46*(weekDay-1)),y=38;
		width=46,height=46;
	} if(month==1 || month==3 || month==5 || month==7 || month==8 || month==10 || month==12) {
		day = 31;
	} else if(month==4 || month==6 || month==9 || month==11) {
		day = 30;
	} else if(month==2) {
		if((year%4==0 && year%100!=0)||(year%400==0)) {
			day = 29;
		} else {
			day = 28;
		}
	}
	for(i=1;i<=day;i++) {
		if (flag && (currentDay == i) && (currentMonth == month) ) {
			buttonImage.image = [UIImage imageNamed:@"blue.png"];
			btnDay = [UIButton buttonWithType:UIButtonTypeCustom];
			btnDay.frame = CGRectMake(x,y,width,height);
			[btnDay addTarget:self action:@selector(BtnDayClicked:) forControlEvents:UIControlEventTouchUpInside];
			[btnDay setBackgroundImage:[UIImage imageNamed:@"blue.png"] forState:UIControlStateNormal];
			[btnDay setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
			[MainView addSubview:btnDay];
			[self setPosition];
		} else if(DAY == i && (currentMonth != month)) {
			buttonImage.image = [UIImage imageNamed:@"blue.png"];
			btnDay = [UIButton buttonWithType:UIButtonTypeCustom];
			btnDay.frame = CGRectMake(x,y,width,height);
			[btnDay addTarget:self action:@selector(BtnDayClicked:) forControlEvents:UIControlEventTouchUpInside];
			[btnDay setBackgroundImage:[UIImage imageNamed:@"blue.png"] forState:UIControlStateNormal];
			[btnDay setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
			[MainView addSubview:btnDay];
			[self setPosition];
		} else {
			buttonImage.image = [UIImage imageNamed:@"grya.png"];
			btnDay = [UIButton buttonWithType:UIButtonTypeCustom];
			btnDay.frame = CGRectMake(x,y,width,height);
			[btnDay addTarget:self action:@selector(BtnDayClicked:)forControlEvents:UIControlEventTouchUpInside];
			[btnDay setBackgroundImage:[UIImage imageNamed:@"grya.png"] forState:UIControlStateNormal];
			[btnDay setBackgroundImage:[UIImage imageNamed:@"blue.png"] forState:UIControlStateHighlighted];
			[btnDay setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
			[btnDay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
			[MainView addSubview:btnDay];
			[self setPosition];
		}
	}
}

-(void)BtnDayClicked:(id)sender {
	btnDay=sender;
	NSString *StrDate=[NSString stringWithFormat:@"%@ %@",[btnDay currentTitle],lblMonth.text];
	lblShowdatetime.text=StrDate;
}

-(void)showPortraitView {
	[btnPrevious setFrame:CGRectMake(2, 3,40,18)];
	[lblMonth setFrame:CGRectMake(73,3,180,21)];
	[btnNext setFrame:CGRectMake(275, 3, 37,18)];
	
	[MainView setFrame:CGRectMake(0,0,320,480)];
	
	[lblSun setFrame:CGRectMake(12,19, 20, 21)];
	[lblMon setFrame:CGRectMake(55, 19,21,21)];
	[lblTue setFrame:CGRectMake(98.6, 19,20,21)];
	[lblWed setFrame:CGRectMake(141.6, 19,22,21)];
	[lblThu setFrame:CGRectMake(192.6, 19,20,21)];
	[lblFri setFrame:CGRectMake(240.6,19,20,21)];
	[lblSat setFrame:CGRectMake(287.6, 19,20,21)];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

@end