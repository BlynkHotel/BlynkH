    //
//  InRoomServiceView.m
//  Eye
//
//  Created by Blynk Systems on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InRoomServiceView.h"
#import "MessageView.h"
#import "EyeAppDelegate.h"
#import "BKAPIClient.h"
#import "CustomCell.h"
#import "HelpView1.h"
#import "DSActivityView.h"
#import "CustomBadge.h"
#import "proAlertView.h"
#import "DSActivityView.h"
#import "HomeView.h"
#import "URLRequestGenerator.h"

@implementation InRoomServiceView
@synthesize mainDataArray,menuId;
@synthesize menuName,menuTitle;
@synthesize fNameArray,fServiceIdArray,fLongDetailArray,fSortDetailArray,fRateArray,fQuantityArray;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//register for custombadge updated notification
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customBadgeUpdated) name:[NotificationNames notificationNameForCustomBadgeUpdate] object:nil];
//	//register for received guest details notification
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedGuestDetails) name:[NotificationNames notificationNameForGuestDetails] object:nil];
//	
    menuView.hidden = NO;
    helpBtn.hidden = YES;
//    [self displayLogout];
//    logOutBtn.hidden=YES;
//    loginBtn.hidden=NO;

	aTableView.backgroundColor = [UIColor clearColor];
    mainDataArray = [[NSMutableArray alloc]init];  
    
    fSortDetailArray = [[NSMutableArray alloc]init];
    fNameArray = [[NSMutableArray alloc]init];
    //fSortDetailArray = [[NSMutableArray alloc]init];
    fLongDetailArray = [[NSMutableArray alloc]init];
    fServiceIdArray = [[NSMutableArray alloc]init];
    fQuantityArray = [[NSMutableArray alloc]init];
   
    appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    [backImageView setImage:[UIImage imageWithData:appDelegate.data]];
    [logoView setImage:[UIImage imageWithData:appDelegate.data1]];
//    [DSBezelActivityView removeViewAnimated:YES];
    [self treeView];
    
//	[self receivedGuestDetails];
	
//     NSTimer *theTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dateAndtimeSetup) userInfo:nil repeats:YES];
    self.title = self.menuTitle;
}

-  (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
          
    NSTimer *theTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(changeBottomAdd) userInfo:nil repeats:YES];
    myTimer = theTimer;
    
//    [self setCustomBadge];
	[appDelegate displayGuestDetail];
    [menuTableView reloadData];
    
    self.navigationItem.backBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"Back"
                                      style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(backToHome)] autorelease];

}


- (void)menuView
{
    /*
    menuView.hidden = NO;
    
    lblTitle.text = [NSString stringWithFormat:@"%@",menuName];
    if (appDelegate.isNetworkAvailable)
    {
        [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
        AsyncDownloader *dataDownloader = [[AsyncDownloader alloc] initWithRequest:[URLRequestGenerator requestToLoadMenuDetail:menuName menuId:menuId] delegate:self methodName:@"loadMenuDetail"  responseDataFormat:nil]; // nil == JSON by default
        [dataDownloader startDownloading];
        [dataDownloader release];
    } 
    else 
    {
        [appDelegate showNetworkUnavailableError];
    }
    */
    menuView.hidden = NO;
    
    lblTitle.text = [NSString stringWithFormat:@"%@",menuName];
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    //[appDelegate startDefaultActIndicatorForView:menuTableView];
    //[appDelegate startDefaultActIndicatorForView:menuTableView];
    NSMutableDictionary *response1 = [BKAPIClient loadMenuDetail:menuName menuId:menuId];
    
    
    appDelegate.serviceIdArray = [response1 valueForKey:@"services_id"];
    appDelegate.nameArray = [response1 valueForKey:@"services_name"];
    appDelegate.rateArray = [response1 valueForKey:@"rate"];
    appDelegate.sortDetailArray= [response1 valueForKey:@"short_desc"];
    appDelegate.longDetailArray = [response1 valueForKey:@"long_desc"];
    appDelegate.imageArray = [response1 valueForKey:@"image"];
    
    [appDelegate.quantityArray removeAllObjects];
    
    for (int q = 0; q < [appDelegate.serviceIdArray count]; q++) {
        
        [appDelegate.quantityArray addObject:[NSNumber numberWithInt:0]];
    }
    
    if (appDelegate.isGuest == YES && appDelegate.isActive == YES) {
        
        NSMutableDictionary *response = [BKAPIClient updateQuantityItem:menuId guestId:appDelegate.appLoginId serviceName:menuName];   
        
        NSMutableArray *sIdArray = [response valueForKey:@"services_id"];
        NSMutableArray *qArray  = [response valueForKey:@"qty"];
        
        if ([sIdArray count]>0) {
            
            for (int b = 0; b < [appDelegate.serviceIdArray count]; b++) {
                
                for (int h = 0; h < [sIdArray count]; h++) {
                    
                    if ([[appDelegate.serviceIdArray objectAtIndex:b]intValue]==[[sIdArray objectAtIndex:h]intValue]) {
                        
                        int old = [[qArray objectAtIndex:h] intValue];
                        [appDelegate.quantityArray replaceObjectAtIndex:b withObject:[NSNumber numberWithInt:old]];
                    }
                }
            }
        }else{
            
            for (int q = 0; q < [appDelegate.serviceIdArray count]; q++) {
                
                [appDelegate.quantityArray addObject:[NSNumber numberWithInt:0]];
            }
        }
        
    }
    //[appDelegate stopDefaultActIndicator];
    //[appDelegate stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
    [menuTableView reloadData];
}

-(void)stopAct
{
    EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate]; 
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [appDel stopStandardActivityLoadingView];
    [pool release];
}

-(void)startAct
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
//    [DSBezelActivityView newActivityViewForView:self.view];
//    [appDelegate startDefaultActIndicatorForView:menuTableView];
    [appDelegate startStandardActivityLoadingView:menuTableView];
    [pool release];
}

#pragma mark -
#pragma mark AsyncDownloader Delegate Methods

