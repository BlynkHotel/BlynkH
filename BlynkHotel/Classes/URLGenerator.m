//
//  URLGenerator.m
//  BlynkHotel
//
//  Created by iMac2 on 11/04/12.
//  Copyright 2012 Hemlines. All rights reserved.
//

#import "URLGenerator.h"



NSString *baseUrl = @"http://blynk.it/demo/webservices/";
NSString *hotelId = @"60";	//60 == The Grand Hotel
NSString *weatherUrl = @"http://free.worldweatheronline.com/feed/weather.ashx?q=London,England&format=json&num_of_days=5&key=870faf975e054218111512";
@implementation URLGenerator


+(NSString*)urlBase
{
	return baseUrl;
}

+(NSURL*)urlToLoadAdImageOnHomePage
{
	//http://blynk.it/stag/webservices/homepage_advertise.php
	
	NSString *theUrlString = [baseUrl stringByAppendingString:@"homepage_advertise.php"];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToLoadAdImageOnHomePage = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];
	
	return theUrl;
}

+(NSURL*)urlToToGetGuestMessageNotificationForGuestId:(NSString*)guestId
{
	//http://blynk.it/stag/webservices/message.php?guest_id=%@&hotelid=60
	
	NSString *strToAppend = [NSString stringWithFormat:@"message.php?guest_id=%@&hotelid=%@",guestId,hotelId];	
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToToGetGuestMessageNotificationForGuestId = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToGetGuestDetails:(NSString*)guestId
{
	//http://blynk.it/stag/webservices/hotel_guest_name.php?guest_id=%@
	
	NSString *strToAppend = [NSString stringWithFormat:@"hotel_guest_name.php?guest_id=%@",guestId];	
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToGetGuestDetails = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToGetSubMenuDetails:(NSString*)subMenuId
{
	//http://blynk.it/stag/webservices/hotel_sub_menu.php?hotelid=60&menuid=%@
	
	NSString *strToAppend = [NSString stringWithFormat:@"hotel_sub_menu.php?hotelid=%@&menuid=%@",hotelId,subMenuId];	
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToGetSubMenuDetails = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToGetBottomAdDetails:(NSString*)menuId
{
	//http://blynk.it/stag/webservices/menu_advertise.php?menu_id=%@
	
	NSString *strToAppend = [NSString stringWithFormat:@"menu_advertise.php?menu_id=%@",menuId];	
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToGetBottomAdDetails = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToGetShoppingTemplateWithMenuId:(NSString*)mId serviceName:(NSString*)sId
{
    NSString *strToAppend = [NSString stringWithFormat:@"tree_menu_desc.php?menuid=%@&services_name=%@",mId,sId];
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToGetShoppingTemplateWithMenuId = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToLoadBackgroundImage
{
    NSString *strToAppend = [NSString stringWithFormat:@"hotel_background_image.php?hotelid=%@",hotelId];
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToLoadBackgroundImage = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToLoadGradientImage
{
    NSString *strToAppend = [NSString stringWithFormat:@"menu_gradient_image.php?hotelid=%@",hotelId];
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToLoadGradientImage = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToLoadHotelLogo
{
    NSString *strToAppend = [NSString stringWithFormat:@"hotel_logo_api.php?hotelid=%@",hotelId];
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToLoadHotelLogo = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToCheckDataUpdationWithId:(NSString*)uid
{
    NSString *strToAppend = [NSString stringWithFormat:@"data_update.php?device_id=%@",uid];
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToCheckDataUpdationWithId = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToLoadMainHotelMenu
{
    NSString *strToAppend = [NSString stringWithFormat:@"hotel_main_menu.php?hotelid=%@",hotelId];
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToLoadMainHotelMenu = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToSendMenuResponse:(NSString*)menuId guestId:(NSString*)gId serviceId:(NSString*)sId
                          info:(NSString*)detail
{
    NSString *strToAppend = [NSString stringWithFormat:@"notification.php?hotelid=%@&menu_id=%@&services_id=%@&guest_id=%@&detail=%@",hotelId,menuId,sId,gId,detail];
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToSendMenuResponse = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

 +(NSURL*)urlToLoadMenuDetail:(NSString*)serviceName menuId:(NSString*)mId
{
    NSString *strToAppend = [NSString stringWithFormat:@"sub_menu_item.php?menuid=%@&services_name=%@",mId,serviceName];
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToLoadMenuDetail = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToGetHotelInfoAboutUs:(NSString*)serviceId
{
    NSString *strToAppend = [NSString stringWithFormat:@"amenities.php?services_id=%@",serviceId];
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToGetHotelInfoAboutUs = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToGetHotelReservation
{
    NSString *strToAppend = [NSString stringWithFormat:@"hotel_reserve_link.php?hotelid=%@",hotelId];
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToGetHotelReservation = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToLoadPhotoGalleryImages:(NSString*)amentyId
{
    NSString *strToAppend = [NSString stringWithFormat:@"amenities_photoes.php?amenities_id=%@",amentyId];
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToLoadPhotoGalleryImages = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToAddtoCartItem:(NSString*)serviceId guestId:(NSString*)gId quantity:(NSString*)qty menuId:(NSString*)mId
{
    NSString *strToAppend = [NSString stringWithFormat:@"addcart.php?services_id=%@&guest_id=%@&qty=%@&menu_id=%@",serviceId,gId,qty,mId];
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToAddtoCartItem = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToUpdateQuantityItem:(NSString*)mId guestId:(NSString*)gId serviceName:(NSString*)sName
{
    NSString *strToAppend = [NSString stringWithFormat:@"dispaly_additem.php?menuid=%@&guest_id=%@&services_name=%@",mId,gId,sName];
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToUpdateQuantityItem = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToViewCartItem:(NSString*)mId guestId:(NSString*)gId
{
    NSString *strToAppend = [NSString stringWithFormat:@"viewcart.php?menu_id=%@&guest_id=%@",mId,gId];
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToViewCartItem = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToRemoveItemFromCart:(NSString*)mId guestId:(NSString*)gId serviceId:(NSString*)sId
{
    NSString *strToAppend = [NSString stringWithFormat:@"removecart.php?services_id=%@&guest_id=%@&menu_id=%@",sId,gId,mId];
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToRemoveItemFromCart = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToDeviceInformation:(NSString*)dId deviceName:(NSString*)dName systemName:(NSString*)sName 
                  SystemVersion:(NSString*)sVersion systemModel:(NSString*)model localModel:(NSString*)lModel
{
    NSString *strToAppend = [NSString stringWithFormat:@"device_info.php?hotelid=%@&device_id=%@&name=%@&sys_name=%@&sys_version=%@&model=%@&loc_model=%@",hotelId,dId,dName,sName,sVersion,model,lModel];
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToDeviceInformation = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToCheckout:(NSString*)gId menuId:(NSString*)mId specialInt:(NSString*)sint deliverTime:(NSString*)dTime
{
    NSString *strToAppend = [NSString stringWithFormat:@"checkout.php?hotelid=%@&menu_id=%@&guest_id=%@&sp=%@&dtime=%@",hotelId,mId,gId,sint,dTime];
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToCheckout = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToChangeMessageStatus:(NSString*)tId
{
    NSString *strToAppend = [NSString stringWithFormat:@"read_message.php?tid=%@",tId];
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToChangeMessageStatus = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToLoadDisclaimer:(NSString*)menuId
{
    NSString *strToAppend = [NSString stringWithFormat:@"disclaimer.php?hotelid=%@&menu_id=%@",hotelId,menuId];
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToLoadDisclaimer = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToLoadMapAddress
{
    NSString *strToAppend = [NSString stringWithFormat:@"hotel_address.php?hotelid=%@",hotelId];
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToLoadMapAddress = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToSetCurrenncy
{
    NSString *strToAppend = [NSString stringWithFormat:@"currency.php?hotelid=%@",hotelId];
	NSString *theUrlString = [baseUrl stringByAppendingString:strToAppend];
	theUrlString = [theUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToSetCurrenncy = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToLoadWeatherAPI
{
	NSString *theUrlString = [weatherUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToLoadWeatherAPI = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

+(NSURL*)urlToLoadRoomServicesAPI
{
	NSString *theUrlString = [weatherUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"urlToLoadWeatherAPI = %@",theUrlString);
	NSURL *theUrl = [NSURL URLWithString:theUrlString];	
	return theUrl;
}

@end
