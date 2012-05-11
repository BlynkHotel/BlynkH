//
//  DisplayView.h
//  Eye4
//
//  Created by Blynk Systems on 13/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EyeAppDelegate;
@class Template1;
@class Template2;
@class Template3;
@class Template4;
@class Template5;
@class Template6;
@class CustomBadge;
@interface DisplayView : UIViewController <UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>{
    
//    UIView *loginView;
//    UITextField *txtloginId;
//    IBOutlet UIButton *loginBtn;
    IBOutlet UIButton *helpBtn;
//    UIButton *logOutBtn;

//    UIView *weatherView;
//    IBOutlet UIButton *weatherBtn;
//    CustomBadge *customBadge1;
    
//    IBOutlet UILabel *lblGuestName;
//	IBOutlet UILabel *lblGuestId;
//    IBOutlet UILabel *lblDate;
//    IBOutlet UILabel *lblTime;
    
    IBOutlet UIImageView *logoView;
    IBOutlet UIImageView *backImageView;
    IBOutlet UIImageView *addImage;
    IBOutlet UILabel *firstText;
    IBOutlet UILabel *secondText;
    IBOutlet UIView *popView;
    IBOutlet UITableView *aTableView;
      
	EyeAppDelegate *appDelegate;
    NSString *menuId;
    NSString *serviceId;
	    
	int i;
    int t;
    NSTimer *myTimer;
	
	NSMutableArray *nameArray;
	NSMutableArray *detailArray;
	NSMutableArray *menuImageArray;
	NSMutableArray *videoArray;
    NSMutableArray *templateArray;
    NSMutableArray *webLinkArray;
    NSMutableArray *amenityArray;
    
   Template1 *aTemplate1;
   Template2 *aTemplate2;
   Template3 *aTemplate3;
   Template4 *aTemplate4;
   Template5 *aTemplate5;
   Template6 *aTemplate6;
   	
	
}

@property(nonatomic,retain)NSMutableArray *videoArray;
@property(nonatomic,retain)NSMutableArray *nameArray;
@property(nonatomic,retain)NSMutableArray *detailArray;
@property(nonatomic,retain)NSMutableArray *menuImageArray;
@property(nonatomic,retain)NSMutableArray *webLinkArray;
@property(nonatomic,retain)NSMutableArray *templateArray;
@property(nonatomic,retain)NSMutableArray *amenityArray;
@property (nonatomic, retain) NSString *serviceId;

- (IBAction)backToHome;
//- (IBAction)weatherAction;
//- (IBAction)messageAction;
//- (IBAction)displayHelpView;
//- (IBAction)loginView:(id)sender;
//
//- (void)setCustomBadge;
//- (void)displayGuestDetail;
//- (void)displayLoginView;
//- (void)displayLogout;
////-(void)customBadgeUpdated;
//-(void)receivedGuestDetails;

@end
