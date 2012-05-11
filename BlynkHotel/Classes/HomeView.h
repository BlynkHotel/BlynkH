//
//  HomeView.h
//  Eye
//
//  Created by Blynk Systems on 08/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncDownloader.h"
 
@class EyeAppDelegate;
@class RoomServiceView;
@class HouseKeepingView;
@class HotelInformationView;
@class InRoomServiceView;
@class TravelDeskView;
@class LaundryView;
@class ShoppingView;
@class CustomBadge;

@interface HomeView : UIViewController <UIActionSheetDelegate,UITextFieldDelegate, AsyncDownloaderDelegate> {

	UIAlertView *alert;
	UIButton *iconButton;
	UIButton *itemButton;
	UILabel *lblTitle;
	UISegmentedControl *segmentedControl;
//    UIView *loginView;
//    UITextField *txtloginId;
    
//    UIView *weatherView;
    UIView *expressCheckOutView;
    NSString *tempMessage;
//    IBOutlet UIButton *weatherBtn;

	EyeAppDelegate *appDelegate;
    RoomServiceView *aRoomServiceView;
    HouseKeepingView *aHouseKeepingView;
    HotelInformationView *aHotelInformationView;
    InRoomServiceView *aInRoomServiceView;
    TravelDeskView *aTravelDeskView;
    LaundryView *aLaundryView;
    ShoppingView *aShoppingView;
    CustomBadge *customBadge1;
    
    int i;
    int t;
    NSTimer *myTimer;
    
    UIView *aAlertView;
    UILabel *lblMessage;

//	IBOutlet UILabel *lblGuestName;
//	IBOutlet UILabel *lblGuestId;
	IBOutlet UIImageView *logoView;
	IBOutlet UIImageView *backImageView;
//    IBOutlet UILabel *lblDate;
//    IBOutlet UILabel *lblTime;
    IBOutlet UIImageView *addImageView;
    IBOutlet UILabel *mainText;
    IBOutlet UILabel *smallText;
    
//    IBOutlet UIButton *loginBtn;
    IBOutlet UIButton *helpBtn;
//    IBOutlet UIButton *messageBtn;
//    UIButton *logOutBtn;

	NSMutableArray *menuNameArray;
	NSMutableArray *menuImageArray;
    NSMutableArray *menuIdArray;
    NSMutableArray *requestArray;
    NSMutableArray *templateTypeArray;

    NSMutableArray *addImageArray;
    NSMutableArray *smallTextArray;
    NSMutableArray *bigTextArray;
   
}
@property(nonatomic,retain)NSMutableArray *menuNameArray;
@property(nonatomic,retain)NSMutableArray *menuImageArray;
@property(nonatomic,retain)NSMutableArray *menuIdArray;
@property(nonatomic,retain)NSMutableArray *addImageArray;
@property(nonatomic,retain)NSMutableArray *smallTextArray;
@property(nonatomic,retain)NSMutableArray *bigTextArray;
@property(nonatomic,retain)NSMutableArray *requestArray;
@property(nonatomic,retain)NSMutableArray *templateTypeArray;

- (void)displayHomeView;
//- (void)displayGuestDetail;
//- (IBAction)weatherAction;
//- (IBAction)messageAction;
- (IBAction)dsiplayHelpView;
//- (IBAction)loginView:(id)sender;

- (void) displayBottomAdd;
- (void) displaySideAdd;
//- (void) setCustomBadge;
- (void) displayAddImage;
- (void)displayExpressCheckOut;
//- (void)displayLogout;
//-(void)customBadgeUpdated;
//-(void)receivedGuestDetails;
-(void)loadHomeView;
-(void)stopAct;
@end
