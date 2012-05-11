//
//  URLGenerator.m
//  BlynkHotel
//
//  Created by iMac2 on 11/04/12.
//  Copyright 2012 Hemlines. All rights reserved.
//

#import "URLRequestGenerator.h"
#import "URLGenerator.h"


NSTimeInterval timeOut = 60;

@implementation URLRequestGenerator

+(NSURLRequest*)requestToGetAdImageOnHomePage
{

	NSURL *theUrl = [URLGenerator urlToLoadAdImageOnHomePage];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;
}

+(NSURLRequest*)requestToGetGuestMessageNotificationForGuestId:(NSString*)guestId
{
	
	NSURL *theUrl = [URLGenerator urlToToGetGuestMessageNotificationForGuestId:guestId];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;
}

+(NSURLRequest*)requestToGetGuestDetails:(NSString*)guestId
{
	
	NSURL *theUrl = [URLGenerator urlToGetGuestDetails:guestId];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;
}

+(NSURLRequest*)requestToGetSubMenuDetails:(NSString*)subMenuId
{
	
	NSURL *theUrl = [URLGenerator urlToGetSubMenuDetails:subMenuId];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;
}

+(NSURLRequest*)requestToGetBottomAdDetails:(NSString*)menuId
{
	
	NSURL *theUrl = [URLGenerator urlToGetBottomAdDetails:menuId];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;
}

+(NSURLRequest*)requestToGetShoppingTemplateWithMenuId:(NSString*)mId serviceName:(NSString*)sId
{
    NSURL *theUrl = [URLGenerator urlToGetShoppingTemplateWithMenuId:mId serviceName:sId];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;
}
+(NSURLRequest*)requestToLoadBackgroundImage
{
    NSURL *theUrl = [URLGenerator urlToLoadBackgroundImage];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;
}
+(NSURLRequest*)requestToLoadGradientImage
{
    NSURL *theUrl = [URLGenerator urlToLoadGradientImage];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;
}
+(NSURLRequest*)requestToLoadHotelLogo
{
    NSURL *theUrl = [URLGenerator urlToLoadHotelLogo];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;
}
+(NSURLRequest*)requestToCheckDataUpdationWithId:(NSString*)uid
{
    NSURL *theUrl = [URLGenerator urlToCheckDataUpdationWithId:uid];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;
}
+(NSURLRequest*)requestToLoadMainHotelMenu
{
    NSURL *theUrl = [URLGenerator urlToLoadMainHotelMenu];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;
}
+(NSURLRequest*)requestToSendMenuResponse:(NSString*)menuId guestId:(NSString*)gId serviceId:(NSString*)sId info:(NSString*)detail
{
    NSURL *theUrl = [URLGenerator urlToSendMenuResponse:menuId guestId:gId serviceId:sId info:detail];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;
}
+(NSURLRequest*)requestToLoadMenuDetail:(NSString*)serviceName menuId:(NSString*)mId
{
    NSURL *theUrl = [URLGenerator urlToLoadMenuDetail:serviceName menuId:mId];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;
}
+(NSURLRequest*)requestToGetHotelInfoAboutUs:(NSString*)serviceId
{
    NSURL *theUrl = [URLGenerator urlToGetHotelInfoAboutUs:serviceId];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;
}
+(NSURLRequest*)requestToGetHotelReservation
{
    NSURL *theUrl = [URLGenerator urlToGetHotelReservation];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;
}
+(NSURLRequest*)requestToLoadPhotoGalleryImages:(NSString*)amentyId
{
    NSURL *theUrl = [URLGenerator urlToLoadPhotoGalleryImages:amentyId];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;
}
+(NSURLRequest*)requestToAddtoCartItem:(NSString*)serviceId guestId:(NSString*)gId quantity:(NSString*)qty menuId:(NSString*)mId
{
    NSURL *theUrl = [URLGenerator urlToAddtoCartItem:serviceId guestId:gId quantity:qty menuId:mId];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;
}
+(NSURLRequest*)requestToUpdateQuantityItem:(NSString*)mId guestId:(NSString*)gId serviceName:(NSString*)sName
{
    NSURL *theUrl = [URLGenerator urlToUpdateQuantityItem:mId guestId:gId serviceName:sName];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;
}
+(NSURLRequest*)requestToViewCartItem:(NSString*)mId guestId:(NSString*)gId
{
    NSURL *theUrl = [URLGenerator urlToViewCartItem:mId guestId:gId];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;
}
+(NSURLRequest*)requestToRemoveItemFromCart:(NSString*)mId guestId:(NSString*)gId serviceId:(NSString*)sId
{
    NSURL *theUrl = [URLGenerator urlToRemoveItemFromCart:mId guestId:gId serviceId:sId];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;    
}
+(NSURLRequest*)requestToDeviceInformation:(NSString*)dId deviceName:(NSString*)dName systemName:(NSString*)sName 
                             SystemVersion:(NSString*)sVersion systemModel:(NSString*)model localModel:(NSString*)lModel
{
    NSURL *theUrl = [URLGenerator urlToDeviceInformation:dId deviceName:dName systemName:sName 
                                           SystemVersion:sVersion systemModel:model localModel:lModel];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;        
}
+(NSURLRequest*)requestToCheckout:(NSString*)gId menuId:(NSString*)mId specialInt:(NSString*)sint deliverTime:(NSString*)dTime
{
    NSURL *theUrl = [URLGenerator urlToCheckout:gId menuId:mId specialInt:sint deliverTime:dTime];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;        
}
+(NSURLRequest*)requestToChangeMessageStatus:(NSString*)tId
{
    NSURL *theUrl = [URLGenerator urlToChangeMessageStatus:tId];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;        
}
+(NSURLRequest*)requestToLoadDisclaimer:(NSString*)menuId
{
    NSURL *theUrl = [URLGenerator urlToLoadDisclaimer:menuId];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;        
}
+(NSURLRequest*)requestToLoadMapAddress
{
    NSURL *theUrl = [URLGenerator urlToLoadMapAddress];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;            
}
+(NSURLRequest*)requestToSetCurrenncy
{
    NSURL *theUrl = [URLGenerator urlToSetCurrenncy];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;            
}
+(NSURLRequest*)requestToLoadWeatherAPI
{
    NSURL *theUrl = [URLGenerator urlToLoadWeatherAPI];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;            
}

+(NSURLRequest*)requestToLoadRoomServicesAPI
{
    NSURL *theUrl = [URLGenerator urlToLoadWeatherAPI];
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:theUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
	
	return theRequest;            
}
@end
