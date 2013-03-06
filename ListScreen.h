//
//  ListScreen.h
//  ChatApp
//
//  Created by Kartik Arora on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCellForList.h"
#import <MapKit/MapKit.h>
#import<CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import "ProfileViewController.h"
#import "DropDownController.h"
#import "PromoViewController.h"
#import "chatViewController.h"
#import "MingleViewController.h"
#import "AddressBookDialogScreen.h"
#import "MyCLController.h"

@interface AddressAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString *title;
    NSString *subtitle;
	MKPinAnnotationColor pinColor;
}
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;
@property (nonatomic, assign) MKPinAnnotationColor pinColor;
@end

@interface ListScreen : UIViewController<UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate> {
     IBOutlet UIActivityIndicatorView *indicator;
        
    NSMutableArray *arrayMain;
    NSMutableArray *dropDownArray;
    
    DropDownController *dropD;

    AddressBookDialogScreen *addDiaObj;
    
     IBOutlet UIButton *dropDoenBtn;

    NSMutableArray *arrSec1;
    NSMutableArray *arrSec2;
    NSMutableArray *arrSec3;
    NSMutableArray *arrSec4;
    
    ProfileViewController *profileView;
    MingleViewController *mingkeView;
    PromoViewController *promoViewCon;
    chatViewController *chatViewCont;
    
    IBOutlet MKMapView *mapVi;
    
    AddressAnnotation *addAnnotation;
    IBOutlet UIButton *btn1x;
    IBOutlet UIButton *btnZoomIn;
    IBOutlet UIButton *btnZoomout;
    IBOutlet UIImageView *imgzoom;
    IBOutlet UIButton *btnoriginal;
    IBOutlet UIImageView *imgBottom;
    IBOutlet UIButton *btnmap;
    IBOutlet UIButton *btnlist;
    IBOutlet UIImageView *imglist;
    
    MKReverseGeocoder *reverseGeocoder;
    MyCLController *locationController;
    CLLocationCoordinate2D coordinate;
    IBOutlet CLLocationManager *locationManager;
    IBOutlet UILabel *latLabel;
    IBOutlet UILabel *longLabel;

}

@property (strong, nonatomic) IBOutlet UITableView *tblData;
@property(nonatomic,retain)IBOutlet CustomCellForList *objCell;

- (IBAction)Mingle:(id)sender;
- (IBAction)Profile:(id)sender;
- (IBAction)Chat:(id)sender;
- (IBAction)Promo:(id)sender;
- (IBAction)List:(id)sender;
- (IBAction)Map:(id)sender;
- (void)showAddress:(float)Lat:(float)Long:(NSString *)Name:(NSString *)Address ;
-(IBAction)expand:(id)sender;
- (IBAction)dropDownClicked:(id)sender;
-(void)changeView:(NSInteger)buttonIndex;
-(IBAction)Zoomin:(id)sender;
-(IBAction)Zoomout:(id)sender;
-(IBAction)ZoomIn1x:(id)sender;
-(IBAction)ZoomOut1x:(id)sender;

@end