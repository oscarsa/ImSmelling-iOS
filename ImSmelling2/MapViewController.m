//
//  MapViewController.m
//  ImSmelling2
//
//  Created by Óscar Saboya Gómez on 10/04/14.
//  Copyright (c) 2014 OscarSaboya. All rights reserved.
//

#import "MapViewController.h"
#import "SPOObservsAPIEngine.h"



@interface MapViewController ()

@end

@implementation MapViewController
@synthesize mapView;

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
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    
    span.latitudeDelta = 0.1;
    span.longitudeDelta = 0.1;
    
    CLLocationCoordinate2D location;
    location.latitude = 41.6516912;
    location.longitude = -0.8949809;
    
    region.span = span;
    region.center = location;
    
    [mapView setRegion:region animated:YES];
    [mapView regionThatFits:region];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



//Change status bar colour to white
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}




@end
