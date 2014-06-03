//
//  ViewController.m
//  ImSmelling2
//
//  Created by Óscar Saboya Gómez on 08/04/14.
//  Copyright (c) 2014 OscarSaboya. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"segueObservation"])
    {
        //Identificamos que venimos de Nueva Observación
    }else if ([[segue identifier] isEqualToString:@"segueMap"])
    {
        //Identificamos que venimos del Mapa
    }else if ([[segue identifier] isEqualToString:@"segueReturnLogin"])
    {
        //Identificamos que volvemos del Login a la pantalla inicial
    }else if ([[segue identifier] isEqualToString:@"segueLogin"])
    {
        //Identificamos que venimos del Login
    }
}

@end
