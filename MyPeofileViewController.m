//
//  MyPeofileViewController.m
//  ChatApp
//
//  Created by Faizan on 01/09/12.
//  Copyright (c) 2012 ronak@itechcoders.com. All rights reserved.
//

#import "MyPeofileViewController.h"
#import "JSONParser.h"

@interface MyPeofileViewController () {
    NSMutableArray *ehanicityArry;
    NSString *ehaniciytysr;
    NSString *interesetdAEStart;
    NSString *interesetdAEnd;
    NSString *checkIn;
    NSString *strpersonality;
    NSString *strsansofhumar;
    NSString *strlooks;
    NSString *strsexiness;
    NSString *strinteligence;
    NSString *strcommonitrest;
}

@end

@implementation MyPeofileViewController
@synthesize txtMyEthinicity;
@synthesize scrlProfile;
@synthesize pickerData;
@synthesize txtMingleID;
@synthesize txtName;
@synthesize txtInterestedAge;
@synthesize personality,sensofhumar,looks,sexiness,inteligence,commonIntrest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    segmentMale = [[NSString alloc]initWithFormat:@"Male"];
    
    [txtName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [txtAge setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    txtMingleID.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"userName"];
    txtAge.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"iAge"];
    txtName.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"vUsername"];
    lblEthnicity.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"vEthnicityName"];
   // lblStratRange.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"vInterestedAge"];
    
    NSString *strper = [[NSUserDefaults standardUserDefaults] valueForKey:@"personality"];
    personality.value = [strper floatValue];
    
    NSString *strsoh = [[NSUserDefaults standardUserDefaults] valueForKey:@"senseofhumor"];
    sensofhumar.value = [strsoh floatValue];
    
    NSString *strlk = [[NSUserDefaults standardUserDefaults] valueForKey:@"looks"];
    looks.value = [strlk floatValue];
    
    NSString *strsexines = [[NSUserDefaults standardUserDefaults] valueForKey:@"sexiness"];
    sexiness.value = [strsexines floatValue];
    
    NSString *strint = [[NSUserDefaults standardUserDefaults] valueForKey:@"intelligence"];
    inteligence.value = [strint floatValue];
    
    NSString *strcom = [[NSUserDefaults standardUserDefaults] valueForKey:@"commoninterest"];
    commonIntrest.value = [strcom floatValue];
    
    scrlProfile.contentSize=CGSizeMake(320, 600);
    
    arrData=[[NSMutableArray alloc]init];
    ehanicityArry=[[NSMutableArray alloc]init];
    
    ehaniciytysr = [[NSString alloc]initWithFormat:@"1" ];
    interesetdAEnd = [[NSString alloc]initWithFormat:@"25" ];
    interesetdAEStart = [[NSString alloc]initWithFormat:@"20" ];
    checkIn = [[NSString alloc]initWithFormat:@"Check-in" ];
    
    [self ehanicityList];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidUnload {
    [self setTxtMingleID:nil];
    [self setTxtName:nil];
    [self setTxtInterestedAge:nil];
    [self setTxtMyEthinicity:nil];
    [self setScrlProfile:nil];
    [self setPickerData:nil];
    toolBarPicker = nil;
    lblStratRange = nil;
    lblEndRange = nil;
    indicator = nil;
    segmentMaleFemale = nil;
    txtAge = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - picker view methods
- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView {
    if([strSelect isEqualToString:@"E"]) {
        return 1;
    } else {
        return 2;        
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if([strSelect isEqualToString:@"E"]) {
        return [ehanicityArry count];
    } else {
        return [arrData count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if([strSelect isEqualToString:@"E"]) {
        return [[ehanicityArry objectAtIndex:row]valueForKey:@"vEthnicityName"];
    } else {
        return [arrData objectAtIndex:row];
    }
} 

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if([strSelect isEqualToString:@"E"]) {
        lblEthnicity.text=[[ehanicityArry objectAtIndex:row] valueForKey:@"vEthnicityName"];
        ehaniciytysr=[[ehanicityArry objectAtIndex:row] valueForKey:@"iEthnicityID"];
    } else {
        if(component==0) {
            lblStratRange.text=[arrData objectAtIndex:row];
            interesetdAEStart =[arrData objectAtIndex:row];
        } else if(component==1) {
            lblEndRange.text=[arrData objectAtIndex:row];
            interesetdAEnd =[arrData objectAtIndex:row];
        } 
    }
}

#pragma mark - textfield delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if(textField==txtInterestedAge) {
        [textField resignFirstResponder];
        toolBarPicker.hidden=FALSE;
        pickerData.hidden=FALSE;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];    
}

#pragma mark - Button Action
- (IBAction)DonePicker:(id)sender {
    pickerData.hidden=TRUE;
    toolBarPicker.hidden=TRUE;
}

- (IBAction)showPicker:(id)sender {
    strSelect=@"A";
    arrData=[[NSMutableArray alloc]init];
    
    for (int i = 0 ; i<100; i++) {
        [arrData addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [pickerData reloadAllComponents];
    toolBarPicker.hidden=FALSE;
    pickerData.hidden=FALSE;
}

- (IBAction)showPickerEthencity:(id)sender {
    strSelect=@"E";
    [pickerData reloadAllComponents];
    toolBarPicker.hidden=FALSE;
    pickerData.hidden=FALSE;
}

-(IBAction)click:(UITextField*)sender {
    [sender resignFirstResponder];
}

-(IBAction)SetPersonality:(id)sender {
    strpersonality = [[NSString alloc] initWithFormat:@"%f",personality.value];
}

-(IBAction)SetSensofHumar:(id)sender {
    
    strsansofhumar = [[NSString alloc] initWithFormat:@"%f",sensofhumar.value];
} 

-(IBAction)SetLooks:(id)sender {
    strlooks = [[NSString alloc] initWithFormat:@"%f",looks.value];
} 

-(IBAction)SetSexiness:(id)sender {
    strsexiness = [[NSString alloc] initWithFormat:@"%f",sexiness.value];
} 

-(IBAction)SetInteligence:(id)sender {
    strinteligence = [[NSString alloc] initWithFormat:@"%f",inteligence.value];
} 

-(IBAction)SetCommonIntrest:(id)sender {
    strcommonitrest = [[NSString alloc] initWithFormat:@"%f",commonIntrest.value];
}

- (IBAction)segmentChange:(UISegmentedControl*)sender {
    segmentMale = segmentMaleFemale.selectedSegmentIndex==0?@"Male":@"Female";
}

- (IBAction)switching:(UISwitch*)sender {   
    checkIn = sender.isOn==TRUE?@"Check-in":@"Check-out";
}

- (IBAction)doneAvatar:(id)sender {
    [indicator startAnimating];
    
    NSString *iUserID = [[NSUserDefaults standardUserDefaults] valueForKey:@"iUserID"];
    NSString *tUserStatus = [[NSUserDefaults standardUserDefaults] valueForKey:@"tUserStatus"];
    
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://184.172.168.130/~appstex/hourlyapp/webservice/updateprofile/?vUsername=%@&vEmail=%@&tUserStatus=%@&eSex=%@&iAge=%@&iEthnicityID=%@&dLat=25&dLon=75&vInterestedAge=%@-%@&tInterestedEthnicity=5&eCheckStatus=%@&eTypingStatus=Hide&eChatHistoryStatus=No&personality=%@&senseofhumor=%@&looks=%@&sexiness=%@&intelligence=%@&commoninterest=%@&iUserID=%@",txtName.text,txtMingleID.text,tUserStatus,segmentMale,txtAge.text,ehaniciytysr,interesetdAEStart,interesetdAEnd,checkIn,strpersonality,strsansofhumar,strlooks,strsexiness,strinteligence,strcommonitrest,iUserID]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url ];
    
    JSONParser *parse = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(parsedd:) andHandler:self];
    NSLog(@"%@",parse.rq);
}

-(void)parsedd:(NSDictionary*)dic {
    [indicator stopAnimating];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)ehanicityList {
    [indicator startAnimating];
    
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://184.172.168.130/~appstex/hourlyapp/webservice/ethnicitylist/"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url ];
    
    JSONParser *parse = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(ehanicity:) andHandler:self];
    NSLog(@"%@",parse.rq);
}

-(void)ehanicity:(NSDictionary*)dic {
    [indicator stopAnimating];
    
    NSLog(@"%@",[dic valueForKey:@"ethnicitylist"]);
    strSelect=@"E";
    
    [ehanicityArry removeAllObjects];
    [ehanicityArry addObjectsFromArray:[dic valueForKey:@"ethnicitylist"]];
    [pickerData reloadAllComponents];
}

- (IBAction)SelectPhoto:(id)sender {
    UIActionSheet *actionsheet=[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Choose from Library",nil];
    [actionsheet showInView:self.view];
}

- (void) actionSheet:(UIActionSheet *)actionsheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	// After saving iamge, dismiss camera
	if (buttonIndex == 0) {
        if(UIImagePickerControllerSourceTypeCamera) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.editing=NO;
            [self presentModalViewController:imagePicker animated:YES];
        }	
	}        
	if(buttonIndex ==1) {
		UIImagePickerController *picker;
		picker = [[UIImagePickerController alloc]init];
		picker.delegate = self;
		picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		picker.editing=NO;
		[self presentModalViewController:picker animated:YES];
	}	
    [self dismissModalViewControllerAnimated:YES];	
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissModalViewControllerAnimated:YES];
   // [btnImage setImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"] forState:UIControlStateNormal];
}

@end