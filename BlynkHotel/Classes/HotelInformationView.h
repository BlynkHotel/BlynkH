//
//  HotelInformationView.h
//  Eye
//
//  Created by Blynk Systems on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EyeAppDelegate;
@class ShowMapView;
@class HotelReservation;
@class DisplayView;
@class CustomBadge;
@interface HotelInformationView : UIViewController <UITextFieldDelegate,UIAlertViewDelegate>{
    
//    UIView *loginView;
//    UITextField *txtloginId;
//    IBOutlet UIButton *loginBtn;
    IBOutlet UIButton *helpBtn;
    
//    UIView *weatherView;
//    IBOutlet UIButton *weatherBtn;
//    CustomBadge *customBadge1;
//    UIButton *logOutBtn;

//	IBOutlet UILabel *lblGuestName;
//	IBOutlet UILabel *lblGuestId;
//    IBOutlet UILabel *lblDate;
//    IBOutlet UILabel *lblTime;
    
    IBOutlet UIImageView *logoView;
    IBOutlet UIImageView *backImageView;
    IBOutlet UIImageView *addImage;
    IBOutlet UILabel *mainText;
    IBOutlet UILabel *smallText;

	EyeAppDelegate *appDelegate;
    DisplayView *aDisplayView;
	
	UIAlertView *alert;
    NSString *serviceId;
    NSString *serviceName;
    
	UIButton *iconButton;
	UIButton   *itemButton;
	UILabel *lblTitle;
	NSString *menuId;
   	NSString *menuTitle;
    int t;
    NSTimer *myTimer;
	
	ShowMapView *aShowMapView;
	HotelReservation *aHotelReservation;
	
}

@property(nonatomic,retain)NSString *menuId;
@property(nonatomic,retain)NSString *serviceId;
@property(nonatomic,retain)NSString *menuTitle;

- (IBAction)backToHome;
//- (IBAction)weatherAction;
//- (IBAction)messageAction;
- (IBAction)displayHelpView;
- (void)displaySubMenu;
//- (IBAction)loginView:(id)sender;

//- (void) displaySubMenu;
//- (void) displayLoginView;
//- (void) setCustomBadge;
//- (void) displayGuestDetail;
//- (void)displayLogout;

//-(void)customBadgeUpdated;
//-(void)receivedGuestDetails;
@end
