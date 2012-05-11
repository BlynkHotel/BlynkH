#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Geocoder.h"

@interface AddressAnnotation : NSObject <MKAnnotation> 
{
	CLLocationCoordinate2D coordinate;
	
	NSString *title;
	NSString *subTitle;
}

@end


@interface ShowMapView : UIViewController <MKMapViewDelegate,GeocoderDelegate>{
	
	IBOutlet MKMapView *mapView;
	IBOutlet UIButton *back;
    AddressAnnotation *addAnnotation;
}

-(IBAction)backToHome;
//-(IBAction)showAddress;

@end
