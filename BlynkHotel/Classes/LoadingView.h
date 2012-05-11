
/* Customised loading(activity) indicator
 */

#import <UIKit/UIKit.h>


@interface LoadingView : UIView
{
    UILabel *loadingLabel;
}

+ (id) loadingViewInView:(UIView *)aSuperview rect:(CGRect)aRect messageText:(NSString *)labelText;
//- (void) setMessageText:(NSString *)labelText;
- (void) removeView;

@property (nonatomic, retain) UILabel *loadingLabel;

@end
