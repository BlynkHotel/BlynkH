#import "ShowMapView.h"
#import "BKAPIClient.h"
#import "Geocoder.h"


@implementation AddressAnnotation

@synthesize coordinate;

- (NSString *)subtitle
{
	return @"";
}
- (NSString *)title
{
	return @"";
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c
{
	coordinate=c;
	NSLog(@"%f,%f",c.latitude,c.longitude);
	return self;
}

@end

@implementation ShowMapView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *response = [BKAPIClient loadMapAddress];
    NSString *address = [response objectForKey:@"haddress"];
   
	Geocoder *geocoder = [[[Geocoder alloc] init] autorelease];
	geocoder.delegate = self;
	[geocoder getCoordinateForAddress:address];
    self.navigationItem.backBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"Back"
                                      style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(backToHome)] autorelease];

}

-(void)locationFoundWithMapRegion:(MKCoordinateRegion)region
{
   // NSLog([NSString stringWithFormat:@"<%f, %f>", region.center.latitude, region.center.longitude]);
    mapView.region = region;
    mapView.showsUserLocation=YES;
    
	MKCoordinateSpan span;
	span.latitudeDelta=0.2;
	span.longitudeDelta=0.2;
	
	CLLocationCoordinate2D location = mapView.userLocation.coordinate;
	
	location.latitude = region.center.latitude;
	location.longitude = region.center.longitude;
	region.span=span;
	region.center=location;
    
     
	if(addAnnotation != nil) {
		[mapView removeAnnotation:addAnnotation];
		[addAnnotation release];
		addAnnotation = nil;
	}
	
	addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:location];
	[mapView addAnnotation:addAnnotation];
     
	//[mapView setRegion:region animated:TRUE];
	//[mapView regionThatFits:region];
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
	MKPinAnnotationView *annView=[[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"] autorelease];
	annView.pinColor = MKPinAnnotationColorGreen;
	annView.animatesDrop=TRUE;
	annView.canShowCallout = YES;
	annView.calloutOffset = CGPointMake(-5, 5);
	return annView;
}


- (IBAction)backToHome{
	
	[self.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    
    [mapView release];
    [super dealloc];
}


@end
