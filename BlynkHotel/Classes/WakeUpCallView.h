//
//  WakeUpCallView.h
//  Eye
//
//  Created by Blynk Systems on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@class EyeAppDelegate;
@interface WakeUpCallView : UIViewController <UIActionSheetDelegate> {

	BOOL checkboxSelected;
	BOOL oneDay;
    UIButton *oneDayButton;
	UIButton *everyTimeButton;
	IBOutlet UILabel *lblOneDay;
	IBOutlet UILabel *lblEveryDay;

    IBOutlet UIPickerView *pickerView;
	NSMutableArray *arrayColors;
	NSMutableArray *arrayMinutes;
    NSMutableArray *intervalArray;
    NSString *hoursTime;
    NSString *minTime;
    NSString *intTime;
    
    NSString *wakeupTime;
    NSString *serviceId;
	NSString *oneDayString;
	NSString *everyDayString;
	

}
@property(nonatomic,retain) NSString *serviceId;
@property BOOL checkboxSelected;
@property (nonatomic,retain) UIButton *oneDayButton;
@property (nonatomic,retain) UIButton *everyTimeButton;


- (void)partTime;
- (void)Colors;
- (void)Minutes;
-(IBAction)removeView;
//-(IBAction)checkboxButton:(UIButton *)button;
-(IBAction)wakeUpAction:(id)sender;

@end