-(void)didFinishDownloadingAsyncDownloaderInJson:(NSString *)jsonString ForMethod:(NSString *)methodName
{
    if([methodName isEqualToString:@"loadMenuDetail"])
	{
        //[appDelegate stopDefaultActIndicator];
		if(jsonString != nil)
		{
			NSMutableDictionary *response1 = (NSMutableDictionary *)[jsonString JSONValue];
			
            appDelegate.serviceIdArray = [response1 valueForKey:@"services_id"];
            appDelegate.nameArray = [response1 valueForKey:@"services_name"];
            appDelegate.rateArray = [response1 valueForKey:@"rate"];
            appDelegate.sortDetailArray= [response1 valueForKey:@"short_desc"];
            appDelegate.longDetailArray = [response1 valueForKey:@"long_desc"];
            appDelegate.imageArray = [response1 valueForKey:@"image"];            
        }
        
        //[appDelegate.quantityArray removeAllObjects];
        
        for (int q = 0; q < [appDelegate.serviceIdArray count]; q++) {
            
            [appDelegate.quantityArray addObject:[NSNumber numberWithInt:0]];
        }
        
        if (appDelegate.isGuest == YES && appDelegate.isActive == YES) {
            
            NSMutableDictionary *response = [BKAPIClient updateQuantityItem:menuId guestId:appDelegate.appLoginId serviceName:menuName];   
            
            NSMutableArray *sIdArray = [response valueForKey:@"services_id"];
            NSMutableArray *qArray  = [response valueForKey:@"qty"];
            
            if ([sIdArray count]>0) {
                
                for (int b = 0; b < [appDelegate.serviceIdArray count]; b++) {
                    
                    for (int h = 0; h < [sIdArray count]; h++) {
                        
                        if ([[appDelegate.serviceIdArray objectAtIndex:b]intValue]==[[sIdArray objectAtIndex:h]intValue]) {
                            
                            int old = [[qArray objectAtIndex:h] intValue];
                            [appDelegate.quantityArray replaceObjectAtIndex:b withObject:[NSNumber numberWithInt:old]];
                        }
                    }
                }
            }else{
                
                for (int q = 0; q < [appDelegate.serviceIdArray count]; q++) {
                    
                    [appDelegate.quantityArray addObject:[NSNumber numberWithInt:0]];
                }
            }
            
        }
         
        [menuTableView reloadData];
//        [DSBezelActivityView removeViewAnimated:YES];
       
	}
}

- (void)viewWillDisappear:(BOOL)animated{
   
    if(appDelegate.lastMenuTitles == nil)
        appDelegate.lastMenuTitles = [NSMutableDictionary dictionary];
    [appDelegate.lastMenuTitles setValue:self.menuName forKey:@"inroommenutitle"];
    
    [myTimer invalidate];
    //[appDelegate messageService];
}

