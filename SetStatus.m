//
//  SetStatus.m
//  ChatApp
//
//  Created by Faizan on 02/09/12.
//  Copyright (c) 2012 ronak@itechcoders.com. All rights reserved.
//

#import "SetStatus.h"
#import "JSONParser.h"

@interface SetStatus ()

@end

@implementation SetStatus
@synthesize scrollview,txtstatus;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    txtstatus.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"tUserStatus"];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Button Action
- (IBAction)doneStatus:(id)sender {
    NSString *iUserID = [[NSUserDefaults standardUserDefaults] valueForKey:@"iUserID"];

    [indicator startAnimating];
    
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://184.172.168.130/~appstex/hourlyapp/webservice/updateprofile/?tUserStatus=%@&iUserID=%@",txtstatus.text,iUserID]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    JSONParser *parse = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(parsedd:) andHandler:self];
    NSLog(@"%@",parse.rq);
}

-(void)parsedd:(NSDictionary*)dic {
    [indicator stopAnimating];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Textview Delegates
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
	[scrollview setContentOffset:CGPointMake(0, textView.frame.origin.y - 50) animated:YES];
	return YES;
}

- (BOOL)textViewShouldReturn:(UITextField *)textView  {
	[scrollview setContentOffset:CGPointMake(0, -100) animated:YES];
	[textView resignFirstResponder];
	return YES;	
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [scrollview setContentOffset:CGPointMake(0, textView.frame.origin.y - 100 ) animated:YES];
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end