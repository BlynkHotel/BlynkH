//
//  URLGenerator.h
//  BlynkHotel
//
//  Created by iMac2 on 11/04/12.
//  Copyright 2012 Hemlines. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface URLGenerator : NSObject {

}
+(NSURL*)urlToLoadAdImageOnHomePage;
+(NSURL*)urlToToGetGuestMessageNotificationForGuestId:(NSString*)guestId;
+(NSURL*)urlToGetGuestDetails:(NSString*)guestId;
+(NSURL*)urlToGetSubMenuDetails:(NSString*)subMenuId;
+(NSURL*)urlToGetBottomAdDetails:(NSString*)menuId;
+(NSString*)urlBase;

+(NSURL*)urlToGetShoppingTemplateWithMenuId:(NSString*)mId serviceName:(NSString*)sId;
+(NSURL*)urlToLoadBackgroundImage;
+(NSURL*)urlToLoadGradientImage;
+(NSURL*)urlToLoadHotelLogo;
+(NSURL*)urlToCheckDataUpdationWithId:(NSString*)uid;
+(NSURL*)urlToLoadMainHotelMenu;
+(NSURL*)urlToSendMenuResponse:(NSString*)menuId guestId:(NSString*)gId serviceId:(NSString*)sId info:(NSString*)detail;
+(NSURL*)urlToLoadMenuDetail:(NSString*)serviceName menuId:(NSString*)mId;
+(NSURL*)urlToGetHotelInfoAboutUs:(NSString*)serviceId;
+(NSURL*)urlToGetHotelReservation;
+(NSURL*)urlToLoadPhotoGalleryImages:(NSString*)amentyId;
+(NSURL*)urlToAddtoCartItem:(NSString*)serviceId guestId:(NSString*)gId quantity:(NSString*)qty menuId:(NSString*)mId;
+(NSURL*)urlToUpdateQuantityItem:(NSString*)mId guestId:(NSString*)gId serviceName:(NSString*)sName;
+(NSURL*)urlToViewCartItem:(NSString*)mId guestId:(NSString*)gId;
+(NSURL*)urlToRemoveItemFromCart:(NSString*)mId guestId:(NSString*)gId serviceId:(NSString*)sId;
+(NSURL*)urlToDeviceInformation:(NSString*)dId deviceName:(NSString*)dName systemName:(NSString*)sName 
                  SystemVersion:(NSString*)sVersion systemModel:(NSString*)model localModel:(NSString*)lModel;
+(NSURL*)urlToCheckout:(NSString*)gId menuId:(NSString*)mId specialInt:(NSString*)sint deliverTime:(NSString*)dTime;
+(NSURL*)urlToChangeMessageStatus:(NSString*)tId;
+(NSURL*)urlToLoadDisclaimer:(NSString*)menuId;
+(NSURL*)urlToLoadMapAddress;
+(NSURL*)urlToSetCurrenncy;
+(NSURL*)urlToLoadWeatherAPI;

+(NSURL*)urlToLoadRoomServicesAPI;
@end
