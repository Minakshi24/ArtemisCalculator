//
//  Sponser.m
//  Artemis Immigration - 457 Calculator
//
//  Created by Minakshi on 3/28/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import "Sponser.h"

@interface Sponser ()

@end

@implementation Sponser

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    logoImageView.frame = CGRectMake(85, 10, 150, 111);
    logoImageView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:logoImageView];
    [logoImageView release];
    
    UILabel *occupationLabel = [[UILabel alloc] init];
    occupationLabel.frame = CGRectMake(10, 125, 300, 40);
    occupationLabel.backgroundColor = [UIColor clearColor];
    occupationLabel.textAlignment = NSTextAlignmentCenter;
    occupationLabel.textColor = [UIColor blackColor];
    occupationLabel.text = @"7. Do you have an Sponsor/Employer?";
    [self.view addSubview:occupationLabel];
    
    UIButton *yesBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    yesBtn.tag = 100;
    yesBtn.frame = CGRectMake(115, 175, 90, 40);
    yesBtn.backgroundColor = [UIColor clearColor];
    yesBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    yesBtn.titleLabel.textColor = [UIColor blackColor];
    [yesBtn setTitle:@"Yes" forState:UIControlStateNormal];
    [yesBtn addTarget:self action:@selector(optionSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yesBtn];
    
    UIButton *noBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    noBtn.tag = 101;
    noBtn.frame = CGRectMake(115, 225, 90, 40);
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
            
            mainDelegate.salary = @"Having Sponser";
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Contact" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
            
            
            break;
        }
        case 101:
        {
            
            
            mainDelegate.country = @"Don't Have Sponser";
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Find a sponser" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
            
            
            break;
        }
            
        default:
            break;
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //Code for OK button
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    if (buttonIndex == 1)
    {
        //Code for download button
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
