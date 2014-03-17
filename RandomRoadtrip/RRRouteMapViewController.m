//
//  RRRouteMapViewController.m
//  RandomRoadtrip
//
//  Created by David Olesch on 3/4/14.
//  Copyright (c) 2014 David Olesch. All rights reserved.
//

#import "RRRouteMapViewController.h"
#import <MapKit/MapKit.h>

@interface RRRouteMapViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) MKPlacemark *origin;
@property (strong, nonatomic) MKPlacemark *destination;
@end

@implementation RRRouteMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapFromLocation:(NSString *)fromLocation toLocation:(NSString *)toLocation
{
    [[[CLGeocoder alloc] init] geocodeAddressString:fromLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        self.origin = [[MKPlacemark alloc] initWithPlacemark:[placemarks firstObject]];
        [self.mapView addAnnotation:self.origin];
        if (self.destination) {
            [self getAndDisplayTravelTime];
        }
    }];
    
    [[[CLGeocoder alloc] init] geocodeAddressString:toLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        self.destination = [[MKPlacemark alloc] initWithPlacemark:[placemarks firstObject]];
        [self.mapView addAnnotation:self.destination];
        if (self.origin) {
            [self getAndDisplayTravelTime];
        }
    }];
}

- (void)getAndDisplayTravelTime
{
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    [request setSource:[[MKMapItem alloc] initWithPlacemark:self.origin]];
    [request setDestination:[[MKMapItem alloc] initWithPlacemark:self.destination]];
    [request setTransportType:MKDirectionsTransportTypeAutomobile];
    
    [[[MKDirections alloc] initWithRequest:request] calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        MKRoute *route = [[response routes] firstObject];
        double expectedTravelTimeInHours = [route expectedTravelTime] / 60 / 60;
        NSString *title = [NSString stringWithFormat:@"%@ to %@",self.origin.locality,self.destination.locality];
        NSString *message = [NSString stringWithFormat:@"Driving time is %.0f hours",expectedTravelTimeInHours];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
    }];
}

@end
