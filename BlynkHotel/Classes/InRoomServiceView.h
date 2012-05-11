//
//  InRoomServiceView.h
//  Eye
//
//  Created by Blynk Systems on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class EyeAppDelegate;
@class MessageView;
@class CustomBadge;

@interface InRoomServiceView : UIViewController <UIPopoverControllerDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIScrollViewDelegate,UITextViewDelegate> {
    
//    UIView *loginView;
//    UITextField *txtloginId;
//    IBOutlet UIButton *loginBtn;
    IBOutlet UIButton *helpBtn;
//    UIView *weatherView;
//    UIButton *logOutBtn;
//    IBOutlet UIButton *weatherBtn;
//    CustomBadge *customBadge1;
    
    NSMutableArray  *mainDataArray;
    UIView *detailView;
    NSString *cell1;
    UIButton *itemBtn1;
    
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

    MessageView *aMessageView;
    IBOutlet UIView *menuView;
    IBOutlet UITableView *menuTableView;
    IBOutlet UITableView *aTableView;
          
    IBOutlet UILabel *lblTitle;
    IBOutlet UILabel *lblTotal;
    
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
//	IBOutlet UILabel *lblGuestName;
//	IBOutlet UILabel *lblGuestId;
//    IBOutlet UILabel *lblTime;
//    IBOutlet UILabel *lblDate;
    
    IBOutlet UILabel *firstText;
    IBOutlet UILabel *secondText;
    IBOutlet UIImageView *addImage;
     
}

@property(nonatomic,retain)NSString *menuId;
@property(nonatomic,retain) NSString *menuName;
@property(nonatomic,retain)NSMutableArray *mainDataArray;
@property(nonatomic,retain) NSMutableArray *fServiceIdArray;
@property(nonatomic,retain) NSMutableArray *fNameArray;
@property(nonatomic,retain) NSMutableArray *fRateArray;
@property(nonatomic,retain) NSMutableArray *fSortDetailArray;
@property(nonatomic,retain) NSMutableArray *fLongDetailArray;
@property(nonatomic,retain) NSMutableArray *fQuantityArray;
@property(nonatomic,retain) NSString *menuTitle;

-(IBAction)viewCartAction;
-(IBAction)backToHome;
//-(IBAction)weatherAction;
//-(IBAction)messageAction;
-(IBAction)displayHelpView;
//-(IBAction)loginView:(id)sender;
-(IBAction)removeMenuView:(id)sender;

//- (void) displayLoginView;
//- (void) setCustomBadge;
//- (void) displayGuestDetail;
- (void) treeView;
//- (void) displayDetailView;
- (void)displayDetailView:(NSIndexPath *)cellPath;
- (void) displayViewCart;
- (void) viewCartService;
- (void) Colors;
- (void) Minutes;
//- (void)displayLogout;
//
//-(void)customBadgeUpdated;
//-(void)receivedGuestDetails;

@end
