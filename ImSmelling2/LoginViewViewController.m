//
//  LoginViewViewController.m
//  ImSmelling2
//
//  Created by Óscar Saboya Gómez on 08/04/14.
//  Copyright (c) 2014 OscarSaboya. All rights reserved.
//

#import "LoginViewViewController.h"



@interface LoginViewViewController ()

@end

@implementation LoginViewViewController

@synthesize txtEmailLogin, txtPassLogin;
@synthesize btnLoginOut, btnRegisterOut;

//Reference points
CGPoint originalCenter;





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
    
    //Set default values of text fields to store
    [self setDefaultValues];
    
    //Button corner radius
    btnLoginOut.layer.cornerRadius = 17;

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



//___________________________________________________________________________________________//

#pragma mark - Hide keyboard 


//Hide keyboard when user press enter button in keyboard
- (IBAction)textFieldShoudReturn:(UITextField *)sender
{
    //If user select first txtField & press Next, the next txtField is selected
    //If the txtField selected is the last one, it hide the keyboard
    if(sender == txtEmailLogin)
    {
        [txtPassLogin becomeFirstResponder];
    }
    else if(sender == txtPassLogin)
    {
        [sender resignFirstResponder];
    }
   
}


//Hide keyboard when background is pressed
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([txtEmailLogin isFirstResponder] && [touch view] != txtEmailLogin)
    {
        [txtEmailLogin resignFirstResponder];
    }

            
    if ([txtPassLogin isFirstResponder] && [touch view] != txtPassLogin)
    {
        [txtPassLogin resignFirstResponder];
    }

    [super touchesBegan:touches withEvent:event];
}


//___________________________________________________________________________________________//

#pragma mark - Store all observation data

NSString *email;
NSString *pass;

- (void) setDefaultValues
{
    email = @"";
    pass = @"";
}

- (void) saveTextFields
{
    email = [txtEmailLogin text];
    pass = [txtPassLogin text];
    
}

- (void) logLogin
{
    NSLog(@"-------------------------");
    NSLog(@"          LOGIN          ");
    NSLog(@"-------------------------");
    
    
    NSLog(@"Email: %@", email);
    
    NSLog(@"Pass: %@", pass);
    
}


//___________________________________________________________________________________________//
#pragma mark - Buttons


//Change status bar colour to white
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)btnLogin:(id)sender
{
    [self saveTextFields];
    
    [self logLogin];
    
}


- (IBAction)btnRegister:(id)sender
{
    //Save email & pass & send them to the register view (better UX)
}





@end
