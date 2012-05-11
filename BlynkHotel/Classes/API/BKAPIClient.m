
#import "BKAPIClient.h"
#import "NSString+SBJSON.h"
#import "EyeAppDelegate.h"
#import "URLRequestGenerator.h"
@implementation BKAPIClient

//http://blynk.it/stag
//http://blynk.it/stag/
 
#pragma mark -
#pragma mark Encode

+ (NSString *)urlEncodeValue:(NSString *)str
{
	NSString *result = (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, CFSTR("?=&+"), kCFStringEncodingUTF8);
	return [result autorelease];
}

#pragma mark -
#pragma mark Handle Connection

+ (NSString *)handleConnection:(NSURLRequest *)request {
	
	NSHTTPURLResponse *response;
	NSError *error;
	NSData *responseData;
    EyeAppDelegate *appDel = (EyeAppDelegate*)[[UIApplication sharedApplication]delegate];
	if (appDel.isNetworkAvailable == NO)        
    {
        [appDel showNetworkUnavailableError];
        return nil;
    }
    responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
       if (responseData ==nil )
        {
            
            [appDel showTimeOutAlert];
            return nil;
        }
        return [[[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding] autorelease];    

}

+ (NSMutableDictionary *)shoppingTemplate:(NSString*)mId serviceName:(NSString*)sId{

	NSURLRequest *request = [URLRequestGenerator requestToGetShoppingTemplateWithMenuId:mId serviceName:sId];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
}

+ (NSMutableDictionary *)loadBackgroundImage
{
	NSURLRequest *request = [URLRequestGenerator requestToLoadBackgroundImage];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
}

+ (NSMutableDictionary *)loadgradientImage 
{
	NSURLRequest *request = [URLRequestGenerator requestToLoadGradientImage];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
    
}

+ (NSMutableDictionary *)loadHetelLogo
{
	NSURLRequest *request = [URLRequestGenerator requestToLoadHotelLogo];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
	
}

+ (NSMutableDictionary *)checkDataUpdation:(NSString*)uid 
{
	NSURLRequest *request = [URLRequestGenerator requestToCheckDataUpdationWithId:uid];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
}

 + (NSMutableDictionary *)loadMainHomeMenuView 
{
	NSURLRequest *request = [URLRequestGenerator requestToLoadMainHotelMenu];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
}

+ (NSArray *)loadSubMenuView:(NSString*)menuId {
	
	NSURLRequest *request = [URLRequestGenerator requestToGetSubMenuDetails:menuId];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSArray *)[json JSONValue];
	
	return nil;
	
}

+ (NSMutableDictionary *)loadGuestDetail:(NSString*)guestId{
	
	NSURLRequest *request = [URLRequestGenerator requestToGetGuestDetails:guestId];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
}

+ (NSMutableDictionary *)sendMenuResponce:(NSString*)menuId guestId:(NSString*)gId serviceId:(NSString*)sId
                                     info:(NSString*)detail{
	NSURLRequest *request = [URLRequestGenerator requestToSendMenuResponse:menuId guestId:gId serviceId:sId info:detail];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
    
}

+ (NSMutableDictionary *)homePageImageAdd{
   
	NSURLRequest *request = [URLRequestGenerator requestToGetAdImageOnHomePage];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
    
}

+ (NSMutableDictionary *)bottomAdd:(NSString*)mId
{
   	//NSLog(urlStr);
	NSURLRequest *request = [URLRequestGenerator requestToGetBottomAdDetails:mId];
	NSString *json = [BKAPIClient handleConnection:request];
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;

}

+ (NSMutableDictionary *)loadMenuDetail:(NSString*)serviceName menuId:(NSString*)mId
{
	NSURLRequest *request = [URLRequestGenerator requestToLoadMenuDetail:serviceName menuId:mId];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;

}

+ (NSMutableDictionary *)hotelInfoAboutUs:(NSString*)serviceId{
    
  	NSURLRequest *request = [URLRequestGenerator requestToGetHotelInfoAboutUs:serviceId];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
    
}

