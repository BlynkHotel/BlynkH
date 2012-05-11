//
//  MessageView.h
//  Eye4
//
//  Created by iMac2 on 03/12/11.
//  Copyright 2011 Hemlines. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EyeAppDelegate;
@class CustomBadge;

@interface MessageView : UIViewController <UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>{

//    IBOutlet UILabel *lblGuestName;
//	IBOutlet UILabel *lblGuestId;
//    IBOutlet UILabel *lblDate;
//    IBOutlet UILabel *lblTime;
    IBOutlet UILabel *lblRequestTime;
    IBOutlet UILabel *lblCompletedTime;
    IBOutlet UIButton *statusBtn;
   
    IBOutlet UIImageView *logoView;
    IBOutlet UIImageView *backImageView;
    IBOutlet UIImageView *addImage;
    IBOutlet UILabel *firstText;
    IBOutlet UILabel *secondText;
    IBOutlet UIView *popView;
    IBOutlet UIView *infoView;
    IBOutlet UITableView *aTableView;
    
    IBOutlet UIWebView *aWebView;
    IBOutlet UILabel *lblTitle;
    
//    IBOutlet UIButton *loginBtn;
//    UIView *loginView;
//    UIButton *logOutBtn;
//    UITextField *txtloginId;
    
//    UIView *weatherView;
//    IBOutlet UIButton *weatherBtn;
//    IBOutlet UIButton *helpBtn;
//    IBOutlet UIButton *messageBtn;
    
	EyeAppDelegate *appDelegate;
    CustomBadge *customBadge1;
    
    NSString *menuId;
    NSString *serviceId;
    
    int i;
    int t;
    NSTimer *myTimer;
    NSString *html;
	
}

@property (nonatomic, retain) NSString *serviceId;

- (IBAction)backToHome;
//- (IBAction)weatherAction;
- (IBAction)displayHelpView;
//- (IBAction)loginView:(id)sender;
-(IBAction)removeMenuView:(id)sender;

- (void)loadInfoView;
//- (void)displayGuestDetail;
//- (void)setCustomBadge;
//- (void)displayLoginView;
//- (void)displayLogout;
//-(void)customBadgeUpdated;
//-(void)receivedGuestDetails;

@end
