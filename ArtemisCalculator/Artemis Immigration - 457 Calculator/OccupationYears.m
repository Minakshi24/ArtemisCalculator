//
//  OccupationYears.m
//  Artemis Immigration - 457 Calculator
//
//  Created by Minakshi on 3/28/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import "OccupationYears.h"
#import "Country.h"

@interface OccupationYears ()

@end

@implementation OccupationYears

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    logoImageView.frame = CGRectMake(85, 10, 150, 111);
    logoImageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:logoImageView];
    [logoImageView release];
    
    UILabel *occupationLabel = [[UILabel alloc] init];
    occupationLabel.frame = CGRectMake(10, 125, 300, 60);
    occupationLabel.backgroundColor = [UIColor clearColor];
    occupationLabel.textAlignment = NSTextAlignmentCenter;
    occupationLabel.textColor = [UIColor blackColor];
    occupationLabel.text = @"3. Have you worked in your occupation for more than 3 year?";
    occupationLabel.numberOfLines = 2;
    [self.view addSubview:occupationLabel];
    
    UIButton *yesBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    yesBtn.tag = 100;
    yesBtn.frame = CGRectMake(115, 195, 90, 40);
    yesBtn.backgroundColor = [UIColor clearColor];
    yesBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    yesBtn.titleLabel.textColor = [UIColor blackColor];
    [yesBtn setTitle:@"Yes" forState:UIControlStateNormal];
    [yesBtn addTarget:self action:@selector(optionSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yesBtn];
    
    UIButton *noBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    noBtn.tag = 101;
    noBtn.frame = CGRectMake(115, 245, 90, 40);
    noBtn.backgroundColor = [UIColor clearColor];
    noBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    noBtn.titleLabel.textColor = [UIColor blackColor];
    [noBtn setTitle:@"No" forState:UIControlStateNormal];
    [noBtn addTarget:self action:@selector(optionSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noBtn];
    
    
}

-(IBAction)optionSelected:(id)sender
{
    UIButton *btnTapped = (UIButton *)sender;
    
    switch (btnTapped.tag) {
        case 100:
        {
            
            mainDelegate.occupationYears = @"Greater than 3";
            
            Country *countryObj = [[Country alloc] init];
            [self.navigationController pushViewController:countryObj animated:YES];
            
            break;
        }
        case 101:
        {
            
            
            mainDelegate.occupationYears = @"Less than 3";
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Result" message:@"Fail" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            alertView.tag = 201;
            [alertView show];
            
            break;
        }
            
        default:
            break;
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(alertView.tag == 201)
    {
        if (buttonIndex == 0)
        {
            [self.navigationController popToRootViewControllerAnimated:NO];
            
        }
        if (buttonIndex == 1)
        {
            //Code for download button
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