+ (NSMutableDictionary *)hotelReservation
{
	NSURLRequest *request = [URLRequestGenerator requestToGetHotelReservation];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
    
}

+ (NSMutableDictionary *)loadPhotoGalleryImages:(NSString*)amentyId
{
	NSURLRequest *request = [URLRequestGenerator requestToLoadPhotoGalleryImages:amentyId];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;

}

+ (NSMutableDictionary *)rootMenuitem:(NSString*)mId   
{
	NSURLRequest *request = [URLRequestGenerator requestToGetSubMenuDetails:mId];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
    
}

+ (NSMutableDictionary *)addtoCartItem:(NSString*)serviceId guestId:(NSString*)gId quantity:(NSString*)qty menuId:(NSString*)mId 
{
	NSURLRequest *request = [URLRequestGenerator requestToAddtoCartItem:serviceId guestId:gId quantity:qty menuId:mId];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
}

+ (NSMutableDictionary *)updateQuantityItem:(NSString*)mId guestId:(NSString*)gId serviceName:(NSString*)sName
{
	NSURLRequest *request = [URLRequestGenerator requestToUpdateQuantityItem:mId guestId:gId serviceName:sName];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
    
}

+ (NSMutableDictionary *)viewCartItem:(NSString*)mId guestId:(NSString*)gId
{
	NSURLRequest *request = [URLRequestGenerator requestToViewCartItem:mId guestId:gId];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
}


+ (NSMutableDictionary *)removeItemFromCart:(NSString*)mId guestId:(NSString*)gId serviceId:(NSString*)sId 
{ 
  	NSURLRequest *request = [URLRequestGenerator requestToRemoveItemFromCart:mId guestId:gId serviceId:sId];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
}

+ (NSMutableDictionary *)deviceInformation:(NSString*)dId deviceName:(NSString*)dName systemName:(NSString*)sName 
                             SystemVersion:(NSString*)sVersion systemModel:(NSString*)model localModel:(NSString*)lModel
{
	NSURLRequest *request = [URLRequestGenerator requestToDeviceInformation:dId deviceName:dName systemName:sName SystemVersion:sVersion systemModel:model localModel:lModel];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
}


+ (NSMutableDictionary *)checkout:(NSString*)gId menuId:(NSString*)mId specialInt:(NSString*)sint deliverTime:(NSString*)dTime
{
	NSURLRequest *request = [URLRequestGenerator requestToCheckout:gId menuId:mId specialInt:sint deliverTime:dTime];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
}

+ (NSMutableDictionary *)guestMessageNotification:(NSString*)guestId 
{
	NSURLRequest *request = [URLRequestGenerator requestToGetGuestMessageNotificationForGuestId:guestId];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
}

+ (NSMutableDictionary *)changeMessageStatus:(NSString*)tId
{
	NSURLRequest *request = [URLRequestGenerator requestToChangeMessageStatus:tId];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
}

+ (NSMutableDictionary *)loadDisclaimer:(NSString*)menuId
{
    NSURLRequest *request = [URLRequestGenerator requestToLoadDisclaimer:menuId];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
}

+ (NSMutableDictionary *)loadMapAddress
{
	NSURLRequest *request = [URLRequestGenerator requestToLoadMapAddress];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
}

+ (NSMutableDictionary *)setCurrenncy
{
	NSURLRequest *request = [URLRequestGenerator requestToSetCurrenncy];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
}

+ (NSMutableDictionary *)loadWeatherAPI
{
	NSURLRequest *request = [URLRequestGenerator requestToLoadWeatherAPI];
	NSString *json = [BKAPIClient handleConnection:request];
	
//	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
    
}

+ (NSMutableDictionary *)loadRoomServicesAPI
{
	NSURLRequest *request = [URLRequestGenerator requestToLoadWeatherAPI];
	NSString *json = [BKAPIClient handleConnection:request];
	
    //	[request release];
	if (json)
		return (NSMutableDictionary *)[json JSONValue];
	
	return nil;
    
}
@end
