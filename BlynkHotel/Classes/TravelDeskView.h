//
//  TravelDeskView.h
//  Eye
//
//  Created by Blynk Systems on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EyeAppDelegate,CustomBadge;
@interface TravelDeskView : UIViewController <UITextFieldDelegate,UIAlertViewDelegate,UIActionSheetDelegate>{
	
    UIView *weatherView;
//    IBOutlet UIButton *weatherBtn;
//    CustomBadge *customBadge1;
//    UIButton *logOutBtn;
    
//	IBOutlet UILabel *lblGuestName;
//	IBOutlet UILabel *lblGuestId;
//    IBOutlet UILabel *lblDate;
//    IBOutlet UILabel *lblTime;
//    UIView *loginView;
//    UITextField *txtloginId;
//    IBOutlet UIButton *loginBtn;
//    IBOutlet UIButton *helpBtn;
    
    IBOutlet UIImageView *logoView;
    IBOutlet UIImageView *backImageView;
    IBOutlet UIImageView *addImage;
    IBOutlet UILabel *smallText;
    IBOutlet UILabel *mainText;
    
	UIAlertView *alert;
	UIView *aAlertView;
	UILabel *lblMessage;
	
	UIButton *iconButton;
	UIButton *itemButton;
	UILabel *lblTitle;

    NSString *serviceId;
    NSString *serviceName;
	EyeAppDelegate *appDelegate;
	NSString *menuId;
	NSString *menuTitle;
    int t;
    NSTimer *myTimer;

}

@property(nonatomic,retain)NSString *menuId;
@property(nonatomic,retain)NSString *serviceId;
@property(nonatomic,retain)NSString *menuTitle;

- (IBAction)backToHome;
//- (IBAction)weatherAction;
//- (IBAction)messageAction;
- (IBAction)displayHelpView;
//- (IBAction)loginView:(id)sender;

- (void) displaySubMenu;
//- (void) displayLoginView;
//- (void) setCustomBadge;
//- (void)displayLogout;
//-(void)customBadgeUpdated;
//-(void)receivedGuestDetails;

@end
