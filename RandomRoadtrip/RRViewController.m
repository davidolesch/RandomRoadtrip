//
//  RRViewController.m
//  RandomRoadtrip
//
//  Created by David Olesch on 3/4/14.
//  Copyright (c) 2014 David Olesch. All rights reserved.
//

#import "RRViewController.h"
#import "RRRouteMapViewController.h"

@interface RRViewController ()
@property (strong, nonatomic) IBOutlet UITextField *fromField;
@property (strong, nonatomic) IBOutlet UITextField *toField;
- (IBAction)touchedRandomLocation:(id)sender;

@end

@implementation RRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchedRandomLocation:(id)sender {
    //create a list of cities
    NSArray *cities = @[@"New York, NY",@"Los Angeles, CA",@"Chicago, IL",@"Philadelphia, PA",@"Phoenix, AZ",@"San Diego, CA",@"San Jose, CA",@"Jacksonville, FL",@"Indianapolis, IN",@"San Francisco, CA"];
    
    //choose a random integer less than the count of cities
    int randomIndex = arc4random_uniform([cities count]);
    //choose the city from the cities list at the random integer index
    NSString *city = [cities objectAtIndex:randomIndex];
    
    //set the chosen city as the text of the view's To field
    [self.toField setText:city];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RRRouteMapViewController *destinationViewController = [segue destinationViewController];
    [destinationViewController mapFromLocation:self.fromField.text toLocation:self.toField.text];
}
@end
