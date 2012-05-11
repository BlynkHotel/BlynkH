//
//  DisplayView.m
//  Eye4
//
//  Created by Blynk Systems on 13/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DisplayView.h"
#import "BKAPIClient.h"
#import "MessageView.h"
#import "EyeAppDelegate.h"
#import "CustomCell.h"
#import "HelpView.h"
#import "NSString+HTML.h"
#import "DSActivityView.h"
#import "Template1.h"
#import "Template2.h"
#import "Template3.h"
#import "Template4.h"
#import "Template5.h"
#import "Template6.h"
#import "CustomBadge.h"
#import "proAlertView.h"

@implementation DisplayView

@synthesize serviceId,nameArray,detailArray,menuImageArray,videoArray,templateArray,webLinkArray,amenityArray;


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    //register for custombadge updated notification
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customBadgeUpdated) name:[NotificationNames notificationNameForCustomBadgeUpdate] object:nil];
	//register for received guest details notification
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedGuestDetails) name:[NotificationNames notificationNameForGuestDetails] object:nil];
	*/
    appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    [backImageView setImage:[UIImage imageWithData:appDelegate.data]];
    [logoView setImage:[UIImage imageWithData:appDelegate.data1]];
    
    helpBtn.hidden=YES;

//	[self receivedGuestDetails];
	
//    NSTimer *theTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dateAndtimeSetup) userInfo:nil repeats:YES];
}
-  (void)viewWillAppear:(BOOL)animated 
{
    
    [super viewWillAppear:animated];
    appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
     
//    [self setCustomBadge];
	[appDelegate displayGuestDetail];
    
	NSMutableDictionary *response1 = [BKAPIClient hotelInfoAboutUs:serviceId];
    self.amenityArray = [response1 valueForKey:@"amenities_id"];
    self.nameArray = [response1 valueForKey:@"amenities_name"];
    self.detailArray = [response1 valueForKey:@"description"];
	self.menuImageArray = [response1 valueForKey:@"image"];
	self.videoArray = [response1 valueForKey:@"video"];
    self.templateArray = [response1 valueForKey:@"template_type"];
    self.webLinkArray = [response1 valueForKey:@"link"];
    
    [aTableView reloadData];
    
    NSTimer *theTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(changeBottomAdd) userInfo:nil repeats:YES];
    myTimer = theTimer;
    
    self.navigationItem.backBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"Back"
                                      style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(backToHome)] autorelease];

}

#pragma mark -
#pragma mark Received Notifications
/*
-(void)receivedGuestDetails
{
	NSLog(@"received notification: receivedGuestDetails");
	if ([appDelegate.guestNameArray count]>0) {
        
        lblGuestName.text = [appDelegate.guestNameArray objectAtIndex:0]; 
        lblGuestId.text = [appDelegate.guestIdArray objectAtIndex:0]; 
        logOutBtn.hidden = NO;
	}else{
		
		loginBtn.enabled=YES;
		logOutBtn.hidden = YES;
		lblGuestName.text =@"Welcome, Guest"; 
		lblGuestId.text =@"";
	}
}

-(void)customBadgeUpdated
{
	NSLog(@"received notification: customBadgeUpdated");
	customBadge1.hidden = YES;			
	if ([appDelegate.unreadArray count] > 0) 
	{
        
		customBadge1 = [CustomBadge customBadgeWithString:
						[NSString stringWithFormat:@"%d",[appDelegate.unreadArray count]] 
										  withStringColor:[UIColor whiteColor] 
										   withInsetColor:[UIColor redColor] 
										   withBadgeFrame:YES 
									  withBadgeFrameColor:[UIColor whiteColor] 
												withScale:1.0
											  withShining:YES];
		[customBadge1 setFrame:CGRectMake(940,0, customBadge1.frame.size.width, customBadge1.frame.size.height)];
		[self.view addSubview:customBadge1];
	}
}
*/
#pragma mark -
#pragma mark Other Methods
//
//- (void)setCustomBadge{
//    
//    if (appDelegate.isGuest == YES && appDelegate.isActive == YES) {
//    
//    appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
//    [appDelegate messageService];
//		//moved to customBadgeUpdate
//		/*
//    
//    if ([appDelegate.unreadArray count] > 0) {
//        
//    customBadge1 = [CustomBadge customBadgeWithString:
//                                 [NSString stringWithFormat:@"%d",[appDelegate.unreadArray count]] 
//												   withStringColor:[UIColor whiteColor] 
//													withInsetColor:[UIColor redColor] 
//													withBadgeFrame:YES 
//											   withBadgeFrameColor:[UIColor whiteColor] 
//														 withScale:1.0
//													   withShining:YES];
//	
//    [customBadge1 setFrame:CGRectMake(940,0, customBadge1.frame.size.width, customBadge1.frame.size.height)];
//    [self.view addSubview:customBadge1];
//       */         
//    }else{
//         customBadge1.hidden=YES;
//    }
//}


