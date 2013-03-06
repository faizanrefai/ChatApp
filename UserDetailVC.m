//
//  UserDetailVC.m
//  ChatApp
//
//  Created by Faizan on 14/09/12.
//  Copyright (c) 2012 ronak@itechcoders.com. All rights reserved.
//

#import "UserDetailVC.h"
#import "JSONParser.h"
//#import "XMPPHandler.h"

@interface UserDetailVC ()

@end

@implementation UserDetailVC
@synthesize iUserID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [indicator startAnimating];
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://184.172.168.130/~appstex/hourlyapp/webservice/user/?iUserID=%@",iUserID]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url ];
    
    JSONParser *parse = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(parsedd:) andHandler:self];
    NSLog(@"%@",parse.rq);
}

-(void)parsedd:(NSDictionary*)dic {
    NSLog(@"Dic =%@",[[dic valueForKey:@"users"] objectAtIndex:0]);
    
    nameLabel.text = [[[dic valueForKey:@"users"] objectAtIndex:0] valueForKey:@"vUsername"];
    ageLable.text = [[[dic valueForKey:@"users"] objectAtIndex:0] valueForKey:@"iAge"];
    emailLabel.text = [[[dic valueForKey:@"users"] objectAtIndex:0] valueForKey:@"vEmail"];
    lastLoginLBEL.text = [[[dic valueForKey:@"users"] objectAtIndex:0] valueForKey:@"tLastLogin"];
    regTimeLaBEL.text = [[[dic valueForKey:@"users"] objectAtIndex:0] valueForKey:@"tRegisterTime"];
    statusLabel.text = [[[dic valueForKey:@"users"] objectAtIndex:0] valueForKey:@"eStatus"];
    ethanictyLabel.text = [[[dic valueForKey:@"users"] objectAtIndex:0] valueForKey:@"vEthnicityName"];
    imageVieww.image =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[[[dic valueForKey:@"users"] objectAtIndex:0]valueForKey:@"vAvatarThumb"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]] ;
    [indicator stopAnimating];
}

- (void)viewDidUnload {
    imageVieww = nil;
    nameLabel = nil;
    ageLable = nil;
    emailLabel = nil;
    lastLoginLBEL = nil;
    regTimeLaBEL = nil;
    statusLabel = nil;
    ethanictyLabel = nil;
    indicator = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Button Action
- (IBAction)chatNowClicked:(id)sender  {
//    chatViewController *objchat =[[chatViewController alloc]initWithNibName:@"chatViewController" bundle:[NSBundle mainBundle]];
//    [self.navigationController pushViewController:objchat animated:YES];
//    XMPPUserCoreDataStorageObject *user = [[self fetchedResultsController] objectAtIndexPath:indexPath];
//    
    chatViewController *ChatViewController = [[chatViewController alloc] init];
   // ChatViewController.user = user;
    [[self navigationController] pushViewController:ChatViewController animated:YES];


}

-(IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)abuseBtnClicked:(id)sender  {
    [indicator startAnimating];
    NSString *str = [[NSUserDefaults standardUserDefaults] valueForKey:@"iUserID"];
    
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://184.172.168.130/~appstex/hourlyapp/webservice/abuseuser/add/?iUserID=%@&iAbusedUserID=%@",str,iUserID]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url ];
    
    JSONParser *parse = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(abuse:) andHandler:self];
    NSLog(@"%@",parse.rq);
}

-(void)abuse:(NSDictionary*)dic {
    [indicator stopAnimating];
    NSLog(@"%@",dic);
    
    UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"Information" message:[dic valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [aler show];
}

- (IBAction)blockedClicked:(id)sender {
    [indicator startAnimating];
    NSString *str = [[NSUserDefaults standardUserDefaults] valueForKey:@"iUserID"];

    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://184.172.168.130/~appstex/hourlyapp/webservice/blockuser/add/?iUserID=%@&iBlockedUserID=%@",str,iUserID]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url ];
    
    JSONParser *parse = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(blocked:) andHandler:self];
    NSLog(@"%@",parse.rq);
}

-(void)blocked:(NSDictionary*)dic {
    [indicator stopAnimating];
    NSLog(@"%@",dic);
    UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"Information" message:[dic valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [aler show];
}

@end