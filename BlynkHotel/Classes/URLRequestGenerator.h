//
//  URLGenerator.h
//  BlynkHotel
//
//  Created by iMac2 on 11/04/12.
//  Copyright 2012 Hemlines. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface URLRequestGenerator : NSObject {

}

+(NSURLRequest*)requestToGetAdImageOnHomePage;
+(NSURLRequest*)requestToGetGuestMessageNotificationForGuestId:(NSString*)guestId;
+(NSURLRequest*)requestToGetGuestDetails:(NSString*)guestId;
+(NSURLRequest*)requestToGetSubMenuDetails:(NSString*)subMenuId;
+(NSURLRequest*)requestToGetBottomAdDetails:(NSString*)menuId;

+(NSURLRequest*)requestToGetShoppingTemplateWithMenuId:(NSString*)mId serviceName:(NSString*)sId;
+(NSURLRequest*)requestToLoadBackgroundImage;
+(NSURLRequest*)requestToLoadGradientImage;
+(NSURLRequest*)requestToLoadHotelLogo;
+(NSURLRequest*)requestToCheckDataUpdationWithId:(NSString*)uid;
+(NSURLRequest*)requestToLoadMainHotelMenu;
+(NSURLRequest*)requestToSendMenuResponse:(NSString*)menuId guestId:(NSString*)gId serviceId:(NSString*)sId info:(NSString*)detail;
+(NSURLRequest*)requestToLoadMenuDetail:(NSString*)serviceName menuId:(NSString*)mId;
+(NSURLRequest*)requestToGetHotelInfoAboutUs:(NSString*)serviceId;
+(NSURLRequest*)requestToGetHotelReservation;
+(NSURLRequest*)requestToLoadPhotoGalleryImages:(NSString*)amentyId;
+(NSURLRequest*)requestToAddtoCartItem:(NSString*)serviceId guestId:(NSString*)gId quantity:(NSString*)qty menuId:(NSString*)mId;
+(NSURLRequest*)requestToUpdateQuantityItem:(NSString*)mId guestId:(NSString*)gId serviceName:(NSString*)sName;
+(NSURLRequest*)requestToViewCartItem:(NSString*)mId guestId:(NSString*)gId;
+(NSURLRequest*)requestToRemoveItemFromCart:(NSString*)mId guestId:(NSString*)gId serviceId:(NSString*)sId;
+(NSURLRequest*)requestToDeviceInformation:(NSString*)dId deviceName:(NSString*)dName systemName:(NSString*)sName 
                  SystemVersion:(NSString*)sVersion systemModel:(NSString*)model localModel:(NSString*)lModel;
+(NSURLRequest*)requestToCheckout:(NSString*)gId menuId:(NSString*)mId specialInt:(NSString*)sint deliverTime:(NSString*)dTime;
+(NSURLRequest*)requestToChangeMessageStatus:(NSString*)tId;
+(NSURLRequest*)requestToLoadDisclaimer:(NSString*)menuId;
+(NSURLRequest*)requestToLoadMapAddress;
+(NSURLRequest*)requestToSetCurrenncy;
+(NSURLRequest*)requestToLoadWeatherAPI;

+(NSURLRequest*)requestToLoadRoomServicesAPI;
@end
