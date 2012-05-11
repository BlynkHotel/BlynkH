//
//  Template5.h
//  Eye4
//
//  Created by Blynk Systems on 28/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Template5 : UIViewController{
    

    IBOutlet UIImageView *photoImage;
    IBOutlet UITextView *txtDetail;
    IBOutlet UILabel *lblTitle;
    
//    NSString *title1;
//    NSString *textDetail;
//    NSString *photo;
}

//@property(nonatomic,retain)NSString *title1;
//@property(nonatomic,retain)NSString *textDetail;
//@property(nonatomic,retain) NSString *photo;
-(IBAction)removeMenuView:(id)sender;
-(void)setLabelText:(NSString*)txt;
-(void)setTextViewText:(NSString*)txt;
-(void)setPhotoUrlString:(NSString*)urlString;
@end
