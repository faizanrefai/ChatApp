//
//  settingViewController.m
//  ChatApp
//
//  Created by Faizan on 01/09/12.
//  Copyright (c) 2012 ronak@itechcoders.com. All rights reserved.
//

#import "settingViewController.h"
#import "JSONParser.h"
#import "AppDelegate.h"

@interface settingViewController () {
    NSMutableArray *mainArry;
}

@end

@implementation settingViewController
@synthesize myTable,objCell;
@synthesize indicator;

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
    mainArry = [[NSMutableArray alloc]init];
 self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneAvatar:)];
    self.title=@"Setting";
    scrollview.contentSize=CGSizeMake(320, 520);
}

- (void)viewDidUnload {
    [self setIndicator:nil];
    [self setMyTable:nil];
    [super viewDidUnload];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [indicator startAnimating];
    NSString *iUserID = [[NSUserDefaults standardUserDefaults] valueForKey:@"iUserID"];
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://184.172.168.130/~appstex/hourlyapp/webservice/blockuser/?iUserID=%@",iUserID]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    JSONParser *parse = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(parsedd:) andHandler:self];
    NSLog(@"%@",parse.rq);
    
    [myTable reloadData];
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)parsedd:(NSDictionary*)dic {
    [indicator stopAnimating];
    
    NSLog(@"%@",[dic valueForKey:@"blockuserList"]);
    [mainArry removeAllObjects];
    [mainArry addObjectsFromArray:[dic valueForKey:@"blockuserList"]];
    [myTable reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Button Action
- (IBAction)buttonPressed:(UIButton*)sender {
    sender.selected =  sender.isSelected == TRUE?FALSE:TRUE;
}

- (IBAction)doneAvatar:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)remove:(id)sender {
    [indicator startAnimating];
    NSString *iUserID = [[NSUserDefaults standardUserDefaults] valueForKey:@"iUserID"];
    
    AppDelegate *objAppDel;
    objAppDel = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    UIButton *checkboxbtn = (UIButton*)sender;
    checkboxbtn.selected = !checkboxbtn.selected;
    NSIndexPath *indexPath = [self.myTable indexPathForCell:(UITableViewCell *)[[checkboxbtn superview]superview]];
    ipath = indexPath.row;
    objAppDel.strId = [NSString stringWithFormat:@"%d",indexPath.row];
    
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://184.172.168.130/~appstex/hourlyapp/webservice/blockuser/remove/?iUserID=%@&iBlockedUserID=%@",iUserID,[[mainArry objectAtIndex:indexPath.row]valueForKey:@"iUserID"]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    JSONParser *parse = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(parsed:) andHandler:self];
    NSLog(@"%@",parse.rq);
}

-(void)parsed:(NSDictionary*)dic {
    [indicator stopAnimating];
    [mainArry removeObjectAtIndex:ipath];
    [myTable reloadData];
}

- (IBAction)doneSetting:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return mainArry.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    CustomCellForList *cell = (CustomCellForList*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"CustomCellForSetting" owner:self options:nil];
        cell=objCell;
        objCell=nil;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell.lblDescription.text = [[mainArry objectAtIndex:indexPath.row] valueForKey:@"vUsername"];
    
    cell.imgUser.imageURL =[NSURL URLWithString:[[[mainArry objectAtIndex:indexPath.row] valueForKey:@"vAvatarThumb"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] ;

   [cell.btnremove addTarget:self action:@selector(remove:) forControlEvents:UIControlEventTouchUpInside];
    
    // Configure the cell.
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end