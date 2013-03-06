//
//  chatViewController.m
//  ChatApp
//
//  Created by Faizan on 01/09/12.
//  Copyright (c) 2012 ronak@itechcoders.com. All rights reserved.
//

#import "chatViewController.h"
#import "AppDelegate.h"
//#import "XMPPMessageOneToOneChat.h"
//#import "OneToOneChatViewCell.h"
//#import "XMPPHandler.h"

@interface chatViewController ()
- (void)keyboardDidShow;
- (void)keyboardDidHide;
@end

@implementation chatViewController
//@synthesize user = user_;
@synthesize field;
@synthesize tblChat;
@synthesize sendButton;
@synthesize inputTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window]; 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    messages=[[NSMutableArray alloc]initWithObjects:@"Demo1",@"Demo2",@"Demo3",@"Demo4",@"Demo5",@"Demo6",@"Demo7", nil];
    [self.view addSubview:viewOption];
   viewOption.frame=CGRectMake(0, 360,viewOption.frame.size.width,viewOption.frame.size.height);
    
//    [super viewDidLoad];
//    [self.tblChat setDelegate:self];
//    [self.tblChat setDataSource:self];
//   self.field.delegate = self;
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name: UIKeyboardDidShowNotification object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name: UIKeyboardDidHideNotification object:nil];
//    self.title = @"Chat";

}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Textfield Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    toolbar.frame=CGRectMake(toolbar.frame.origin.x, toolbar.frame.origin.y, toolbar.frame.size.width,toolbar.frame.size.height);

    NSLog(@"%@",toolbar);

        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];	
        
        CGRect rect = self.view.frame;
        rect.origin.y -= 180.0;
        rect.size.height += 180.0;
        self.view.frame = rect;
        viewOption.frame = CGRectMake(0, viewOption.frame.origin.y, viewOption.frame.size.width, viewOption.frame.size.height);
        toolbar.frame = CGRectMake(0, 320, 320, 44);
        
        [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    toolbar.frame=CGRectMake(toolbar.frame.origin.x, toolbar.frame.origin.y, toolbar.frame.size.width,toolbar.frame.size.height);
    NSLog(@"%@",toolbar);
    
	[textField resignFirstResponder];
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];	
    
    CGRect rect = self.view.frame;
    rect.origin.y += 180.0;
    rect.size.height -= 180.0;
    self.view.frame = rect;
    toolbar.frame = CGRectMake(0, tblChat.frame.origin.y + tblChat.frame.size.height, 320, 44);
    
	[UIView commitAnimations];
	return YES;
}

- (void)keyboardWillShow:(NSNotification *)notif {
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];	
    field.frame = CGRectMake(49, tblChat.frame.origin.y + 4 + tblChat.frame.size.height, field.frame.size.width, field.frame.size.height);
    
	CGRect rect = self.view.frame;
    rect.origin.y -= 180;
    rect.size.height += 180.0;
    self.view.frame = rect;
    
    [UIView commitAnimations];
	if([messages count] > 0) {
		NSUInteger index = [messages count] - 1;
		[tblChat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
	}
}

#pragma mark - Button Action
-(IBAction)VoiceChat:(id)sender {
    
}

-(IBAction)SendPic:(id)sender {
    
}

-(IBAction)BlockUser:(id)sender {
    
}

-(IBAction)Text:(id)sender {

}

-(IBAction)ReportAbuse:(id)sender {
    
}

-(IBAction)OpenOptions:(id)sender {
    if (viewOption.frame.origin.y==360) {
        viewOption.frame=CGRectMake(0, 240,viewOption.frame.size.width,viewOption.frame.size.height);
        toolbar.frame=CGRectMake(0, toolbar.frame.origin.y-120, toolbar.frame.size.width,toolbar.frame.size.height);
    }
    else {
        viewOption.frame=CGRectMake(0, 360,viewOption.frame.size.width,viewOption.frame.size.height);
        toolbar.frame=CGRectMake(0, toolbar.frame.origin.y+120, toolbar.frame.size.width,toolbar.frame.size.height);
    }
    CATransition *animation = [CATransition animation];
    [animation setDelegate:self];
    [animation setDuration:1];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionMoveIn];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [[viewOption layer] addAnimation:animation forKey:@"SetView3bkView"];     
}

-(IBAction)Send:(id)sender {
   [self hidekeyboard];
    
//    NSString *text = field.text;
//    if (text.length > 0) {
//        [[XMPPHandler sharedInstance] sendMessage:text to:user_.jidStr];
//    }
//    field.text = @"";

}

