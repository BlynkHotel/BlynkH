//
//  Template6.h
//  Eye4
//
//  Created by Blynk Systems on 28/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Template6 : UIViewController{
    
    IBOutlet UIWebView *aWebView;
    IBOutlet UIImageView *photoImage;
    IBOutlet UITextView *txtDetail;
    IBOutlet UILabel *lblTitle;

    
//    NSString *title1;
//    NSString *textDetail;
//    NSString *photo;
//    NSString *webLink;
}
//@property(nonatomic,retain)NSString *title1;
//@property(nonatomic,retain)NSString *textDetail;
//@property(nonatomic,retain) NSString *photo;
//@property(nonatomic,retain) NSString *webLink;
-(void)setLabelText:(NSString*)txt;
-(void)setTextViewText:(NSString*)txt;
-(void)setPhotoUrlString:(NSString*)urlString;
-(IBAction)removeMenuView:(id)sender;
-(void)loadWebViewWith:(NSString*)webLink;

@end
