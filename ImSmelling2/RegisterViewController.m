//
//  RegisterViewController.m
//  ImSmelling2
//
//  Created by Óscar Saboya Gómez on 10/04/14.
//  Copyright (c) 2014 OscarSaboya. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController 

@synthesize pckrAge, pckrGenre;

@synthesize ages, genres;

@synthesize btnReg;


#define tagAgePicker 0
#define tagGenrePicker 1


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
    
    //Init Pickers with values,
    //depending on the language it choose a /Plists/*.plist or other,
    //defined in /SupportingFiles/Localizable.strings
    NSString *pathAges = [[NSBundle mainBundle]pathForResource:NSLocalizedString(@"agesLocalized" , nil) ofType:@"plist"];
    NSString *pathGenres = [[NSBundle mainBundle]pathForResource:NSLocalizedString(@"genresLocalized", nil) ofType:@"plist"];
    
    ages = [[NSArray alloc]initWithContentsOfFile:pathAges];
    genres = [[NSArray alloc]initWithContentsOfFile:pathGenres];
    
    //Preselected row in pckrAge
    [self.pckrAge selectRow:2 inComponent:0 animated:NO];
    
    //Default values stored in pickers
    [self setDefaultValues];
    
    //Button corner radius
    btnReg.layer.cornerRadius = 17;
    
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



#pragma mark - UIPickerView Datasource & Delegate Methods

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if([pickerView isEqual:pckrAge])
    {
       return [ages count];
    }
    
    if ([pickerView isEqual:pckrGenre])
    {
        return [genres count];
    }
    else
    {
        return 0;
    }

}

/*
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if([pickerView isEqual:pckrAge])
    {
        return ages[row];
    }
    if ([pickerView isEqual:pckrGenre])
    {
        return genres[row];
    }
    else
    {
        return @"Error";
    }
}
*/
 
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    //Attributed String used instead of String to change the text colour to white
    
    if([pickerView isEqual:pckrAge])
    {
        NSString *title = ages[row];
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        return attString;
    }
    if ([pickerView isEqual:pckrGenre])
    {
        NSString *title = genres[row];
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        return attString;
    }
    else
    {
        NSString *error = @"Error";
        NSAttributedString *attError = [[NSAttributedString alloc] initWithString:error attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        return attError;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    //Save the picker value selected
    
    if([pickerView isEqual:pckrAge])
    {
        age = [self.pckrAge selectedRowInComponent:0]+1;
    }
    if ([pickerView isEqual:pckrGenre])
    {
        genre = [self.pckrGenre selectedRowInComponent:0]+1;
    }
}


//Change status bar colour to white
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


//___________________________________________________________________________________________//

#pragma mark - Store all observation data


//Picker value
int age;
int genre;


- (void) setDefaultValues
{
    age = 3;
    genre = 1;
}

- (void) log2stepRegister
{
    NSLog(@"-------------------------");
    NSLog(@"     2ºSTEP REGISTER     ");
    NSLog(@"-------------------------");
    
    
    NSLog(@"Age: %i", age);
    
    NSLog(@"Genre: %i", genre);
}


//___________________________________________________________________________________________//

- (IBAction)btnRegister:(id)sender
{
    [self log2stepRegister];
}


@end





















