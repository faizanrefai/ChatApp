//
//  SetAvatar.m
//  ChatApp
//
//  Created by Faizan on 02/09/12.
//  Copyright (c) 2012 ronak@itechcoders.com. All rights reserved.
//

#import "SetAvatar.h"
#import "JSON.h"
#import "JSONParser.h"

@interface SetAvatar ()

@end

@implementation SetAvatar
@synthesize btnImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
   NSString *strimage = [[NSUserDefaults standardUserDefaults]valueForKey:@"vAvatar"];
   img = [[UIImageView alloc ]initWithFrame:CGRectMake(0, 0, 50, 44)];
    
    [btnImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:strimage]]] forState:UIControlStateNormal];
}

- (void)viewDidUnload {
    [self setBtnImage:nil];
    [indicator stopAnimating];               
    indicator = nil;
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
- (IBAction)doneAvatar:(id)sender {

    NSString *iUserID = [[NSUserDefaults standardUserDefaults] valueForKey:@"iUserID"];
        
    NSData *myData = UIImagePNGRepresentation([btnImage currentImage]);
            
    NSString *urlstring = [NSString stringWithFormat:@"http://184.172.168.130/~appstex/hourlyapp/webservice/userProfileImage/add/index.php?iUserID=%@",iUserID];
    [indicator startAnimating];

            NSURL *url = [NSURL URLWithString:[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            //===============================================        
            NSMutableURLRequest *postRequest = [[NSMutableURLRequest alloc] init];
            [postRequest setURL:url];
            [postRequest setHTTPMethod:@"POST"];
            
            NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
            [postRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
            
            NSMutableData  *body = [[NSMutableData alloc] init];
            [postRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
                //Image 1
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"vAvatar\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"vAvatar\"; filename=\"%@.png\"\r\n",iUserID]] dataUsingEncoding:NSUTF8StringEncoding]]; //img name
                [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                
                // Add Image
                [body appendData:[NSData dataWithData:myData]];
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
            [postRequest setHTTPBody:body];
            
            NSURLResponse *response;
            NSError *error = nil;
            NSData *data1 = [NSURLConnection sendSynchronousRequest:postRequest returningResponse:&response error:&error];
            NSString *result=[[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
            
            NSString *Msg=[NSString stringWithFormat:@"%@",[result JSONValue]];
  
    NSLog(@"%@",Msg);
    [indicator stopAnimating];
    result=nil;
    body=nil;
    [self.navigationController popViewControllerAnimated:YES];
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
    [btnImage setImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"] forState:UIControlStateNormal];
}

@end