- (void)changeBottomAdd {
    
    appDelegate = (EyeAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    if ( t<[appDelegate.adImageArray count]) {
        if (appDelegate.isNetworkAvailable)
        {
            NSURL *url = [NSURL URLWithString:[appDelegate.adImageArray objectAtIndex:t]];
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
*/
-(void)treeView
{
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    //[appDelegate startDefaultActIndicatorForView:self.view];
    if ([appDelegate.inRoomMenuArray count]==0)
    {
        NSMutableDictionary *response1 = [BKAPIClient rootMenuitem:@"4"];
        appDelegate.inRoomMenuArray  = [response1 valueForKey:@"services_name"];
    }
	
    self.menuName = [NSString stringWithFormat:@"%@",[appDelegate.inRoomMenuArray objectAtIndex:0]];
    lblTitle.text = [NSString stringWithFormat:@"%@",[appDelegate.inRoomMenuArray objectAtIndex:0]];
    
    
    BOOL shouldLoadMenuView = true;
    if(appDelegate.serviceIdArray != nil && appDelegate.serviceIdArray.count > 0
       && 
       appDelegate.nameArray != nil && appDelegate.nameArray.count > 0
       && 
       appDelegate.rateArray != nil && appDelegate.rateArray.count > 0
       &&
       appDelegate.sortDetailArray != nil && appDelegate.sortDetailArray.count > 0
       && 
       appDelegate.longDetailArray != nil && appDelegate.longDetailArray.count > 0
       && 
       appDelegate.imageArray != nil && appDelegate.imageArray.count > 0
       && 
       appDelegate.quantityArray != nil && appDelegate.quantityArray.count > 0
       )
        {
            shouldLoadMenuView = false;
        }
    if(shouldLoadMenuView)
    {
        [self menuView];        
    }
    else
    {
        //[appDelegate stopDefaultActIndicator];  
        if(appDelegate.lastMenuTitles != nil)
        {
             self.menuName =  [appDelegate.lastMenuTitles valueForKey:@"inroommenutitle"];
            lblTitle.text = [NSString stringWithFormat:@"%@",menuName];
        }
        [menuTableView reloadData];
    }   
    
    //[self menuView];
    //[appDelegate stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];    
}
- (IBAction)displayHelpView{
    
    HelpView1 *aHelpView = [[HelpView1 alloc]initWithNibName:@"HelpView1" bundle:nil];
    aHelpView.view.frame = CGRectMake(294,60,713,600);
	[self.view addSubview:aHelpView.view];  
}

#pragma mark -
#pragma mark Table view mainDataArray source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int row;
    switch(tableView.tag){
        case 0:
            row = [appDelegate.inRoomMenuArray count];
            break;
        case 1: 
            row = [appDelegate.nameArray count];
            break;
        case 2:
            row = [fNameArray count];
            break;
    }
    return row;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    if (tableView == aTableView) {
        
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
//            cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
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
    
        cell.textLabel.text = [appDelegate.inRoomMenuArray objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor whiteColor];
        //cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
        cell.textLabel.font = [UIFont systemFontOfSize:20];
        return cell;
            
    }else if (tableView == menuTableView){
        
        static NSString *CellIdentifier = @"Cell";
        
        CustomCell *cell = [menuTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
//            cell = [[[CustomCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
            cell =[[[CustomCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        }
        
        UIButton *minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        minusBtn.frame= CGRectMake(500,7,40,40);
        minusBtn.tag = indexPath.row;
        [minusBtn setImage:[UIImage imageNamed:@"removeButan.png"] forState:UIControlStateNormal];
        [minusBtn addTarget:self action:@selector(minusAction:) forControlEvents:UIControlEventTouchUpInside];	
        
        UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        plusBtn.frame= CGRectMake(620,7,40,40);
        plusBtn.tag = indexPath.row;
        [plusBtn setImage:[UIImage imageNamed:@"Addbutton.png"] forState:UIControlStateNormal];
        [plusBtn addTarget:self action:@selector(plusAction:) forControlEvents:UIControlEventTouchUpInside];	
        
        UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn.frame= CGRectMake(560,7,40,40);
        itemBtn.tag = indexPath.row;
        [itemBtn setBackgroundImage:[UIImage imageNamed:@"number_butan_1.png"] forState:UIControlStateNormal];
        [itemBtn setTitle: [[appDelegate.quantityArray objectAtIndex:[indexPath row]] stringValue] forState:UIControlStateNormal];
        [itemBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if(appDelegate.nameArray.count >= indexPath.row)
            {
                cell.primaryLabel.text = [appDelegate.nameArray objectAtIndex:indexPath.row];
            }
        if(appDelegate.sortDetailArray.count >= indexPath.row)
        {
            cell.secondaryLabel.text = [appDelegate.sortDetailArray objectAtIndex:indexPath.row];
        }
        
        cell.priceLabel.text = [NSString stringWithFormat:@"%@%@",appDelegate.currency,[appDelegate.rateArray objectAtIndex:indexPath.row]];
        [cell.contentView addSubview:minusBtn];
        [cell.contentView addSubview:plusBtn];
        [cell.contentView addSubview:itemBtn];
        
        return cell;
        
    }else {
        
        static NSString *CellIdentifier = @"Cell";
        
        CustomCell *cell = [cartTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
//            cell = [[[CustomCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
            cell =[[[CustomCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        }
        
        UIButton *minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        minusBtn.frame= CGRectMake(470,7,40,40);
        minusBtn.tag = indexPath.row;
        [minusBtn setImage:[UIImage imageNamed:@"removeButan.png"] forState:UIControlStateNormal];
        [minusBtn addTarget:self action:@selector(minusAction1:) forControlEvents:UIControlEventTouchUpInside];	
        
        UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        plusBtn.frame= CGRectMake(570,7,40,40);
        plusBtn.tag = indexPath.row;
        [plusBtn setImage:[UIImage imageNamed:@"Addbutton.png"] forState:UIControlStateNormal];
        [plusBtn addTarget:self action:@selector(plusAction1:) forControlEvents:UIControlEventTouchUpInside];	
        
        NSString *qnty = [fQuantityArray objectAtIndex:indexPath.row];
        
        UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn.frame= CGRectMake(520,7,40,40);
        itemBtn.tag = indexPath.row;
        [itemBtn setBackgroundImage:[UIImage imageNamed:@"number_butan_1.png"] forState:UIControlStateNormal];
        [itemBtn setTitle:qnty forState:UIControlStateNormal];
        [itemBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        UIButton *addToCart = [UIButton buttonWithType:UIButtonTypeCustom];
        addToCart.frame= CGRectMake(620,7,40,40);
        addToCart.tag = indexPath.row;
        [addToCart setImage:[UIImage imageNamed:@"deleteCart.png"] forState:UIControlStateNormal];
        [addToCart addTarget:self action:@selector(removeCartItem:) forControlEvents:UIControlEventTouchUpInside];		
        
        if ([fServiceIdArray count]>0) {
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.primaryLabel.text = [fNameArray objectAtIndex:indexPath.row];
            cell.secondaryLabel.text = [fSortDetailArray objectAtIndex:indexPath.row];
            cell.priceLabel.text = [NSString stringWithFormat:@"%@%@",appDelegate.currency,[fRateArray objectAtIndex:indexPath.row]];
            [cell.contentView addSubview:minusBtn];
            [cell.contentView addSubview:plusBtn];
            [cell.contentView addSubview:addToCart];
            [cell.contentView addSubview:itemBtn];
        }
        return cell;
    }

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {  
    return 54;  
} 

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [DSBezelActivityView removeViewAnimated:YES];
    //[appDelegate stopDefaultActIndicator];
    if (tableView == aTableView) {
        
        self.menuName = [NSString stringWithFormat:@"%@",[appDelegate.inRoomMenuArray objectAtIndex:indexPath.row]];
        //[appDelegate.quantityArray removeAllObjects];
        [self menuView]; 
//        [menuTableView reloadData];
//        [aTableView reloadData];
        
        
    } else if (tableView == menuTableView){
        
        cell1 = [NSString stringWithFormat:@"%d",[indexPath row]];
        //[self displayDetailView];
        [self displayDetailView:indexPath];
        
    }else{
     
    }
}

-(IBAction)removeMenuView:(id)sender{
    
    menuView.hidden = YES;
}

-(IBAction)backToHome{
	
	[self.navigationController popViewControllerAnimated:YES];	
}

- (IBAction)plusAction:(id)sender{
    
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    if (appDelegate.isGuest == YES && appDelegate.isActive == YES) {
        
        int correctIndex = [sender tag];
        int old = [[appDelegate.quantityArray objectAtIndex:correctIndex] intValue];
        [appDelegate.quantityArray replaceObjectAtIndex:correctIndex withObject:[NSNumber numberWithInt:old + 1]];
        
        UITableViewCell *cell=(UITableViewCell*)[[sender superview] superview];
        UITableView *table=(UITableView*)[cell superview];
        NSIndexPath *path=[table indexPathForCell:cell];
        
        NSString *serviceID = [appDelegate.serviceIdArray objectAtIndex:path.row];
        NSString *qnty = [appDelegate.quantityArray objectAtIndex:path.row];
     
        NSMutableDictionary *response = [BKAPIClient addtoCartItem:serviceID guestId:appDelegate.appLoginId quantity:qnty menuId:@"4"];
        appDelegate.totalArray = [response valueForKey:@"Total"];  
        lblTotal.text = [NSString stringWithFormat:@"Total:%@%@",appDelegate.currency,[appDelegate.totalArray objectAtIndex:0]];
        [menuTableView reloadData];
    }else{
        
        proAlertView *alert = [[proAlertView alloc]initWithTitle:@"Alert" message:@"Please, Login First" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert setBackgroundColor:[UIColor colorWithRed:0.129 green:0.129 blue:0.129 alpha:1.0] withStrokeColor:[UIColor colorWithHue:0.625 saturation:0.0 brightness:0.8 alpha:0.8]];
        [alert show];
        [alert release];
    }
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}

- (IBAction)minusAction:(id)sender{
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    if (appDelegate.isGuest == YES && appDelegate.isActive == YES) {
        
        int correctIndex = [sender tag];
        int old = [[appDelegate.quantityArray objectAtIndex:correctIndex] intValue];
        
        if (old > 0) {
            
            [appDelegate.quantityArray replaceObjectAtIndex:correctIndex withObject:[NSNumber numberWithInt:old - 1]];
        }
        
        UITableViewCell *cell=(UITableViewCell*)[[sender superview] superview];
        UITableView *table=(UITableView*)[cell superview];
        NSIndexPath *path=[table indexPathForCell:cell];
        
        NSString *serviceID = [appDelegate.serviceIdArray objectAtIndex:path.row];
        NSString *qnty = [appDelegate.quantityArray objectAtIndex:path.row];
    
        NSMutableDictionary *response = [BKAPIClient addtoCartItem:serviceID guestId:appDelegate.appLoginId quantity:qnty menuId:@"4"];
        appDelegate.totalArray = [response valueForKey:@"Total"];  
        lblTotal.text = [NSString stringWithFormat:@"Total:%@%@",appDelegate.currency,[appDelegate.totalArray objectAtIndex:0]];
        [menuTableView reloadData];
    }else{
        
        proAlertView *alert = [[proAlertView alloc]initWithTitle:@"Alert" message:@"Please, Login First" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert setBackgroundColor:[UIColor colorWithRed:0.129 green:0.129 blue:0.129 alpha:1.0] withStrokeColor:[UIColor colorWithHue:0.625 saturation:0.0 brightness:0.8 alpha:0.8]];
        [alert show];
        [alert release];
    }
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
	
}

- (IBAction)viewCartAction{
    
     if (appDelegate.isGuest == YES && appDelegate.isActive == YES) {
         
         [self displayViewCart]; 
         
     }else{
        proAlertView *alert = [[proAlertView alloc]initWithTitle:@"Alert" message:@"Please, Login First" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alert setBackgroundColor:[UIColor colorWithRed:0.129 green:0.129 blue:0.129 alpha:1.0] withStrokeColor:[UIColor colorWithHue:0.625 saturation:0.0 brightness:0.8 alpha:0.8]];
         [alert show];
         [alert release];            
     }
}

- (void)displayViewCart{
              
            [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
              cartView = [[UIView alloc]initWithFrame:CGRectMake(300,60,707,600)];
    
              UIImageView *backImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,cartView.frame.size.width,cartView.frame.size.height)];
              cartView.backgroundColor = [UIColor clearColor];
              [backImage setImage:[UIImage imageNamed:@"shoppingDetailView.png"]];
              [cartView addSubview:backImage];
    
              UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
              [closeBtn addTarget:self action:@selector(removeViewCart:) forControlEvents:UIControlEventTouchUpInside];
              closeBtn.frame = CGRectMake(670,0,37,35);
              closeBtn.backgroundColor = [UIColor clearColor];
              [cartView addSubview:closeBtn];
        
              lblTitle1 = [[UILabel alloc]initWithFrame:CGRectMake(20,14,196, 27)];
              lblTitle1.textAlignment= UITextAlignmentLeft;
              lblTitle1.backgroundColor = [UIColor clearColor];
              lblTitle1.textColor = [UIColor whiteColor];
              lblTitle1.font = [UIFont boldSystemFontOfSize:21];
              [cartView addSubview:lblTitle1];
    
              UILabel *mainTitle = [[UILabel alloc]initWithFrame:CGRectMake(20,9,106, 32)];
              mainTitle.textAlignment= UITextAlignmentLeft;
              mainTitle.backgroundColor = [UIColor clearColor];
              mainTitle.text = @"Your Cart";
              mainTitle.textColor = [UIColor whiteColor];
              mainTitle.font = [UIFont boldSystemFontOfSize:22];
              [cartView addSubview:mainTitle];
    
              aScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 49, 707, 543)];
              [aScrollView setContentSize:CGSizeMake(707,543)]; 
              [cartView addSubview:aScrollView];
    
              cartTableView = [[UITableView alloc]initWithFrame:CGRectMake(15, 3, 677, 424)];
              cartTableView.delegate = self;
              cartTableView.dataSource = self;
              cartTableView.tag = 2;
              [aScrollView addSubview:cartTableView];
    
             UIImageView *specialInt =[[UIImageView alloc]initWithFrame:CGRectMake(15, 438,677,114)];
//             loginView.backgroundColor = [UIColor clearColor];
             [specialInt setImage:[UIImage imageNamed:@"view_cart_box.png"]];
             [aScrollView addSubview:specialInt];

             UILabel *lblSpecial = [[UILabel alloc]initWithFrame:CGRectMake(29,480,171,21)];
             lblSpecial.textAlignment= UITextAlignmentLeft;
             lblSpecial.backgroundColor = [UIColor clearColor];
             lblSpecial.text = @"Special Instructions";
             lblSpecial.textColor = [UIColor whiteColor];
             lblSpecial.font = [UIFont fontWithName:@"" size:16];
             [aScrollView addSubview:lblSpecial];
    
             NSMutableDictionary *response = [BKAPIClient loadDisclaimer:@"4"];
             NSMutableArray *disText = [response valueForKey:@"disclaimer"];
             UILabel *lbldisclamer = [[UILabel alloc]initWithFrame:CGRectMake(29,440,300,27)];
             lbldisclamer.textAlignment= UITextAlignmentLeft;
             lbldisclamer.backgroundColor = [UIColor clearColor];
             lbldisclamer.text = [NSString stringWithFormat:@"%@",[disText objectAtIndex:0]];
             lbldisclamer.textColor = [UIColor whiteColor];
             lbldisclamer.font = [UIFont fontWithName:@"" size:15];
             [aScrollView addSubview:lbldisclamer];
    
             UILabel *total = [[UILabel alloc]initWithFrame:CGRectMake(500,447,50,27)];
             total.textAlignment= UITextAlignmentLeft;
             total.backgroundColor = [UIColor clearColor];
             total.text = @"Total";
             total.textColor = [UIColor whiteColor];
             total.font = [UIFont fontWithName:@"" size:16];
             [aScrollView addSubview:total];
    
             UIImageView *totalImg =[[UIImageView alloc]initWithFrame:CGRectMake(550,445,135,30)];
             [totalImg setImage:[UIImage imageNamed:@"total.png"]];
             [aScrollView addSubview:totalImg];
    
             lblTotal1 = [[UILabel alloc]initWithFrame:CGRectMake(550,446,134,28)];
             lblTotal1.textAlignment= UITextAlignmentCenter;
             lblTotal1.backgroundColor = [UIColor clearColor];
             lblTotal1.textColor = [UIColor redColor];
             lblTotal1.font = [UIFont boldSystemFontOfSize:18];
             [aScrollView addSubview:lblTotal1];
    
             UIButton *deliverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
             [deliverBtn setBackgroundImage:[UIImage imageNamed:@"add_to_cart_1.png"] forState:UIControlStateNormal];
             [deliverBtn addTarget:self action:@selector(setDeliverTime:) forControlEvents:UIControlEventTouchUpInside];
             deliverBtn.frame = CGRectMake(587,480,96,29);
             deliverBtn.backgroundColor = [UIColor clearColor];
             [aScrollView addSubview:deliverBtn];
    
             deliverTime = [[UILabel alloc]initWithFrame:CGRectMake(587,480,96,29)];
             deliverTime.textAlignment= UITextAlignmentCenter;
             deliverTime.text = @"Deliver Time";
             deliverTime.backgroundColor = [UIColor clearColor];
             deliverTime.textColor = [UIColor whiteColor];
             deliverTime.font = [UIFont boldSystemFontOfSize:15];
             [aScrollView addSubview:deliverTime];
    
             lblhrs = [[UILabel alloc]initWithFrame:CGRectMake(610,480,25,29)];
             lblhrs.textAlignment= UITextAlignmentCenter;
             lblhrs.backgroundColor = [UIColor clearColor];
             lblhrs.textColor = [UIColor whiteColor];
             lblhrs.font = [UIFont boldSystemFontOfSize:15];
             [aScrollView addSubview:lblhrs];
    
             lblmin = [[UILabel alloc]initWithFrame:CGRectMake(635,480,25,29)];
             lblmin.textAlignment= UITextAlignmentCenter;
             lblmin.backgroundColor = [UIColor clearColor];
             lblmin.textColor = [UIColor whiteColor];
             lblmin.font = [UIFont boldSystemFontOfSize:15];
             [aScrollView addSubview:lblmin];
    
             lblhrs.text = @"00";
             lblmin.text = @":00";
             lblmin.hidden =YES;
             lblhrs.hidden = YES;
    
             txtSuggestion = [[UITextView alloc] initWithFrame:CGRectMake(29,504,547,35)];
             txtSuggestion.font = [UIFont boldSystemFontOfSize:14];
             txtSuggestion.textColor = [UIColor blackColor];
             txtSuggestion.returnKeyType = UIReturnKeyDone;
             txtSuggestion.autocorrectionType = UITextAutocorrectionTypeNo;
             txtSuggestion.delegate = self;
             txtSuggestion.keyboardType=UIKeyboardTypeDefault;
             [aScrollView addSubview:txtSuggestion];
    
             UIButton *checkOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
             [checkOutBtn setBackgroundImage:[UIImage imageNamed:@"add_to_cart_1.png"] forState:UIControlStateNormal];
             [checkOutBtn addTarget:self action:@selector(checkout:) forControlEvents:UIControlEventTouchUpInside];
             checkOutBtn.frame = CGRectMake(587,515,96,29);
             [checkOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             [checkOutBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
             [checkOutBtn setTitle:@"Checkout" forState:UIControlStateNormal];
             checkOutBtn.backgroundColor = [UIColor clearColor];
             [aScrollView addSubview:checkOutBtn];
    
             [self.view addSubview:cartView];
             [self viewCartService];
             [self Colors];
             [self Minutes];
            [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
         
}

- (void)viewCartService{
    
    if (appDelegate.isGuest == YES && appDelegate.isActive == YES) {
        
        NSMutableDictionary *response = [BKAPIClient viewCartItem:menuId guestId:appDelegate.appLoginId];
        self.fServiceIdArray = [response valueForKey:@"services_id"];
        self.fNameArray = [response valueForKey:@"services_name"];
        self.fRateArray = [response valueForKey:@"rate"];
        self.fSortDetailArray= [response valueForKey:@"short_desc"];
        self.fLongDetailArray = [response valueForKey:@"long_desc"];
        self.fQuantityArray = [response valueForKey:@"qty"];
                 
        if ([appDelegate.totalArray count]>0) {
            
                lblTotal1.text =  [NSString stringWithFormat:@"%@%@",appDelegate.currency,[appDelegate.totalArray objectAtIndex:0]];
        }
           
    }
    
    
}

-(IBAction)setDeliverTime:(id)sender {
    
    popupView = [[UIView alloc]initWithFrame:CGRectMake(0, 242, 707,240)];
    popupView.backgroundColor = [UIColor blackColor];
    [cartView addSubview:popupView];
    
    pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(165,50,377,215)];
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    [popupView addSubview:pickerView];
    
    lblmin.hidden =NO;
    lblhrs.hidden = NO;
    
    [pickerView  selectRow:selectedRow1 inComponent:0 animated:YES];
    [pickerView  selectRow:selectedRow2 inComponent:1 animated:YES];
   
    UILabel *lblDisplay = [[UILabel alloc]initWithFrame:CGRectMake(205,02,300,35)];
    lblDisplay.text = @"Select Deliver Time";
    lblDisplay.textAlignment= UITextAlignmentCenter;
    lblDisplay.backgroundColor = [UIColor clearColor];
    lblDisplay.textColor = [UIColor whiteColor];
    lblDisplay.font = [UIFont boldSystemFontOfSize:22];
    [popupView addSubview:lblDisplay];
    
    doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame= CGRectMake(560,80,75,35);
    [doneBtn setBackgroundImage:[UIImage imageNamed:@"add_to_cart_1.png"] forState:UIControlStateNormal];
    [doneBtn setTitle:@"OK" forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
	[popupView addSubview:doneBtn];
    
    cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame= CGRectMake(560,160,75,35);
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"add_to_cart_1.png"] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
	[cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
	[popupView addSubview:cancelBtn];
    deliverTime.text = @"";
}

-(IBAction)cancelAction:(id)sender
{
    lblhrs.text = @"00";
    lblmin.text = @":00";
    lblmin.hidden =YES;
    lblhrs.hidden = YES;
    deliverTime.text = @"DeliverTime";   
	[popupView removeFromSuperview];
	
}

-(IBAction)doneAction:(id)sender
{
	[popupView removeFromSuperview];
}


-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
	
	[aScrollView setContentOffset:CGPointMake(0,textView.center.y-150) animated:YES];
    
	return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    [aScrollView setContentOffset:CGPointMake(0,0) animated:YES];
    [textView resignFirstResponder];	
    return YES;
    
    
}

- (void)Colors
{
    arrayColors = [[NSMutableArray alloc] init];
	[arrayColors addObject:@"01"];
	[arrayColors addObject:@"02"];
	[arrayColors addObject:@"03"];
	[arrayColors addObject:@"04"];
	[arrayColors addObject:@"05"];
	[arrayColors addObject:@"06"];
	[arrayColors addObject:@"07"];
	[arrayColors addObject:@"08"];
	[arrayColors addObject:@"09"];
	[arrayColors addObject:@"10"];
	[arrayColors addObject:@"11"];
	[arrayColors addObject:@"12"];
    [arrayColors addObject:@"13"];
	[arrayColors addObject:@"14"];
	[arrayColors addObject:@"15"];
	[arrayColors addObject:@"16"];
	[arrayColors addObject:@"17"];
	[arrayColors addObject:@"18"];
	[arrayColors addObject:@"19"];
	[arrayColors addObject:@"20"];
	[arrayColors addObject:@"21"];
	[arrayColors addObject:@"22"];
	[arrayColors addObject:@"23"];
	[arrayColors addObject:@"24"];
	
    
}
- (void)Minutes
{
    arrayMinutes = [[NSMutableArray alloc] init];
	[arrayMinutes addObject:@"01"];
	[arrayMinutes addObject:@"02"];
	[arrayMinutes addObject:@"03"];
	[arrayMinutes addObject:@"04"];
	[arrayMinutes addObject:@"05"];
	[arrayMinutes addObject:@"06"];
	[arrayMinutes addObject:@"07"];
	[arrayMinutes addObject:@"08"];
	[arrayMinutes addObject:@"09"];
	[arrayMinutes addObject:@"10"];
	[arrayMinutes addObject:@"11"];
	[arrayMinutes addObject:@"12"];
	[arrayMinutes addObject:@"13"];
	[arrayMinutes addObject:@"14"];
	[arrayMinutes addObject:@"15"];
	[arrayMinutes addObject:@"16"];
	[arrayMinutes addObject:@"17"];
	[arrayMinutes addObject:@"18"];
	[arrayMinutes addObject:@"19"];
	[arrayMinutes addObject:@"20"];
	[arrayMinutes addObject:@"21"];
	[arrayMinutes addObject:@"22"];
	[arrayMinutes addObject:@"23"];
	[arrayMinutes addObject:@"24"];
	[arrayMinutes addObject:@"25"];
	[arrayMinutes addObject:@"26"];
	[arrayMinutes addObject:@"27"];
	[arrayMinutes addObject:@"28"];
	[arrayMinutes addObject:@"29"];
	[arrayMinutes addObject:@"30"];
	[arrayMinutes addObject:@"31"];
	[arrayMinutes addObject:@"32"];
	[arrayMinutes addObject:@"33"];
	[arrayMinutes addObject:@"34"];
	[arrayMinutes addObject:@"35"];
	[arrayMinutes addObject:@"36"];
	[arrayMinutes addObject:@"37"];
	[arrayMinutes addObject:@"38"];
	[arrayMinutes addObject:@"39"];
	[arrayMinutes addObject:@"40"];
	[arrayMinutes addObject:@"41"];
	[arrayMinutes addObject:@"42"];
	[arrayMinutes addObject:@"43"];
	[arrayMinutes addObject:@"44"];
	[arrayMinutes addObject:@"45"];
	[arrayMinutes addObject:@"46"];
	[arrayMinutes addObject:@"47"];
	[arrayMinutes addObject:@"48"];
	[arrayMinutes addObject:@"49"];
	[arrayMinutes addObject:@"50"];
	[arrayMinutes addObject:@"51"];
	[arrayMinutes addObject:@"52"];
	[arrayMinutes addObject:@"53"];
	[arrayMinutes addObject:@"54"];
	[arrayMinutes addObject:@"55"];
	[arrayMinutes addObject:@"56"];
	[arrayMinutes addObject:@"57"];
	[arrayMinutes addObject:@"58"];
	[arrayMinutes addObject:@"59"];
	[arrayMinutes addObject:@"60"];
	
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0)
    {
        return [arrayColors count];
    }
    else 
    {
        return [arrayMinutes count];
        
    }
    
}
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
    
	if (component == 0)
    {
		return [arrayColors objectAtIndex:row];   
        
	}else{
        
        return [arrayMinutes objectAtIndex:row]; 
    }
   	
}
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	
	
	if  (component == 0)
    {
        NSLog(@"you selected a %@", [arrayColors objectAtIndex:row]);
        hoursTime =[arrayColors objectAtIndex:row];
        selectedRow1 = row;
        lblhrs.text = [NSString stringWithFormat:@"%@",hoursTime];
    }
    else{
        
        NSLog(@"you selected a %@", [arrayMinutes objectAtIndex:row]);
        minTime = [arrayMinutes objectAtIndex:row]; 
        selectedRow2 = row;
        lblmin.text = [NSString stringWithFormat:@":%@",minTime];
    }
    // deliverTime.text = [NSString stringWithFormat:@"%@:%@:%@",hoursTime,minTime,intTime];
    [pickerView reloadComponent:component];
   
}

- (IBAction)plusAction1:(id)sender{
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    if (appDelegate.isGuest == YES && appDelegate.isActive == YES){
        
        UITableViewCell *cell=(UITableViewCell*)[[sender superview] superview];
        UITableView *table=(UITableView*)[cell superview];
        NSIndexPath *path=[table indexPathForCell:cell];
        
        NSString *serviceID = [fServiceIdArray objectAtIndex:path.row];
        int old = [[fQuantityArray objectAtIndex:path.row] intValue];
        NSString *qnty = [NSString stringWithFormat:@"%d",old+1];
        
        NSMutableDictionary *response = [BKAPIClient addtoCartItem:serviceID guestId:appDelegate.appLoginId quantity:qnty menuId:menuId];
          
        appDelegate.totalArray = [response valueForKey:@"Total"];  
        lblTotal1.text = [NSString stringWithFormat:@"%@%@",appDelegate.currency,[appDelegate.totalArray objectAtIndex:0]];
        
        lblTotal.text = [NSString stringWithFormat:@"Total:%@%@",appDelegate.currency,[appDelegate.totalArray objectAtIndex:0]];
        
        [self viewCartService];
        [cartTableView reloadData];
    }
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}

- (IBAction)minusAction1:(id)sender{
	[NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    if (appDelegate.isGuest == YES && appDelegate.isActive == YES) {
        
        UITableViewCell *cell=(UITableViewCell*)[[sender superview] superview];
        UITableView *table=(UITableView*)[cell superview];
        NSIndexPath *path=[table indexPathForCell:cell];
        
        NSString *serviceID = [fServiceIdArray objectAtIndex:path.row];
        int old = [[fQuantityArray objectAtIndex:path.row] intValue];
        
        NSString *qnty;
        
        if (old>0) {
            
            qnty = [NSString stringWithFormat:@"%d",old-1];
        }
        
        NSMutableDictionary *response = [BKAPIClient addtoCartItem:serviceID guestId:appDelegate.appLoginId quantity:qnty menuId:menuId];
          
        appDelegate.totalArray = [response valueForKey:@"Total"];  
        lblTotal1.text = [NSString stringWithFormat:@"%@%@",appDelegate.currency,[appDelegate.totalArray objectAtIndex:0]];
        
        lblTotal.text = [NSString stringWithFormat:@"Total:%@%@",appDelegate.currency,[appDelegate.totalArray objectAtIndex:0]];
       
        [self viewCartService];
        [cartTableView reloadData];
        
    }
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
    
}

/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath {
	
    [self.fNameArray removeObjectAtIndex:indexPath.row];
    [cartTableView reloadData];
}
*/
- (IBAction)removeCartItem:(id)sender{
    
    if (appDelegate.isGuest == YES && appDelegate.isActive == YES) {
        
        UITableViewCell *cell=(UITableViewCell*)[[sender superview] superview];
        UITableView *table=(UITableView*)[cell superview];
        NSIndexPath *path=[table indexPathForCell:cell];
        
        NSString *serviceID = [fServiceIdArray objectAtIndex:path.row];
        
        NSMutableDictionary *response = [BKAPIClient removeItemFromCart:menuId guestId:appDelegate.appLoginId serviceId:serviceID];
        appDelegate.totalArray = [response valueForKey:@"Total"];  
        lblTotal1.text = [NSString stringWithFormat:@"%@%@",appDelegate.currency,[appDelegate.totalArray objectAtIndex:0]];
        
        lblTotal.text = [NSString stringWithFormat:@"Total:%@%@",appDelegate.currency,[appDelegate.totalArray objectAtIndex:0]];
        
        [self viewCartService];
        [cartTableView reloadData];
    }
	
}

-(IBAction)checkout:(id)sender{
    
    if (appDelegate.isGuest == YES && appDelegate.isActive == YES) {
        
        appDelegate = (EyeAppDelegate*)(EyeAppDelegate*)[[UIApplication sharedApplication]delegate];
        
        NSMutableDictionary *response = [BKAPIClient checkout:appDelegate.appLoginId menuId:menuId specialInt:txtSuggestion.text deliverTime:deliverTime.text];
        
        NSString *message = [response valueForKey:@"notification_name"];
        NSLog(@"=%@",message);
     //   NSLog([NSString stringWithFormat:@"%@",message]);
        
        proAlertView *alert = [[proAlertView alloc]initWithTitle:@"" message:@"Check-Out Successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag=101;
        [alert setBackgroundColor:[UIColor colorWithRed:0.129 green:0.129 blue:0.129 alpha:1.0] withStrokeColor:[UIColor colorWithHue:0.625 saturation:0.0 brightness:0.8 alpha:0.8]];
        [alert show];
        [alert release]; 
        
        appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate messageService];
        
	}
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
    }
    return YES;
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (actionSheet.tag == 101) {
        
        if (buttonIndex == 0)
        {
            NSLog(@"ok");
            //[DSBezelActivityView newActivityViewForView:self.view];
            //[appDelegate startStandardActivityLoadingView:self.view];
            //[NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
            //[self performSelector:@selector(stopActivityIndicator1)];
        }
        else{
            NSLog(@"cancel");
        }
    }else{
         if (buttonIndex == 1){
//            logOutBtn.hidden = YES;
//            loginBtn.enabled = YES;
//            loginBtn.hidden = NO;
//            appDelegate.isGuest = NO;
//            lblGuestName.text =@"Welcome, Guest"; 
//            lblGuestId.text =@"";
            [self treeView];
        }else{
            
        }
    }

}


-(void)stopActivityIndicator1 {
    
    //HomeView *aHomeView=[[HomeView alloc]initWithNibName:@"HomeView" bundle:nil];
    //[appDelegate.navigationController pushViewController: aHomeView animated: YES];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDelegate stopStandardActivityLoadingView];
    //[NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}

- (void)removeViewCart:(id)sender{
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    [self treeView];
    [self menuView];
    [arrayMinutes release];
    [arrayColors release];
    //[menuTableView reloadData];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
    [cartView removeFromSuperview];

}


- (void)displayDetailView:(NSIndexPath *)cellPath
{
    NSLog(@"Cell Index = %d",cellPath.row);
    NSLog(@"appDelegate.nameArray.count = %d",appDelegate.nameArray.count);
    NSLog(@"appDelegate.sortDetailArray.count = %d",appDelegate.sortDetailArray.count);
    NSLog(@"appDelegate.longDetailArray.count = %d",appDelegate.longDetailArray.count);
    NSLog(@"appDelegate.rateArray.count = %d",appDelegate.rateArray.count);
    NSLog(@"appDelegate.imageArray.count = %d",appDelegate.imageArray.count);
    NSLog(@"appDelegate.quantityArray.count = %d",appDelegate.quantityArray.count);
    
    
    detailView = [[UIView alloc]initWithFrame:CGRectMake(300,60,707,600)];
    
    UIImageView *backImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,detailView.frame.size.width,detailView.frame.size.height)];
    detailView.backgroundColor = [UIColor clearColor];
    [backImage setImage:[UIImage imageNamed:@"shoppingDetailView.png"]];
    [detailView addSubview:backImage];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn addTarget:self action:@selector(removeDetailView:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame = CGRectMake(670,0,37,35);
    closeBtn.backgroundColor = [UIColor clearColor];
    [detailView addSubview:closeBtn];
    
    UILabel *lbltitle = [[UILabel alloc]initWithFrame:CGRectMake(20,10,500,28)];
    lbltitle.textAlignment= UITextAlignmentLeft;
    lbltitle.backgroundColor = [UIColor clearColor];
    lbltitle.textColor = [UIColor whiteColor];
    lbltitle.font = [UIFont boldSystemFontOfSize:22];
    [detailView addSubview:lbltitle];
    
    UILabel *mainTitle = [[UILabel alloc]initWithFrame:CGRectMake(20,64,443,21)];
    mainTitle.textAlignment= UITextAlignmentLeft;
    mainTitle.backgroundColor = [UIColor clearColor];
    mainTitle.textColor = [UIColor whiteColor];
    mainTitle.font = [UIFont boldSystemFontOfSize:22];
    [detailView addSubview:mainTitle];
    
    UILabel *lblPrice = [[UILabel alloc]initWithFrame:CGRectMake(40,356,150,30)];
    lblPrice.textAlignment= UITextAlignmentCenter;
    lblPrice.backgroundColor = [UIColor clearColor];
    lblPrice.textColor = [UIColor whiteColor];
    lblPrice.font = [UIFont boldSystemFontOfSize:20];
    [detailView addSubview:lblPrice];

    UIImageView *productImage =[[UIImageView alloc]initWithFrame:CGRectMake(20,109,177,228)];
    [detailView addSubview:productImage];
    
    UITextView *txtDetail = [[UITextView alloc] initWithFrame:CGRectMake(215,109,472,455)];
    txtDetail.font = [UIFont boldSystemFontOfSize:18];
    txtDetail.textColor = [UIColor whiteColor];
    txtDetail.backgroundColor = [UIColor clearColor];
    txtDetail.autocorrectionType = UITextAutocorrectionTypeNo;
    txtDetail.delegate = self;
    txtDetail.editable = NO;
    txtDetail.keyboardType=UIKeyboardTypeDefault;
    [detailView addSubview:txtDetail];
    
    //int value = [cell1 intValue];
    int value = cellPath.row;
    lbltitle.text = [appDelegate.nameArray objectAtIndex:value];
    mainTitle.text = [appDelegate.sortDetailArray objectAtIndex:value];
    txtDetail.text = [appDelegate.longDetailArray objectAtIndex:value];
    lblPrice.text =  [NSString stringWithFormat:@"%@%@",appDelegate.currency,[appDelegate.rateArray objectAtIndex:value]];
    
    
   
    NSURL *url = [NSURL URLWithString:[appDelegate.imageArray objectAtIndex:value]];  
    NSData *data = [NSData dataWithContentsOfURL:url];  
    [productImage setImage:[UIImage imageWithData:data]];

    UIButton *minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    minusBtn.frame= CGRectMake(41,408,40,40);
    minusBtn.tag = value;
    [minusBtn setImage:[UIImage imageNamed:@"removeButan.png"] forState:UIControlStateNormal];
    [minusBtn addTarget:self action:@selector(decreamentAction2:) forControlEvents:UIControlEventTouchUpInside];	
    [detailView addSubview:minusBtn];
    
    UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    plusBtn.frame= CGRectMake(136,408,40,40);
    plusBtn.tag = value;
    [plusBtn setImage:[UIImage imageNamed:@"Addbutton.png"] forState:UIControlStateNormal];
    [plusBtn addTarget:self action:@selector(incremantAction2:) forControlEvents:UIControlEventTouchUpInside];	
    [detailView addSubview:plusBtn];
    
    itemBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    itemBtn1.frame= CGRectMake(89,408,40,40);
    [itemBtn1 setBackgroundImage:[UIImage imageNamed:@"number_butan_1.png"] forState:UIControlStateNormal];
    [itemBtn1 setTitle: [[appDelegate.quantityArray objectAtIndex:value] stringValue] forState:UIControlStateNormal];
    [itemBtn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [detailView addSubview:itemBtn1];
    [self.view addSubview:detailView];
    
}

-(IBAction)incremantAction2:(id)sender{
    
    if (appDelegate.isGuest == YES && appDelegate.isActive == YES) {
        
            int correctIndex = [sender tag];
            int old = [[appDelegate.quantityArray objectAtIndex:correctIndex] intValue];
            [appDelegate.quantityArray replaceObjectAtIndex:correctIndex withObject:[NSNumber numberWithInt:old + 1]];
            
            NSString *serviceID = [appDelegate.serviceIdArray objectAtIndex:correctIndex];
            NSString *qnty = [appDelegate.quantityArray objectAtIndex:correctIndex];
            
            NSMutableDictionary *response = [BKAPIClient addtoCartItem:serviceID guestId:appDelegate.appLoginId quantity:qnty menuId:@"4"];
            appDelegate.totalArray = [response valueForKey:@"Total"]; 
            
            [itemBtn1 setTitle: [[appDelegate.quantityArray objectAtIndex:correctIndex] stringValue] forState:UIControlStateNormal];
        
    }else{
        
        proAlertView *alert = [[proAlertView alloc]initWithTitle:@"Alert" message:@"Please, Login First" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert setBackgroundColor:[UIColor colorWithRed:0.129 green:0.129 blue:0.129 alpha:1.0] withStrokeColor:[UIColor colorWithHue:0.625 saturation:0.0 brightness:0.8 alpha:0.8]];
        [alert show];
        [alert release];            
    }
}

-(IBAction)decreamentAction2:(id)sender{
    
    if (appDelegate.isGuest == YES && appDelegate.isActive == YES) {
        
            int correctIndex = [sender tag];
            int old = [[appDelegate.quantityArray objectAtIndex:correctIndex] intValue];
            
            if (old > 0) {
                [appDelegate.quantityArray replaceObjectAtIndex:correctIndex withObject:[NSNumber numberWithInt:old - 1]];
            }
            
            NSString *serviceID = [appDelegate.serviceIdArray objectAtIndex:correctIndex];
            NSString *qnty = [appDelegate.quantityArray objectAtIndex:correctIndex];
            
            NSMutableDictionary *response = [BKAPIClient addtoCartItem:serviceID guestId:appDelegate.appLoginId quantity:qnty menuId:@"4"];
            appDelegate.totalArray = [response valueForKey:@"Total"];  
            
            [itemBtn1 setTitle: [[appDelegate.quantityArray objectAtIndex:correctIndex] stringValue] forState:UIControlStateNormal];
    } else{
        
        proAlertView *alert = [[proAlertView alloc]initWithTitle:@"Alert" message:@"Please, Login First" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert setBackgroundColor:[UIColor colorWithRed:0.129 green:0.129 blue:0.129 alpha:1.0] withStrokeColor:[UIColor colorWithHue:0.625 saturation:0.0 brightness:0.8 alpha:0.8]];
        [alert show];
        [alert release]; 
        
    }
    
}

- (void)removeDetailView:(id)sender{

    [menuTableView reloadData];
    [detailView removeFromSuperview];
    
}
          

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {  
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached mainDataArray, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    myTimer = nil;
	//remove from notification
	[[NSNotificationCenter defaultCenter] removeObserver:self];

}


- (void)dealloc {

	//remove from notification
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    
	[menuId release];
    [menuTitle release];
	[mainDataArray release]; 
    [menuName release];
	[aTableView release];
    [menuTableView release];
	[popView release];
    [myTimer release];
    [lblTotal release];
//    [txtloginId release];
//    [loginView release];
//    [logOutBtn release];
    
    [detailView release];
    [itemBtn1 release];
    [cell1 release];
    
    [cartView release];
    [popupView release];
    [pickerView release];
    [doneBtn release];
    [cancelBtn release];
	[cartTableView release];
    [minTime release];
    [hoursTime release];
    //[arrayMinutes release];
    [arrayColors release];
    
    [fServiceIdArray release];
    [fNameArray release];
    [fSortDetailArray release];
    [fLongDetailArray release];
    [fRateArray release];
    [fQuantityArray release];
    [lblTotal release];
    [deliverTime release];
//    [weatherView release];
  
	[super dealloc];
}


@end
