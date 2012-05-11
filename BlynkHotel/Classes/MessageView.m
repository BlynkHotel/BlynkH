    //
//  MessageView.m
//  Eye4
//
//  Created by iMac2 on 03/12/11.
//  Copyright 2011 Hemlines. All rights reserved.
//

#import "MessageView.h"
#import "BKAPIClient.h"
#import "EyeAppDelegate.h"
#import "HelpView.h"
#import "NSString+HTML.h"
#import "DSActivityView.h"
#import "CustomBadge.h"
#import "HomeView.h"
#import "proAlertView.h"

@implementation MessageView
@synthesize serviceId;

- (void)viewDidLoad
{
    [super viewDidLoad];
	//register for custombadge updated notification
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customBadgeUpdated) name:[NotificationNames notificationNameForCustomBadgeUpdate] object:nil];
//	//register for received guest details notification
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedGuestDetails) name:[NotificationNames notificationNameForGuestDetails] object:nil];
    appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    [backImageView setImage:[UIImage imageWithData:appDelegate.data]];
    [logoView setImage:[UIImage imageWithData:appDelegate.data1]];
    
//    [self displayLogout];
//    logOutBtn.hidden=YES;
//    loginBtn.hidden=NO;
//    helpBtn.hidden=YES;
//    messageBtn.enabled=NO;
    
//		[self receivedGuestDetails];
//    NSTimer *theTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dateAndtimeSetup) userInfo:nil repeats:YES];
    self.title = @"Notification";
}

-  (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    infoView.hidden = YES;
    [self loadInfoView];
    
    appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSTimer *theTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(changeBottomAdd) userInfo:nil repeats:YES];
    myTimer = theTimer;

	[appDelegate displayGuestDetail];
    
    self.navigationItem.backBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"Back"
                                      style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(backToHome)] autorelease];
    UIButton *messageBtn = (UIButton*)[self.navigationController.navigationBar viewWithTag:MESSAGE_BUTTON_TAG];
    if(messageBtn !=nil)
            messageBtn.enabled = FALSE;
//    [self setCustomBadge];
}


- (void)viewWillDisappear:(BOOL)animated{
    
    UIButton *messageBtn = (UIButton*) [self.navigationController.navigationBar viewWithTag:MESSAGE_BUTTON_TAG];
    if(messageBtn !=nil)
        messageBtn.enabled = TRUE;
    
    [appDelegate messageService];
    [myTimer invalidate];
}

- (void)changeBottomAdd {
    
    appDelegate = (EyeAppDelegate*)[[UIApplication sharedApplication]delegate];
    
   // NSLog([NSString stringWithFormat:@"%t",[appDelegate.adImageArray count]]);
    
    if ( t<[appDelegate.adImageArray count]) {
        
        NSURL *url = [NSURL URLWithString:[appDelegate.adImageArray objectAtIndex:t]];
		if (appDelegate.isNetworkAvailable)
        {
            AsyncDownloader *dataDownloader = [[AsyncDownloader alloc] initWithRequest:[NSURLRequest requestWithURL:url] delegate:self methodName:@"changeBottomAdd"  responseDataFormat:@"IMAGE"]; // nil == JSON by default
            [dataDownloader startDownloading];
            [dataDownloader release];
        }
        /*
        else 
        {
            [appDelegate showNetworkUnavailableError];
        }
        */
    }
}

#pragma mark -
#pragma mark AsyncDownloading Methods
-(void)didFinishDownloadingAsyncDownloader:(NSMutableData *)receivedData ForMethod:(NSString *)methodName
{
	if([methodName isEqualToString:@"changeBottomAdd"])
	{
		if(receivedData != nil)
		{
			[addImage setImage:[UIImage imageWithData:receivedData]];
			firstText.text = [appDelegate.firstTextArray objectAtIndex:t];
			secondText.text = [appDelegate.secondTextArray objectAtIndex:t];
			t++;
		}
		if (t==[appDelegate.adImageArray1 count]) {
			
			t=0;
		} 
	}
}

-(void)didFailAsyncDownloaderWithError:(NSError *)error ForMethod:(NSString *)methodName
{
	//Process for displayAddImage
	if([methodName isEqualToString:@"changeBottomAdd"])
	{
                [appDelegate showTimeOutAlert];
		NSLog(@"didFailAsyncDownloaderWithError- Request Failed for Method = %@",methodName);
	}
	
}

