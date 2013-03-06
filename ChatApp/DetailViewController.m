//
//  DetailViewController.m
//  ChatApp
//
//  Created by Kartik Arora on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "JSONParser.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize txtUsername = _txtUsername;
@synthesize txtPassword = _txtPassword;

#pragma mark - Managing the detail item
- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        [self configureView];
    }
}

- (void)configureView {
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES]; 
    [self configureView];
}

- (void)viewDidUnload {
    [self setTxtUsername:nil];
    [self setTxtPassword:nil];
    indicator = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = NSLocalizedString(@"Login", @"Login");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    self.title = NSLocalizedString(@"", @"");
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
    self.title = NSLocalizedString(@"", @"");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Login", @"Login");
    }
    return self;
}
	
#pragma mark - textField Delegates
-(void)textFieldDidEndEditing:(UITextField *)textField  {
    [textField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)hidekeyboard {
    [_txtPassword resignFirstResponder];
    [_txtUsername resignFirstResponder];
}

#pragma mark - Button Action
- (IBAction)Login:(id)sender {
    if([_txtPassword.text isEqualToString:@""]||[_txtUsername.text isEqualToString:@""]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Chat App" message:@"Please enter all fields data" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        if(objListScreen) {
        
        } else {
            objListScreen=[[ListScreen alloc]initWithNibName:@"ListScreen" bundle:nil];
        }
            [self hidekeyboard];
            [indicator startAnimating];
        
            NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://184.172.168.130/~appstex/hourlyapp/webservice/login/?vEmail=%@&vPassword=%@",_txtUsername.text,_txtPassword.text]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
      
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
            JSONParser *parse = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(parsedd:) andHandler:self];
            NSLog(@"%@",parse.rq);
   }
}

-(void)parsedd:(NSDictionary*)dic {
    [indicator stopAnimating];
    NSLog(@"%@",[dic valueForKey:@"message"]);
    NSLog(@"%@",dic );
    
     if ([[[dic valueForKey:@"userDetails"]valueForKey:@"message"] isEqualToString:@"SUCCESS"]) {
        [[NSUserDefaults standardUserDefaults]setValue:_txtUsername.text forKey:@"userName"];
        [[NSUserDefaults standardUserDefaults]setValue:[[dic valueForKey:@"userDetails"]valueForKey:@"iUserID"] forKey:@"iUserID"];
         [[NSUserDefaults standardUserDefaults]setValue:[[dic valueForKey:@"userDetails"]valueForKey:@"tUserStatus"] forKey:@"tUserStatus"];
         [[NSUserDefaults standardUserDefaults]setValue:[[dic valueForKey:@"userDetails"]valueForKey:@"vAvatarThumb"] forKey:@"vAvatarThumb"];
         [[NSUserDefaults standardUserDefaults]setValue:[[dic valueForKey:@"userDetails"]valueForKey:@"vAvatar"] forKey:@"vAvatar"];
         
         NSLog(@"%@",[[dic valueForKey:@"userDetails"]valueForKey:@"vAvatarThumb"]);
         NSLog(@"%@",[[dic valueForKey:@"userDetails"]valueForKey:@"vAvatar"]);

         [[NSUserDefaults standardUserDefaults] setValue:[[dic valueForKey:@"userDetails"]valueForKey:@"iAge"] forKey:@"iAge"];
         [[NSUserDefaults standardUserDefaults] setValue:[[dic valueForKey:@"userDetails"]valueForKey:@"vUsername"] forKey:@"vUsername"];
         [[NSUserDefaults standardUserDefaults] setValue:[[dic valueForKey:@"userDetails"]valueForKey:@"tUserStatus"] forKey:@"tUserStatus"];
         [[NSUserDefaults standardUserDefaults] setValue:[[dic valueForKey:@"userDetails"]valueForKey:@"vEthnicityName"] forKey:@"vEthnicityName"];
         [[NSUserDefaults standardUserDefaults] setValue:[[dic valueForKey:@"userDetails"]valueForKey:@"vInterestedAge"] forKey:@"vInterestedAge"];
         NSLog(@"%@",[[dic valueForKey:@"userDetails"]valueForKey:@"vInterestedAge"]);
         
         [[NSUserDefaults standardUserDefaults] setFloat:[[[dic valueForKey:@"userDetails"]valueForKey:@"personality"]floatValue] forKey:@"personality"];
         [[NSUserDefaults standardUserDefaults] setFloat:[[[dic valueForKey:@"userDetails"]valueForKey:@"senseofhumor"]floatValue] forKey:@"senseofhumor"];
         [[NSUserDefaults standardUserDefaults] setFloat:[[[dic valueForKey:@"userDetails"]valueForKey:@"looks"]floatValue] forKey:@"looks"];
         [[NSUserDefaults standardUserDefaults] setFloat:[[[dic valueForKey:@"userDetails"]valueForKey:@"sexiness"]floatValue] forKey:@"sexiness"];
         [[NSUserDefaults standardUserDefaults] setFloat:[[[dic valueForKey:@"userDetails"]valueForKey:@"intelligence"]floatValue] forKey:@"intelligence"];
         [[NSUserDefaults standardUserDefaults] setFloat:[[[dic valueForKey:@"userDetails"]valueForKey:@"commoninterest"]floatValue] forKey:@"commoninterest"];

        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.navigationController pushViewController:objListScreen animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Check your Id and Password and try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        [alert show];
    }
}

- (IBAction)NewUSer:(id)sender {
    if(objNewUser) {
        
    } else{
        objNewUser=[[NewUser alloc]initWithNibName:@"NewUser" bundle:nil];
    }
    [self.navigationController pushViewController:objNewUser animated:YES];
}

@end