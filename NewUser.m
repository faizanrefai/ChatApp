//
//  NewUser.m
//  ChatApp
//
//  Created by Kartik Arora on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewUser.h"
#import "JSONParser.h"

@implementation NewUser
@synthesize password;
@synthesize txtName;
@synthesize Gender;

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
    [self.navigationController setNavigationBarHidden:YES];
    self.title = NSLocalizedString(@"Registration", @"Registration");

    Mainarry = [[NSMutableArray alloc] init];
     self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(Back:)];
    strGender =[[NSString alloc]initWithFormat:@"Male"];
}

- (void)viewDidUnload {
    [self setTxtName:nil];
    [self setGender:nil];
    [self setPassword:nil];
    indicator = nil;
    [super viewDidUnload];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma  mark - textFields Delegate 
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

-(void)hidekeyboard {
    [txtName resignFirstResponder];
    [password resignFirstResponder];
}

#pragma mark - Button Action
- (IBAction)Condition:(UIButton*)sender {
    [self hidekeyboard];
    sender.selected =  sender.isSelected == TRUE?FALSE:TRUE;
}

- (IBAction)SegiClick:(UISegmentedControl*)sender {
    [self hidekeyboard];
   strGender= sender.selectedSegmentIndex==0?@"Male":@"Female";
}

-(IBAction)Back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)Register:(id)sender {
    NSString *msg;

    if ([txtName.text length]==0) {
        msg = @"Please enter all fields data";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Chat App" message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    } else if ([password.text length]==0) {
        msg = @"Please enter all fields data";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Chat App" message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    } else {
        if(objListScreen) {
            
        } else {
            objListScreen=[[ListScreen alloc]initWithNibName:@"ListScreen" bundle:nil];
        }
       
        [indicator startAnimating];
        NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://184.172.168.130/~appstex/hourlyapp/webservice/register/?vEmail=%@&vPassword=%@&vUsername=%@&eSex=%@&iAge=25&dLat=23.001288&dLon=72.00132",txtName.text,password.text,txtName.text,strGender]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
        JSONParser *parse = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(parsedd:) andHandler:self];
        NSLog(@"%@",parse.rq);
    }
}

-(void)parsedd:(NSDictionary*)dic {
    [indicator stopAnimating];
    NSLog(@"%@",dic);
    
    if ([[[dic valueForKey:@"userDetails"]valueForKey:@"message"] isEqualToString:@"iUserID"]) {
        [[NSUserDefaults standardUserDefaults]setValue:[[dic valueForKey:@"userDetails"]valueForKey:@"iUserID"] forKey:@"iUserID"];
        NSLog(@"%@",[[dic valueForKey:@"userDetails"]valueForKey:@"iUserID"]);

        [[NSUserDefaults standardUserDefaults]setValue:txtName.text forKey:@"userName"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.navigationController pushViewController:objListScreen animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Registration Error, ID already exist" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end