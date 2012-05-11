//
//  RoomServiceView.h
//  Eye
//
//  Created by Blynk Systems on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EyeAppDelegate;
@class CustomBadge;
@interface RoomServiceView : UIViewController <UIActionSheetDelegate,UIAlertViewDelegate,UITextFieldDelegate>{
	
//    CustomBadge *customBadge1;
//	IBOutlet UILabel *lblGuestName;
//	IBOutlet UILabel *lblGuestId;
    
//    IBOutlet UILabel *lblDate;
//    IBOutlet UILabel *lblTime;
//   
//    UIView *weatherView;
//    IBOutlet UIButton *weatherBtn;
    
    IBOutlet UIImageView *logoView;
    IBOutlet UIImageView *backImageView;
    IBOutlet UILabel *mainText;
    IBOutlet UILabel *smallText;
    IBOutlet UIImageView *addImage;
    
    int t;
    NSTimer *myTimer;

	UIAlertView *alert;
	UIView *aAlertView;
	UILabel *lblMessage;
	
//    IBOutlet UIButton *loginBtn;
//    IBOutlet UIButton*helpBtn;
//    UIButton *logOutBtn;
//    UIView *loginView;
//    UITextField *txtloginId;

	UIButton *iconButton;
	UIButton *itemButton;
	UILabel *lblTitle;
	
    NSString *serviceId;
	EyeAppDelegate *appDelegate;
	NSString *menuId;
    NSString *menuTitle;
    NSString *serviceName;
    
}

@property(nonatomic,retain)NSString *menuId;
@property(nonatomic,retain)NSString *serviceId;
@property(nonatomic,retain)NSString *menuTitle;

-(IBAction)backToHome;
-(IBAction)WakeUpCallView;
//-(IBAction)weatherAction;
//-(IBAction)messageAction;
-(IBAction)displayHelpView;
-(void)displaySubMenu;
//-(void)displayGuestDetail;
//-(IBAction)loginView:(id)sender;

//- (void) displayLoginView;
//- (void) setCustomBadge;
//- (void)displayLogout;

//-(void)customBadgeUpdated;
//-(void)receivedGuestDetails;
-(IBAction)noBtnAction;

@end