- (void)viewWillDisappear:(BOOL)animated{
    
    [aTemplate1.view  removeFromSuperview];
    [aTemplate2.view  removeFromSuperview];
    [aTemplate3.view  removeFromSuperview];
    [aTemplate4.view  removeFromSuperview];
    [aTemplate5.view  removeFromSuperview];
    [aTemplate6.view  removeFromSuperview];
    
    [myTimer invalidate];
    
}

- (void)changeBottomAdd {
    
    appDelegate = (EyeAppDelegate*)[[UIApplication sharedApplication]delegate];
    
  //  NSLog([NSString stringWithFormat:@"%t",[appDelegate.adImageArray count]]);
    
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
		/*
        NSData *data = [NSData dataWithContentsOfURL:url];  
        [addImage setImage:[UIImage imageWithData:data]];
        firstText.text = [appDelegate.firstTextArray objectAtIndex:t];
        secondText.text = [appDelegate.secondTextArray objectAtIndex:t];
        t++;
		*/
    }
	/*
    if (t==[appDelegate.adImageArray count]) {
        
        t=0;
    } 
	*/
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
-(void)dateAndtimeSetup
{
    
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
*/

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
    //return [treeNode descendantCount];
	return [nameArray count];
    
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
	
	NSString *cellValue = [nameArray objectAtIndex:indexPath.row];
    [cell.textLabel setFont:normal];
	cell.textLabel.text = cellValue;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
	
	
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [aTemplate1.view  removeFromSuperview];
    [aTemplate2.view  removeFromSuperview];
    [aTemplate3.view  removeFromSuperview];
    [aTemplate4.view  removeFromSuperview];
    [aTemplate5.view  removeFromSuperview];
    [aTemplate6.view  removeFromSuperview];

    int tempType = [[templateArray objectAtIndex:indexPath.row] intValue];
    
    if (tempType==1) 
    {
        
        aTemplate1 =[[Template1 alloc] initWithNibName:@"Template1" bundle:nil];
        aTemplate1.view.frame = CGRectMake(300,60,707,600);
//        aTemplate1.title1 = [nameArray objectAtIndex:indexPath.row];
//        aTemplate1.textDetail = [detailArray objectAtIndex:indexPath.row];
        [self.view addSubview:aTemplate1.view]; 
        [aTemplate1 setLabelText:[nameArray objectAtIndex:indexPath.row]];
        [aTemplate1 setTextViewText:[detailArray objectAtIndex:indexPath.row]];
       
        
    }else if (tempType==2){
        
        aTemplate2 =[[Template2 alloc] initWithNibName:@"Template2" bundle:nil]; 
        aTemplate2.view.frame = CGRectMake(300,60,707,600);
//        aTemplate2.title1 = [nameArray objectAtIndex:indexPath.row];
//        aTemplate2.weblink = [videoArray objectAtIndex:indexPath.row];
        [aTemplate2 setLabelTxt:[nameArray objectAtIndex:indexPath.row]];
        [aTemplate2 loadWebViewWith:[videoArray objectAtIndex:indexPath.row]];
        [self.view addSubview:aTemplate2.view];  

    }else if (tempType==3){
       
        aTemplate3 =[[Template3 alloc] initWithNibName:@"Template3" bundle:nil]; 
        aTemplate3.view.frame = CGRectMake(300,60,707,600);
//        aTemplate3.title1 = [nameArray objectAtIndex:indexPath.row];
//        aTemplate3.weblink = [webLinkArray objectAtIndex:indexPath.row];
        [aTemplate3 setLabelTxt:[nameArray objectAtIndex:indexPath.row]];
        [aTemplate3 loadWebViewWith:[webLinkArray objectAtIndex:indexPath.row]];
        [self.view addSubview:aTemplate3.view]; 

    }else if (tempType==4){
            
        aTemplate4 =[[Template4 alloc] initWithNibName:@"Template4" bundle:nil]; 
        aTemplate4.view.frame = CGRectMake(300,60,707,600);
      //  NSLog([NSString stringWithFormat:@"%@",[amenityArray objectAtIndex:indexPath.row]]);
//        aTemplate4.title1 = [nameArray objectAtIndex:indexPath.row];
//        aTemplate4.amentyId = [amenityArray objectAtIndex:indexPath.row];
        [aTemplate4 setLabelText:[nameArray objectAtIndex:indexPath.row]];
        [aTemplate4 loadImageWithAmentyId:[amenityArray objectAtIndex:indexPath.row]];
        [self.view addSubview:aTemplate4.view]; 
    }else if (tempType==5)
    {
        aTemplate5 =[[Template5 alloc] initWithNibName:@"Template5" bundle:nil]; 
        aTemplate5.view.frame = CGRectMake(300,60,707,600);
//        aTemplate5.title1 = [nameArray objectAtIndex:indexPath.row];
//        aTemplate5.textDetail = [detailArray objectAtIndex:indexPath.row];
//        aTemplate5.photo = [menuImageArray objectAtIndex:indexPath.row];      
        [aTemplate5 setLabelText:[nameArray objectAtIndex:indexPath.row]];
        [aTemplate5 setTextViewText:[detailArray objectAtIndex:indexPath.row]];
        [aTemplate5 setPhotoUrlString:[menuImageArray objectAtIndex:indexPath.row]];
        [self.view addSubview:aTemplate5.view];  
    
    }else
    {
        aTemplate6 =[[Template6 alloc] initWithNibName:@"Template6" bundle:nil]; 
        aTemplate6.view.frame = CGRectMake(300,60,707,600);
//        aTemplate6.title1 = [nameArray objectAtIndex:indexPath.row];
//        aTemplate6.textDetail = [detailArray objectAtIndex:indexPath.row];
//        aTemplate6.webLink = [videoArray objectAtIndex:indexPath.row];
//        aTemplate6.photo = [menuImageArray objectAtIndex:indexPath.row];
        [aTemplate6 setLabelText:[nameArray objectAtIndex:indexPath.row]];
        [aTemplate6 setTextViewText:[detailArray objectAtIndex:indexPath.row]];
        [aTemplate6 setPhotoUrlString:[menuImageArray objectAtIndex:indexPath.row]];
        [aTemplate6 loadWebViewWith:[videoArray objectAtIndex:indexPath.row]];
        [self.view addSubview:aTemplate6.view];  

    }
    
//    [aTableView reloadData];
    
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
    [nameArray release];
	[detailArray release];
    [templateArray release];
    [menuImageArray release];
    [webLinkArray release];
    [amenityArray release];
//    [txtloginId release];
//    [loginView release];
//    [weatherView release];
//    [logOutBtn release];
    
    [aTemplate1 release];
    [aTemplate2 release];
    [aTemplate3 release];
    [aTemplate4 release];
    [aTemplate5 release];
    [aTemplate6 release];
   
       [super dealloc];
	
}


@end
