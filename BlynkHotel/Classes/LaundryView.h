//
//  LaundryView.h
//  Eye
//
//  Created by Blynk Systems on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EyeAppDelegate;
@class CustomBadge;
@interface LaundryView : UIViewController <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate,UITextViewDelegate>{


    IBOutlet UIButton *helpBtn;

    UIView *detailView;
    NSString *cell1;
    UIButton *itemBtn1;
    
	NSMutableArray  *mainDataArray;
 
    IBOutlet UIView *menuView;
    IBOutlet UITableView *menuTableView;
    IBOutlet UILabel *lblTotal;
    IBOutlet UILabel *lblTitle;
   
	NSString *menuId;
    NSString *menuTitle;
    NSString *menuName;
	EyeAppDelegate *appDelegate;
    int i;
    int t;
    NSTimer *myTimer;
	
    BOOL isDisplayView;
    IBOutlet UIImageView *logoView;
    IBOutlet UIImageView *backImageView;
	IBOutlet UIView *popView;
	IBOutlet UITableView *aTableView;
//	IBOutlet UILabel *lblGuestName;
//	IBOutlet UILabel *lblGuestId;
//    IBOutlet UILabel *lblTime;
//    IBOutlet UILabel *lblDate;
    
    IBOutlet UILabel *firstText;
    IBOutlet UILabel *secondText;
    IBOutlet UIImageView *addImage;
    
    UIView *cartView;
    UIScrollView *aScrollView;
    UITableView *cartTableView;
    UILabel *lblTitle1;
    UILabel *lblTotal1;
    UITextView *txtSuggestion;
    NSMutableArray *fServiceIdArray;
    NSMutableArray *fNameArray;
    NSMutableArray *fRateArray;
    NSMutableArray *fSortDetailArray;
    NSMutableArray *fLongDetailArray;
    NSMutableArray *fQuantityArray;
    UIButton *doneBtn;
    UIButton *cancelBtn;
    UIPickerView *pickerView;
    UIView *popupView;
    UILabel *deliverTime;
    UILabel *lblhrs;
    UILabel *lblmin;
    int selectedRow1;
    int selectedRow2;
    NSMutableArray *arrayColors;
    NSMutableArray *arrayMinutes;
    NSString *hoursTime;
    NSString *minTime;

}
@property(nonatomic,retain)NSMutableArray *mainDataArray;
@property(nonatomic,retain)NSString *menuId;
@property(nonatomic,retain) NSString *menuName;

@property(nonatomic,retain) NSMutableArray *fServiceIdArray;
@property(nonatomic,retain) NSMutableArray *fNameArray;
@property(nonatomic,retain) NSMutableArray *fRateArray;
@property(nonatomic,retain) NSMutableArray *fSortDetailArray;
@property(nonatomic,retain) NSMutableArray *fLongDetailArray;
@property(nonatomic,retain) NSMutableArray *fQuantityArray;
@property(nonatomic,retain) NSString *menuTitle;

-(IBAction)removeMenuView:(id)sender;
//-(IBAction)loginView:(id)sender;
-(IBAction)viewCartAction;
-(IBAction)backToHome;
//-(IBAction)weatherAction;
//-(IBAction)messageAction;
-(IBAction)displayHelpView;

//- (void)displayLogout;
//- (void) displayLoginView;
//- (void) setCustomBadge;
//- (void) displayGuestDetail;
- (void) treeView;
- (void) displayDetailView;
- (void) displayViewCart;
- (void) viewCartService;
- (void) Colors;
- (void) Minutes;
//-(void)customBadgeUpdated;
//-(void)receivedGuestDetails;

@end