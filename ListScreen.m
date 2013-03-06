//
//  ListScreen.m
//  ChatApp
//
//  Created by Kartik Arora on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListScreen.h"
#import "JSONParser.h"
#import "ProfileViewController.h"
#import "DropDownController.h"
#import "AddressBookDialogScreen.h"
#import "Annotation.h"

@interface ListScreen() {
    NSInteger ind;
    BOOL firstTime;
}

@end

@implementation AddressAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
@synthesize pinColor;

- (NSString *)subtitle {
	return subtitle;
}

- (NSString *)title {
	return title;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c {
	coordinate=c;
    return self;
}

@end

#import "UserDetailVC.h"

@implementation ListScreen
@synthesize tblData,objCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [tblData reloadData];
    arrayMain=[[NSMutableArray alloc]init];
    arrSec1=[[NSMutableArray alloc]init];
    arrSec2=[[NSMutableArray alloc]init];
    arrSec3=[[NSMutableArray alloc]init];
    arrSec4=[[NSMutableArray alloc]init];
    [self.navigationController setNavigationBarHidden:YES];
    
    btn1x.hidden = TRUE;
    btnoriginal.hidden = TRUE;
    imgzoom.hidden = TRUE;
    btnZoomIn.hidden = TRUE;
    btnZoomout.hidden = TRUE;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    latLabel.hidden =TRUE;
    longLabel.hidden = TRUE;

    profileView =[[ProfileViewController alloc]initWithNibName:@"ProfileViewController" bundle:[NSBundle mainBundle]];
    profileView.delegat=self;
    profileView.view.frame = CGRectMake(0,46, 320, 460);

    [self.view addSubview:profileView.view];
    profileView.view.hidden=TRUE;

     promoViewCon =[[PromoViewController alloc]initWithNibName:@"PromoViewController" bundle:[NSBundle mainBundle]];
    promoViewCon.view.frame = CGRectMake(0,46, 320, 460);
    [self.view addSubview:promoViewCon.view];
    promoViewCon.view.hidden=TRUE;
    
    chatViewCont =[[chatViewController alloc]initWithNibName:@"chatViewController" bundle:[NSBundle mainBundle]];
    chatViewCont.view.frame = CGRectMake(0,46, 320, 370);
    [self.view addSubview:chatViewCont.view];
    chatViewCont.view.hidden=TRUE;
    
    dropD = [[DropDownController alloc]initWithStyle:UITableViewStyleGrouped];
    dropD.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    dropD.delegation=self;
    dropD.view.frame = CGRectMake(10, 80, 300, 200);
    
    addDiaObj = [[AddressBookDialogScreen alloc]initWithNibName:@"AddressBookDialogScreen" bundle:nil];
    addDiaObj.delegation=self;
    addDiaObj.view.frame = CGRectMake(20, 50, 280, 300);
    firstTime =TRUE;

    [indicator startAnimating];
        NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://184.172.168.130/~appstex/hourlyapp/webservice/user/"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
        JSONParser *parse = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(parsedd:) andHandler:self];
        NSLog(@"%@",parse.rq);
}

-(void)parsedd:(NSDictionary*)dic {
    [indicator stopAnimating];
    [arrayMain removeAllObjects];
    [arrayMain addObjectsFromArray:[dic valueForKey:@"users"]];
    [tblData reloadData];
}

-(void)viewDidAppear:(BOOL)animated {
    if (firstTime) {
        firstTime=FALSE;
        [self.view addSubview:addDiaObj.view];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.7];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:NO];
        [UIView commitAnimations]; 
    }
}

- (void)viewDidUnload {
    [self setTblData:nil];
    dropDoenBtn = nil;
    indicator = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Button Action
- (IBAction)dropDownClicked:(id)sender {
    [self.view addSubview:dropD.view];
    dropD.view.frame = CGRectMake(0, 80, 320, 0);
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:dropD.view cache:YES];
    dropD.view.frame = CGRectMake(0, 80, 320, 200);
    [UIView commitAnimations];
}

-(void)selectRow:(NSString*)str {
    [dropDoenBtn setTitle:str forState:UIControlStateNormal];
    [dropD.view removeFromSuperview]; 
    if (str == @"By Proximity") {
        [indicator startAnimating];
        NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://184.172.168.130/~appstex/hourlyapp/webservice/Proximity/"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
        
        JSONParser *parse = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(parsedd:) andHandler:self];
        NSLog(@"%@",parse.rq);
    }else if(str == @"By Age") {
        [indicator startAnimating];
        NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://184.172.168.130/~appstex/hourlyapp/webservice/agelist/"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
        
        JSONParser *parse = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(parsedd:) andHandler:self];
        NSLog(@"%@",parse.rq);
    }else if(str == @"By Range"){
        [indicator startAnimating];
        NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://184.172.168.130/~appstex/hourlyapp/webservice/range/"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
        
        JSONParser *parse = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(parsedd:) andHandler:self];
        NSLog(@"%@",parse.rq);
    }else if(str == @"By Ethnicity") {
        [indicator startAnimating];
        NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://184.172.168.130/~appstex/hourlyapp/webservice/user/"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
        
        JSONParser *parse = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(parsedd:) andHandler:self];
        NSLog(@"%@",parse.rq);
    }

}

