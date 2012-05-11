    //
//  WakeUpCallView.m
//  Eye
//
//  Created by Blynk Systems on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WakeUpCallView.h"
#import "MessageView.h"
#import "EyeAppDelegate.h"
#import "HelpView.h"
#import "BKAPIClient.h"
#import "proAlertView.h"

@implementation WakeUpCallView

@synthesize oneDayButton,everyTimeButton;
@synthesize serviceId,checkboxSelected;
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
    
    [self Colors];
    [self Minutes];
    [self partTime];
	oneDayButton = [[UIButton alloc] initWithFrame:CGRectMake(515,295,40, 40)];  
	[oneDayButton setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
	[oneDayButton addTarget:self action:@selector(toggleButton:) forControlEvents: UIControlEventTouchUpInside];
	oneDayButton.tag = 101;
	[oneDayButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
	[oneDayButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 20.0, 0.0, 0.0)];
    [self.view addSubview:oneDayButton];
	
	everyTimeButton = [[UIButton alloc] initWithFrame:CGRectMake(515,330,40, 40)];  
	[everyTimeButton setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
	[everyTimeButton addTarget:self action:@selector(toggleButton:) forControlEvents: UIControlEventTouchUpInside];
	[everyTimeButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
	[everyTimeButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 20.0, 0.0, 0.0)];
	everyTimeButton.tag = 102;
    [self.view addSubview:everyTimeButton];
	 
	hoursTime = @"OO";
	minTime = @"00";
	intTime = @" ";
	oneDay = NO;

	[oneDayButton release];
	[everyTimeButton release];
	
}

- (void)toggleButton: (id) sender
{
    
    checkboxSelected = !checkboxSelected;
    UIButton* check = (UIButton*) sender;
	NSInteger i = [sender tag];
	
    if (checkboxSelected == NO){
        [check setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
	}
    else{
        [check setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateNormal];
		if(i==101){
			oneDay = YES;
		}else {
			oneDay = NO;	
		}
	}
	    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
  
}

- (void)viewWillDisappear:(BOOL)animated{
    
}



-(IBAction)removeView{
	
	[self.view removeFromSuperview];
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

- (void)partTime{
    
    intervalArray = [[NSMutableArray alloc] init];
	[intervalArray addObject:@"AM"];
	[intervalArray addObject:@"PM"];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	
	return 3;
}


- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0)
    {
        return [arrayColors count];
    }
    else  if (component == 1)
    {
        return [arrayMinutes count];
        
    }else{
        
        return [intervalArray count];
    }

}
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	

	if (component == 0)
    {
		return [arrayColors objectAtIndex:row];   
        
	} else  if (component == 1){
        
        return [arrayMinutes objectAtIndex:row]; 
    }
    else
    {
		return [intervalArray objectAtIndex:row];   
    }
	
}
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	
	
	if  (component == 0)
    {
         NSLog(@"you selected a %@", [arrayColors objectAtIndex:row]);
         hoursTime = [arrayColors objectAtIndex:row];
    }
    else  if (component == 1){
        
         NSLog(@"you selected a %@", [arrayMinutes objectAtIndex:row]);
         minTime = [arrayMinutes objectAtIndex:row]; 
    }

    else
    {
         NSLog(@"you selected the color %@", [intervalArray objectAtIndex:row]);
         intTime = [intervalArray objectAtIndex:row];   
    }
      if (oneDay == YES) {
		   wakeupTime = [NSString stringWithFormat:@"%@:%@ %@ %@",hoursTime,minTime,intTime,lblOneDay.text];
	  }else {
		  wakeupTime = [NSString stringWithFormat:@"%@:%@ %@ %@",hoursTime,minTime,intTime,lblEveryDay.text];
	  }
      [wakeupTime retain];
}

-(IBAction)wakeUpAction:(id)sender{
    
     EyeAppDelegate *appDelegate = (EyeAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    if (appDelegate.isGuest == YES && appDelegate.isActive == YES) {
    
      NSMutableDictionary *response = [BKAPIClient sendMenuResponce:@"2" guestId:appDelegate.appLoginId serviceId:serviceId info:wakeupTime];
         
  
	    NSString *message = [response valueForKey:@"notification_name"];
        
        proAlertView *popAlert = [[proAlertView alloc]initWithTitle:message message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [popAlert setBackgroundColor:[UIColor colorWithRed:0.129 green:0.129 blue:0.129 alpha:1.0] withStrokeColor:[UIColor colorWithHue:0.625 saturation:0.0 brightness:0.8 alpha:0.8]];
        [popAlert show];
        [popAlert release]; 
        
    appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate messageService];

    }else{
        
        proAlertView *alert = [[proAlertView alloc]initWithTitle:@"Alert" message:@"Please, Login First" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert setBackgroundColor:[UIColor colorWithRed:0.129 green:0.129 blue:0.129 alpha:1.0] withStrokeColor:[UIColor colorWithHue:0.625 saturation:0.0 brightness:0.8 alpha:0.8]];
        [alert show];
        [alert release];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        [self.view removeFromSuperview];
    }else{
        [self.view removeFromSuperview];

    }
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {  
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    
    [super dealloc];
    [intTime release];
    [minTime release];
    [hoursTime release];
    [arrayMinutes release];
    [arrayColors release];
    [intervalArray release];
    [serviceId release];
}


@end
