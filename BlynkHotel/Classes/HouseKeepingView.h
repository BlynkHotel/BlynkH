//
//  HouseKeepingView.h
//  Eye
//
//  Created by Blynk Systems on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EyeAppDelegate,CustomBadge;
@interface HouseKeepingView : UIViewController <UITextFieldDelegate,UIAlertViewDelegate,UIActionSheetDelegate> {
    
//    UIView *loginView;
//    UITextField *txtloginId;
//    IBOutlet UIButton *loginBtn;
//    IBOutlet UIButton *helpBtn;
//    UIButton *logOutBtn;
    
//    UIView *weatherView;
//    IBOutlet UIButton *weatherBtn;
//    CustomBadge *customBadge1;
    
//    IBOutlet UILabel *lblGuestName;
//	IBOutlet UILabel *lblGuestId;
//    IBOutlet UILabel *lblDate;
//    IBOutlet UILabel *lblTime;

	UIAlertView *alert;
	UIView *aAlertView;
	UILabel *lblMessage;
	
    IBOutlet UIImageView *logoView;
    IBOutlet UIImageView *backImageView;
    IBOutlet UIImageView *addImage;
    IBOutlet UILabel *mainText;
    IBOutlet UILabel *smallText;
    
    EyeAppDelegate *appDelegate;
	
    NSString *serviceId;
    NSString *serviceName;
	
	UIButton *iconButton;
	UIButton *itemButton;
	UILabel *lblTitle;
	NSString *menuId;
    NSString *menuTitle;
    int t;
    NSTimer *myTimer;

}

@property(nonatomic,retain)NSString *menuId;
@property(nonatomic,retain)NSString *serviceId;
@property(nonatomic,retain)NSString *menuTitle;

//-(IBAction)loginView:(id)sender;
-(IBAction)backToHome;
//-(IBAction)weatherAction;
//-(IBAction)messageAction;
//-(IBAction)displayHelpView;
//
//- (void) displayLoginView;
//- (void) setCustomBadge;
- (void) displaySubMenu;
//- (void) displayGuestDetail;
//- (void)displayLogout;
//-(void)customBadgeUpdated;
//-(void)receivedGuestDetails;

@end