-(void)hidekeyboard {
    [field resignFirstResponder];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];	
    
    CGRect rect = self.view.frame;
    rect.origin.y += 180.0;
    rect.size.height -= 180.0;
    self.view.frame = rect;
    toolbar.frame = CGRectMake(0, tblChat.frame.origin.y + tblChat.frame.size.height, 320, 44);
    
	[UIView commitAnimations];
}

#pragma mark - Tableview 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
	
	UIImageView *balloonView;
    UIImageView *imagechoose;
	UILabel *label;
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		balloonView = [[UIImageView alloc] initWithFrame:CGRectZero];
		balloonView.tag = 1;
		
        imagechoose=[[UIImageView alloc]initWithFrame:CGRectZero];
        imagechoose.tag=3;
        
		label = [[UILabel alloc] initWithFrame:CGRectZero];
		label.backgroundColor = [UIColor clearColor];
		label.tag = 2;
		label.numberOfLines = 0;
		label.lineBreakMode = UILineBreakModeWordWrap;
		label.font = [UIFont systemFontOfSize:14.0];
		
		UIView *message = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, cell.frame.size.width, cell.frame.size.height)];
		message.tag = 0;
        
		[message addSubview:balloonView];
		[message addSubview:label];
		[message addSubview:imagechoose];
        
        [cell.contentView addSubview:message];
	} else {
		balloonView = (UIImageView *)[[cell.contentView viewWithTag:0] viewWithTag:1];
		label = (UILabel *)[[cell.contentView viewWithTag:0] viewWithTag:2];
        imagechoose=(UIImageView *)[[cell.contentView viewWithTag:0]viewWithTag:3];
	}
	NSString *text = [messages  objectAtIndex:indexPath.row];
    
	CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(240.0f, 480.0f) lineBreakMode:UILineBreakModeWordWrap];
	
	UIImage *balloon;
	
	if(indexPath.row%2==0) {
        balloonView.frame = CGRectMake(320.0f - (size.width + 28.0f), 2.0f, size.width + 28.0f, size.height + 15.0f);
        balloon = [[UIImage imageNamed:@"green1.png"] stretchableImageWithLeftCapWidth:24 topCapHeight:15];
        label.frame = CGRectMake(307.0f - (size.width + 5.0f), 8.0f, size.width + 5.0f, size.height);
    } else {
        balloonView.frame = CGRectMake(0.0, 2.0, size.width + 28, size.height + 15);
        balloon = [[UIImage imageNamed:@"grey.png"] stretchableImageWithLeftCapWidth:24 topCapHeight:15];
        label.frame = CGRectMake(16, 8, size.width + 5, size.height);
    }
	balloonView.image = balloon;
	label.text = text;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}


//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//	return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
//{
//	return [[fetchedResultsController fetchedObjects] count];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    XMPPMessageOneToOneChat *message = [fetchedResultsController objectAtIndexPath:indexPath];
//    return [OneToOneChatViewCell heightForCellWithText:message.body];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	static NSString *CellIdentifier = @"OneToOneChatCell";
//	
//	OneToOneChatViewCell *cell = (OneToOneChatViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//	if (cell == nil)
//	{
//		cell = [[OneToOneChatViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                           reuseIdentifier:CellIdentifier];
//	}
//	
//	XMPPMessageOneToOneChat *message = [fetchedResultsController objectAtIndexPath:indexPath];
//	cell.chatMessage = message;
//    
//	return cell;
//}

//- (NSFetchedResultsController *)fetchedResultsController {
//	if (fetchedResultsController == nil) {
//        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//		NSManagedObjectContext *moc = appDelegate.managedObjectContext;
//		
//		NSEntityDescription *entity = [NSEntityDescription entityForName:@"XMPPMessageOneToOneChat"
//		                                          inManagedObjectContext:moc];
//		
//		NSSortDescriptor *sd1=[[NSSortDescriptor alloc] initWithKey:@"localTimestamp" ascending:YES];		
//		NSArray *sortDescriptors = [NSArray arrayWithObjects:sd1, nil];
//		
//		NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//		[fetchRequest setEntity:entity];
//		[fetchRequest setSortDescriptors:sortDescriptors];
//		[fetchRequest setFetchBatchSize:10];
//		
//		fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:moc sectionNameKeyPath:nil cacheName:nil];
//		[fetchedResultsController setDelegate:self];
//		
//		NSError *error = nil;
//		if (![fetchedResultsController performFetch:&error]) {
//		}
//	}
//	return fetchedResultsController;
//}

//- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
//    [self.tblChat reloadData];
//    [self.tblChat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:([[[self fetchedResultsController] fetchedObjects] count] -1) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//}

@end