-(void)changeView:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 1: {
            mingkeView.view.hidden=TRUE;
            tblData.frame = CGRectMake(0,85, 320, 335);
            dropDoenBtn.hidden=FALSE;
            mapVi.hidden=TRUE;
            tblData.hidden=FALSE;
            [tblData reloadData];
            profileView.view.hidden=TRUE ;
            promoViewCon.view.hidden=TRUE;
            chatViewCont.view.hidden=TRUE;
            mapVi.hidden=TRUE;
            imgBottom.hidden=FALSE;
            btnlist.hidden=FALSE;
            btnmap.hidden=FALSE;
            imglist.hidden=FALSE;
            imgzoom.hidden = TRUE;
            btnZoomIn.hidden =TRUE;
            btnZoomout.hidden = TRUE;
            dropD.view.hidden = FALSE;
            btn1x.hidden = TRUE;
            btnoriginal.hidden = TRUE;
            break;
        }
        case 2: {
            profileView.view.hidden=FALSE ;
            dropDoenBtn.hidden=TRUE;
            tblData.frame = CGRectMake(0,46, 320, 370);
            mapVi.hidden=TRUE;
            tblData.hidden=TRUE;
            mingkeView.view.hidden=TRUE;
            promoViewCon.view.hidden=TRUE;
            chatViewCont.view.hidden=TRUE;
            imgBottom.hidden=TRUE;
            btnlist.hidden=TRUE;
            btnmap.hidden=TRUE;
            imglist.hidden=TRUE;
            dropD.view.hidden = TRUE;
            break;
        }
        case 3: {
            profileView.view.hidden=TRUE ;
            mapVi.hidden=TRUE;
            tblData.hidden=TRUE;
            mingkeView.view.hidden=TRUE;
            promoViewCon.view.hidden=TRUE;
            chatViewCont.view.hidden=FALSE;
            btn1x.hidden=TRUE;
            imgBottom.hidden=TRUE;
            btnlist.hidden=TRUE;
            btnmap.hidden=TRUE;
            imglist.hidden=TRUE;
            btnoriginal.hidden=TRUE;
            dropD.view.hidden = TRUE;
            break;
        }
        case 4: {
            profileView.view.hidden=TRUE ;
            mapVi.hidden=TRUE;
            tblData.hidden=TRUE;
            mingkeView.view.hidden=TRUE;
            promoViewCon.view.hidden=FALSE;
            chatViewCont.view.hidden=TRUE;
            btn1x.hidden=TRUE;
            imgBottom.hidden=TRUE;
            btnlist.hidden=TRUE;
            btnmap.hidden=TRUE;
            imglist.hidden=TRUE;
            btnoriginal.hidden=TRUE;
            dropD.view.hidden =TRUE;
            break;
        }
        default:
            break;
    }
}

- (IBAction)Mingle:(UIButton*)sender {
    [self changeView:sender.tag];
}

- (IBAction)Profile:(UIButton*)sender {
    [self changeView:sender.tag];
}

- (IBAction)Chat:(UIButton*)sender {
    [self changeView:sender.tag];
}

- (IBAction)Promo:(UIButton*)sender {
    [self changeView:sender.tag];
}

- (IBAction)List:(UIButton*)sender {
    tblData.hidden = FALSE;
    mapVi.hidden=TRUE;
    btn1x.hidden = TRUE;
    btnoriginal.hidden = TRUE;
    imgzoom.hidden = TRUE;
    btnZoomIn.hidden=TRUE;
    btnZoomout.hidden=TRUE;
    dropDoenBtn.hidden=FALSE;
    imglist.hidden = FALSE;
    dropD.view.hidden = FALSE;
    [self changeView:sender.tag];
}

- (IBAction)Map:(UIButton*)sender {
    mapVi.hidden = FALSE;
    [self changeView:sender.tag];
    tblData.hidden=TRUE;
    imgzoom.hidden=FALSE;
    btnZoomIn.hidden=FALSE;
    btnZoomout.hidden=FALSE;
 
    btnoriginal.hidden=FALSE;
    btn1x.hidden=FALSE;
    dropDoenBtn.hidden=TRUE;
    imglist.hidden=TRUE;
    dropD.view.hidden = TRUE;

    for(int i=0;i<[arrayMain count] ;i++) {
        [self showAddress:[[[arrayMain objectAtIndex:i] valueForKey:@"dLat"]floatValue] :[[[arrayMain objectAtIndex:i] valueForKey:@"dLon"]floatValue] :[[arrayMain objectAtIndex:i] valueForKey:@"vUsername"] :[[arrayMain objectAtIndex:i] valueForKey:@"vEmail"]];
    }

//    [self showAddress:21.092017190770522 :-99.2724609375 :@"Test 1" :@"Test 1"];
//    [self showAddress:21.046524553878555 :-99.0966796875 :@"Test 2" :@"Test 2"];
//    [self showAddress:20.925763032405868 :-99.13787841796875 :@"Test 3" :@"Test 3"];
//    [self showAddress:20.875728833365887 :-99.26834106445312 :@"Test 4" :@"Test 4"];
}

