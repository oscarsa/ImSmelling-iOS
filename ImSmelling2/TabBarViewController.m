//
//  TabBarViewController.m
//  ImSmelling2
//
//  Created by Óscar Saboya Gómez on 19/05/14.
//  Copyright (c) 2014 OscarSaboya. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()


@end

@implementation TabBarViewController

@synthesize tabBar;


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
    
    //Change text and icon color of the selected item to white
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor whiteColor]];

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



@end