#pragma mark -
#pragma mark Other Methods
/*
-(void)dateAndtimeSetup{
    
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"hh:mm a"];
    
    NSDate *now = [[NSDate alloc] init];
    NSString *theTime = [timeFormat stringFromDate:now];
    
    lblTime.text = theTime;
    [timeFormat release];
    [now release];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"dd-MMM-yyy"];
    // date = [formatter dateFromString:@"Apr 7, 2011"];
    // NSLog(@"%@", [formatter stringFromDate:date]);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:date];
    NSInteger year = [components year];
  //  NSInteger month=[components month];       // if necessary
    NSInteger day = [components day];
   // NSInteger weekday = [components weekday]; // if necessary
    
    NSDateFormatter *weekDay = [[[NSDateFormatter alloc] init] autorelease];
    [weekDay setDateFormat:@"EEE"];
    
    NSDateFormatter *calMonth = [[[NSDateFormatter alloc] init] autorelease];
    [calMonth setDateFormat:@"MMM"];
    
    NSLog(@"%@ %i %@ %i", [weekDay stringFromDate:date], day, [calMonth stringFromDate:date], year );
    
    lblDate.text = [NSString stringWithFormat:@"%@ %02i %@ %i",[weekDay stringFromDate:date], day, [calMonth stringFromDate:date], year];
    
}

- (IBAction)loginView:(id)sender{
    
    [self displayLoginView];
}

- (void)displayLoginView{
    
    loginView = [[UIView alloc]initWithFrame:CGRectMake(294,56,713,702)];
    
    UIImageView *backImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,loginView.frame.size.width,loginView.frame.size.height)];
    loginView.backgroundColor = [UIColor clearColor];
    [backImage setImage:[UIImage imageNamed:@"commonpopup.png"]];
    [loginView addSubview:backImage];
    
    txtloginId = [[UITextField alloc] initWithFrame:CGRectMake(207,73,300,47)];
    txtloginId.placeholder = @"Enter Guest ID";
    txtloginId.font = [UIFont boldSystemFontOfSize:25];
    txtloginId.borderStyle = UITextBorderStyleBezel;
    txtloginId.background = [UIImage imageNamed:@"logintext.png"];
    txtloginId.textColor = [UIColor blackColor];
    txtloginId.returnKeyType = UIReturnKeyGo;
    txtloginId.textAlignment = UITextAlignmentCenter;
    txtloginId.autocorrectionType = UITextAutocorrectionTypeNo;
    txtloginId.delegate = self;
    txtloginId.keyboardType=UIKeyboardTypeNumberPad;
    [txtloginId becomeFirstResponder];
    [txtloginId addTarget:self action:@selector(LoginBtnAction) forControlEvents:UIControlEventEditingDidEndOnExit];
    [loginView addSubview:txtloginId];
    
    UILabel *loadingMessage = [[UILabel alloc] initWithFrame:CGRectMake(80,264,550,21)];
	loadingMessage.font = [UIFont boldSystemFontOfSize:20];
	loadingMessage.textAlignment = UITextAlignmentCenter;
	loadingMessage.text = @"Guest ID will be provided by Hotel at the time of Check-In";
	loadingMessage.textColor = [UIColor whiteColor];
	loadingMessage.backgroundColor = [UIColor clearColor];
	[loginView addSubview:loadingMessage];

    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn addTarget:self action:@selector(removeLoginView:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame = CGRectMake(680,0,33, 36);
    closeBtn.backgroundColor = [UIColor clearColor];
    [loginView addSubview:closeBtn];
    [self.view addSubview:loginView];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	
	NSString *resultingString = [textField.text stringByReplacingCharactersInRange: range withString: string];
	
	// The user deleting all input is perfectly acceptable.
	if ([resultingString length] == 0) {
		return true;
	}
	
	NSInteger holder;
	
	NSScanner *scan = [NSScanner scannerWithString: resultingString];
	
	return [scan scanInteger: &holder] && [scan isAtEnd];
}

- (IBAction)removeLoginView:(id)sender{
    
    [self displayGuestDetail];
    [loginView removeFromSuperview];
}

- (IBAction)LoginBtnAction {
    
    // txtloginId.text = source.text;
    appDelegate.appLoginId = txtloginId.text;
    appDelegate.isGuest = YES;
	
    [appDelegate doLogin]; //call displayLoginDetails synchronously
	//[self displayGuestDetail]; //instead of this called doLogin
    
	if ([txtloginId.text length] == 0) {
		
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Enter Guest ID" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
        
	}
    else if ([appDelegate.guestNameArray count] == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter correct Guest ID" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
        
    }
    else{
        
        [DSBezelActivityView newActivityViewForView:self.view];
        [self performSelector:@selector(stopActivityIndicator) withObject:nil afterDelay:2];
	}
}
*/
-(void)stopActivityIndicator{
    
//    appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
//    appDelegate.appLoginId = txtloginId.text;
//    appDelegate.isGuest = YES;
//    [self displayGuestDetail];
//    [self setCustomBadge];
//    [loginView removeFromSuperview];
    HomeView *aHomeView=[[HomeView alloc]initWithNibName:@"HomeView" bundle:nil];
    [appDelegate.navigationController pushViewController: aHomeView animated: YES];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDelegate stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}

