
#import <Foundation/Foundation.h>

#import "NSString+SBJSON.h"

@interface BKAPIClient : NSObject {
	
	NSURLConnection		* connection;
	
}

+ (NSMutableDictionary *)loadBackgroundImage;
+ (NSMutableDictionary *)loadHetelLogo;
+ (NSMutableDictionary *)loadgradientImage;
+ (NSMutableDictionary *)loadMainHomeMenuView;
+ (NSArray *)loadSubMenuView:(NSString*)menuId;
+ (NSMutableDictionary *)checkDataUpdation:(NSString*)uid;
+ (NSMutableDictionary *)deviceInformation:(NSString*)dId deviceName:(NSString*)dName systemName:(NSString*)sName 
                             SystemVersion:(NSString*)sVersion systemModel:(NSString*)model localModel:(NSString*)lModel;
+ (NSMutableDictionary *)loadGuestDetail:(NSString*)guestId;
//+ (NSMutableDictionary *)loadWebDataWithAboutUs;
+ (NSMutableDictionary *)loadPhotoGalleryImages:(NSString*)amentyId;
+ (NSMutableDictionary *)sendMenuResponce:(NSString*)menuId guestId:(NSString*)gId serviceId:(NSString*)sId
                                     info:(NSString*)detail;
+ (NSMutableDictionary *)homePageImageAdd;
+ (NSMutableDictionary *)rootMenuitem:(NSString*)mId;  
+ (NSMutableDictionary *)addtoCartItem:(NSString*)serviceId guestId:(NSString*)gId quantity:(NSString*)qty menuId:(NSString*)mId;
+ (NSMutableDictionary *)updateQuantityItem:(NSString*)mId guestId:(NSString*)gId serviceName:(NSString*)sName;
+ (NSMutableDictionary *)viewCartItem:(NSString*)mId guestId:(NSString*)gId;
+ (NSMutableDictionary *)removeItemFromCart:(NSString*)mId guestId:(NSString*)gId serviceId:(NSString*)sId;
+ (NSMutableDictionary *)checkout:(NSString*)gId menuId:(NSString*)mId specialInt:(NSString*)sint deliverTime:(NSString*)dTime;
+ (NSMutableDictionary *)shoppingTemplate:(NSString*)mId serviceName:(NSString*)sId;
+ (NSMutableDictionary *)bottomAdd:(NSString*)menuId;    
+ (NSMutableDictionary *)loadMenuDetail:(NSString*)serviceName menuId:(NSString*)mId;
+ (NSMutableDictionary *)hotelInfoAboutUs:(NSString*)serviceId; 
+ (NSMutableDictionary *)hotelReservation;
+ (NSMutableDictionary *)guestMessageNotification:(NSString*)guestId;
+ (NSMutableDictionary *)changeMessageStatus:(NSString*)tId;
+ (NSMutableDictionary *)loadWeatherAPI;
+ (NSMutableDictionary *)loadDisclaimer:(NSString*)menuId;
+ (NSMutableDictionary *)setCurrenncy;
+ (NSMutableDictionary *)loadMapAddress;


+ (NSMutableDictionary *)loadRoomServicesAPI;            
@end