- (void)doneAvatar:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)Zoomin:(id)sender {
    MKCoordinateRegion region;
    MKCoordinateSpan span;  
    region.center=mapVi.region.center;
    span.latitudeDelta=mapVi.region.span.latitudeDelta /2.0002;
    span.longitudeDelta=mapVi.region.span.longitudeDelta /2.0002;
    region.span=span;
    [mapVi setRegion:region animated:TRUE];
}

-(IBAction)Zoomout:(id)sender {
    MKCoordinateRegion region;
    MKCoordinateSpan span;  
    region.center=mapVi.region.center;
    span.latitudeDelta=mapVi.region.span.latitudeDelta *1.5;
    span.longitudeDelta=mapVi.region.span.longitudeDelta *1.5;
    NSLog(@"%f",span.latitudeDelta);
    NSLog(@"%f",span.longitudeDelta);
    region.span=span;
    [mapVi setRegion:region animated:TRUE];
}

-(IBAction)ZoomIn1x:(id)sender {
    MKCoordinateRegion zoomIn = mapVi.region;
    zoomIn.span.latitudeDelta *= 0.5;
    zoomIn.span.longitudeDelta *= 0.5;
    [mapVi setRegion:zoomIn animated:YES];
    btn1x.userInteractionEnabled = FALSE;
    btnoriginal.userInteractionEnabled = TRUE;
}

-(IBAction)ZoomOut1x:(id)sender {
    btnoriginal.userInteractionEnabled=FALSE;
    btn1x.userInteractionEnabled=TRUE;
    MKCoordinateRegion zoomIn = mapVi.region;
    zoomIn.span.latitudeDelta /= 0.5;
    zoomIn.span.longitudeDelta /= 0.5;
    [mapVi setRegion:zoomIn animated:YES];
}

#pragma mark - Tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrayMain count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    CustomCellForList *cell = (CustomCellForList*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)     {
        [[NSBundle mainBundle] loadNibNamed:@"CustomCellForList" owner:self options:nil];
        cell=objCell;
        objCell=nil;	
        cell.lblName.textColor= [UIColor whiteColor];
        cell.lblDescription.textColor = [UIColor whiteColor];
        cell.lblTime.textColor = [UIColor whiteColor];
    }
    cell.lblName.text=[[arrayMain objectAtIndex:indexPath.row] valueForKey:@"vUsername"];
    cell.lblDescription.text=[[arrayMain objectAtIndex:indexPath.row] valueForKey:@"tUserStatus"];
    cell.lblTime.text=[[arrayMain objectAtIndex:indexPath.row] valueForKey:@"tLastLogin"];
    
    cell.imgUser.imageURL =[NSURL URLWithString:[[[arrayMain objectAtIndex:indexPath.row] valueForKey:@"vAvatarThumb"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] ;
   
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [dropD removeFromParentViewController];
    UserDetailVC *user = [[UserDetailVC alloc]initWithNibName:@"UserDetailVC" bundle:nil];
    user.iUserID =[[arrayMain objectAtIndex:indexPath.row] valueForKey:@"iUserID"];
    NSLog(@"%@",user.iUserID);
    [self.navigationController pushViewController:user animated:YES];
}

#pragma mark - Map View
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    NSLog(@"calloutAccessoryControlTapped  %@ ",control);
}

- (void)showAddress:(float)Lat:(float)Long:(NSString *)Name:(NSString *)Address {
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta=1;
	span.longitudeDelta=1;
	CLLocationCoordinate2D location;
    
    location.latitude =Lat;
    location.longitude =Long;
    
    region.span=span;
	region.center=location;
    addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:location];
    
    [addAnnotation setTitle:Name];
    [addAnnotation setSubtitle:Address];
    [addAnnotation setPinColor:MKPinAnnotationColorGreen];
    [mapVi addAnnotation:addAnnotation];
	[mapVi setRegion:region animated:TRUE];
    [mapVi setDelegate:self];
    NSLog(@"%@",Name);
    
	[mapVi regionThatFits:region];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(Annotation *)annotation {
    static NSString *identifier = @"identifier";
    
    MKPinAnnotationView *pinAnnotation = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
    
    pinAnnotation.canShowCallout = YES;
    return pinAnnotation;
}

@end