-(void)stopAct
{
    EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate]; 
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [appDel stopStandardActivityLoadingView];
    [pool release];
}

- (IBAction)backToHome{
    
	[self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)displayHelpView{
    
    HelpView *aHelpView = [[HelpView alloc]initWithNibName:@"HelpView" bundle:nil];
    aHelpView.view.frame = CGRectMake(297,57,713,608);
	[self.view addSubview:aHelpView.view];  
    [aHelpView release];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
	return [appDelegate.messageArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
//		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
         cell =[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
	}
    
    UIImageView *cimageView = [[UIImageView alloc] init];
    UIImage *cimage = [UIImage imageNamed:@"cell_bg.png"];
    cimageView.image = cimage;
    cimageView.opaque = YES;
    cell.backgroundView = cimageView;
    [cimageView release]; 
    aTableView.separatorColor = [UIColor grayColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    NSString *cellValue = [appDelegate.messageArray objectAtIndex:indexPath.row];
    NSString *mgsStatus = [appDelegate.readUnreadArray objectAtIndex:indexPath.row];
   
    if ([mgsStatus isEqualToString:@"u"]) {
        
        cell.textLabel.text = cellValue;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
                    
    }else{
        
        cell.textLabel.text = cellValue;
        cell.textLabel.textColor = [UIColor whiteColor];
        [cell.textLabel setFont:normal];
        cell.textLabel.font = [UIFont fontWithName:@"" size:20];
    }   
    
	return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {  
    return 54;  
} 

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    infoView.hidden = NO;
    
    if (appDelegate.isGuest == YES && appDelegate.isActive == YES && [appDelegate.messageArray count]>0)  {
      
    //lblTitle.text = [NSString stringWithFormat:@"From:%@",[appDelegate.messageArray objectAtIndex:indexPath.row]];
        lblTitle.text = [NSString stringWithFormat:[appDelegate.messageArray objectAtIndex:indexPath.row]];
	NSString *selectedVideo = [appDelegate.detailArray objectAtIndex:indexPath.row];	
    
    lblRequestTime.text = [NSString stringWithFormat:@"Requested Time: %@",[appDelegate.rTimeArray objectAtIndex:indexPath.row]];
    lblCompletedTime.text = [NSString stringWithFormat:@"Completed Time: %@",[appDelegate.cTimeArray objectAtIndex:indexPath.row]];
        
    NSString *status = [appDelegate.statusArray objectAtIndex:indexPath.row];
        
    if ([status isEqualToString:@"Yes"]) {
            
            [statusBtn setImage:[UIImage imageNamed:@"green.png"] forState:UIControlStateNormal];
            
    }else{
            [statusBtn setImage:[UIImage imageNamed:@"red.png"] forState:UIControlStateNormal];  
    }
             
	NSString *embedHTML = @"\
	<html><head>\
	<meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 212\"/>\
	<style type=\"text/css\">\
	body {\
	font-family: \"arial\"; font-size:18; background-color: transparent;\
	color: black;\
	}\
	</style>\
	</head><body style=\"margin:0\">%@ </body></html>";
	html = [NSString stringWithFormat:embedHTML, selectedVideo];
	//NSLog([NSString stringWithFormat:@"",html]);
	[aWebView loadHTMLString:html baseURL:nil];
        
    NSString *mgsStatus = [appDelegate.readUnreadArray objectAtIndex:indexPath.row];
    NSString *tID = [appDelegate.tIdArray objectAtIndex:indexPath.row];
    
        if ([mgsStatus isEqualToString:@"u"]) {
            
            //NSMutableDictionary *response = 
            [BKAPIClient changeMessageStatus:tID];
        //    NSLog([NSString stringWithFormat:@"%@",response]);
//            NSString *message = [response valueForKey:@"message"];   
        //    NSLog([NSString stringWithFormat:@"%@",message]);
            
            [appDelegate.unreadArray removeLastObject];
            appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate setCustomBadge];
            [aTableView reloadData];
            
        }    
        
    }else{
        
       // lblTitle.text = [NSString stringWithFormat:@"From:%@",[appDelegate.messageArray objectAtIndex:indexPath.row]];
        lblTitle.text = [NSString stringWithFormat:[appDelegate.messageArray objectAtIndex:indexPath.row]];
        NSString *selectedVideo = [appDelegate.detailArray objectAtIndex:indexPath.row];	
      
        NSString *embedHTML = @"\
        <html><head>\
        <meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 212\"/>\
        <style type=\"text/css\">\
        body {\
        font-family: \"arial\"; font-size:18; background-color: transparent;\
        color: black;\
        }\
        </style>\
        </head><body style=\"margin:0\">%@ </body></html>";
        html = [NSString stringWithFormat:embedHTML, selectedVideo];
      //  NSLog([NSString stringWithFormat:@"",html]);
        [aWebView loadHTMLString:html baseURL:nil];
        
    }
    
    
}

- (void)loadInfoView{
    
     infoView.hidden = NO;
    
    if (appDelegate.isGuest == YES && appDelegate.isActive == YES && [appDelegate.messageArray count]>0)  {
        
        //lblTitle.text = [NSString stringWithFormat:@"From:%@",[appDelegate.messageArray objectAtIndex:0]];
        lblTitle.text = [NSString stringWithFormat:[appDelegate.messageArray objectAtIndex:0]];

        NSString *selectedVideo = [appDelegate.detailArray objectAtIndex:0];	
        
        lblRequestTime.text = [NSString stringWithFormat:@"Requested Time: %@",[appDelegate.rTimeArray objectAtIndex:0]];
        lblCompletedTime.text = [NSString stringWithFormat:@"Completed Time: %@",[appDelegate.cTimeArray objectAtIndex:0]];
        
        NSString *status = [appDelegate.statusArray objectAtIndex:0];
        
        if ([status isEqualToString:@"Yes"]) {
            
            [statusBtn setImage:[UIImage imageNamed:@"green.png"] forState:UIControlStateNormal];
            
        }else{
            [statusBtn setImage:[UIImage imageNamed:@"red.png"] forState:UIControlStateNormal];  
        }
        
        NSString *embedHTML = @"\
        <html><head>\
        <meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 212\"/>\
        <style type=\"text/css\">\
        body {\
        font-family: \"arial\"; font-size:18; background-color: transparent;\
        color: black;\
        }\
        </style>\
        </head><body style=\"margin:0\">%@ </body></html>";
        html = [NSString stringWithFormat:embedHTML, selectedVideo];
    //    NSLog([NSString stringWithFormat:@"",html]);
        [aWebView loadHTMLString:html baseURL:nil];
        
        NSString *mgsStatus = [appDelegate.readUnreadArray objectAtIndex:0];
        NSString *tID = [appDelegate.tIdArray objectAtIndex:0];
        
        
        if ([mgsStatus isEqualToString:@"u"]) {
            
            //NSMutableDictionary *response = 
            [BKAPIClient changeMessageStatus:tID];
      //      NSLog([NSString stringWithFormat:@"%@",response]);
//            NSString *message = [response valueForKey:@"message"];   
      //      NSLog([NSString stringWithFormat:@"%@",message]);
            
            [appDelegate.unreadArray removeLastObject];
            appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate messageService];
            [aTableView reloadData];
            
        }    
        
    }else{
        
        if([appDelegate.messageArray count]>0){
        
        //lblTitle.text = [NSString stringWithFormat:@"From:%@",[appDelegate.messageArray objectAtIndex:0]];
            lblTitle.text = [NSString stringWithFormat:[appDelegate.messageArray objectAtIndex:0]];
            
        NSString *selectedVideo = [appDelegate.detailArray objectAtIndex:0];	
        
        NSString *embedHTML = @"\
        <html><head>\
        <meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 212\"/>\
        <style type=\"text/css\">\
        body {\
        font-family: \"arial\"; font-size:18; background-color: transparent;\
        color: black;\
        }\
        </style>\
        </head><body style=\"margin:0\">%@ </body></html>";
        html = [NSString stringWithFormat:embedHTML, selectedVideo];
     //   NSLog([NSString stringWithFormat:@"",html]);
        [aWebView loadHTMLString:html baseURL:nil];
            
        }
        
    }
    
}

-(IBAction)removeMenuView:(id)sender{
    
    infoView.hidden = YES;
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	//remove from notification
	[[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)dealloc {
	
	//remove from notification
	[[NSNotificationCenter defaultCenter] removeObserver:self];

	[menuId release];
    [myTimer release];
    [serviceId release];
//    [txtloginId release];
//    [loginView release];
//    [logOutBtn release];
//    [weatherView release];
      
	[super dealloc];

    
}

@end
