//
//  Occupation.m
//  Artemis Immigration - 457 Calculator
//
//  Created by Minakshi on 3/28/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import "Occupation.h"
#import "Qualification.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "MyScrollView.h"
#import <MessageUI/MessageUI.h>

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface Occupation ()
{
    AppDelegate *mainDelegate;
}
@end

@implementation Occupation

@synthesize occupationTableView, occupationArray, background, qualificationArray;
@synthesize qualificationTable;

#pragma mark - UIViewController Methods

- (void)viewWillAppear:(BOOL)animtated
{
    
}

- (void)viewWillDisappear:(BOOL)animtated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    w = mainDelegate.window.frame.size.width;
    h = mainDelegate.window.frame.size.height;
    
    mainDelegate.occupationStr = @"";
    mainDelegate.qualification  = @"";
    mainDelegate.occupationYears = @"Yes";
    mainDelegate.country = @"Yes";
    mainDelegate.englishAbility = @"";
    mainDelegate.salary = @"No";
    mainDelegate.sponser = @"Yes";
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.occupationArray = [[NSMutableArray alloc] initWithObjects:@"Construction Project Manager", @"Project Builder", @"Engineering Manager", @"Production Manager (Mining)", @"Child Care Centre Manager", @"Medical Administrator", @"Nursing Clinical Director", @"Primary Health Organisation Manager", @"Welfare Centre Manager", @"Accountant (General)", @"Management Accountant", @"Taxation Accountant", @"External Auditor", @"Internal Auditor", @"Actuary", @"Land Economist", @"Valuer", @"Ship's Engineer", @"Ship's Master", nil];
    
    
    self.qualificationArray = [[NSMutableArray alloc] initWithObjects:@"None", @"Diploma", @"Bachelor Degree", @"Higher Than Bachelor", nil];
    
    autocompleteUrls = [[NSMutableArray alloc] init];
    
    MyScrollView *scroll = [[MyScrollView alloc] init];
    scroll.frame = CGRectMake(0, 0, w, h);
    scroll.backgroundColor = [UIColor clearColor];
    scroll.bounces = NO;
    [self.view addSubview:scroll];
    
    scroll.contentSize = CGSizeMake(w, 588);
    
    background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newBackground.png"]];
    background.frame = CGRectMake(0, 0, w, 588);
    background.backgroundColor = [UIColor clearColor];
    background.userInteractionEnabled = YES;
    [scroll addSubview:background];
    
    UIImageView *nav = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navBar.png"]];
    nav.frame = CGRectMake(0, 0, 320, 74);
    nav.userInteractionEnabled = YES;
    [self.view addSubview:nav];
    
    UIButton *contactUsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    contactUsBtn.frame = CGRectMake(10, 8, 76, 29);
    [contactUsBtn setImage:[UIImage imageNamed:@"contactUsBtn.png"] forState:UIControlStateNormal];
    [contactUsBtn addTarget:self action:@selector(contactUsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [nav addSubview:contactUsBtn];
    
    occupationTf = [[UITextField alloc] init];
    occupationTf.borderStyle = UITextBorderStyleRoundedRect;
    occupationTf.frame = CGRectMake(48, 100, 264, 38);
    occupationTf.backgroundColor = [UIColor whiteColor];
    occupationTf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    occupationTf.textAlignment = NSTextAlignmentCenter;
    occupationTf.placeholder = @"Occupation";
    occupationTf.delegate = self;
    [background addSubview:occupationTf];
    
    UIImageView *dropdownImageBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dropDownLabel.png"]];
    dropdownImageBack.frame = CGRectMake(46, 160, 262, 31);
    dropdownImageBack.backgroundColor = [UIColor clearColor];
    dropdownImageBack.userInteractionEnabled = YES;
    [background addSubview:dropdownImageBack];
    
    dropdownLabel = [[UILabel alloc] init];
    dropdownLabel.frame = CGRectMake(0, 0, 228, 31);
    dropdownLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    dropdownLabel.textAlignment = NSTextAlignmentCenter;
    dropdownLabel.backgroundColor = [UIColor clearColor];
    dropdownLabel.text = @"Qualifications";
    [dropdownImageBack addSubview:dropdownLabel];
    
    UIButton *dropdownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dropdownBtn.frame = CGRectMake(228, 0, 34, 31);
   // dropdownBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dropDownBtn1.png"]];
    [dropdownBtn setImage:[UIImage imageNamed:@"dropDownBtn1.png"] forState:UIControlStateNormal];
   // [dropdownBtn setBackgroundImage:[UIImage imageNamed:@"dropdownBtn1.png"] forState:UIControlStateNormal];
    //dropdownBtn.backgroundColor = [UIColor clearColor];
    [dropdownBtn addTarget:self action:@selector(dropdownBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [dropdownImageBack addSubview:dropdownBtn];
    
    qualificationTable = [[UITableView alloc] init];
    qualificationTable.frame = CGRectMake(49, 191, 225, 160);
    qualificationTable.delegate = self;
    qualificationTable.dataSource = self;
    qualificationTable.backgroundColor = [UIColor whiteColor];
    qualificationTable.hidden = YES;
    [background addSubview:qualificationTable];
    
    experienceSwitch = [[UISwitch alloc] init];
    experienceSwitch.frame = CGRectMake(230, 218, 80, 30);
    [experienceSwitch addTarget:self action:@selector(experienceSwitchValueChange:) forControlEvents:UIControlEventValueChanged];
    [experienceSwitch setOffImage:[UIImage imageNamed:@"newOff2.png"]];
    [experienceSwitch setOnImage:[UIImage imageNamed:@"newOn3.png"]];
    experienceSwitch.selected = YES;
    experienceSwitch.on = YES;
    [background addSubview:experienceSwitch];
    
    
    citizenSwitch = [[UISwitch alloc] init];
    citizenSwitch.frame = CGRectMake(230, 275, 80, 30);
    [citizenSwitch addTarget:self action:@selector(citizenSwitchValueChange:) forControlEvents:UIControlEventValueChanged];
    [citizenSwitch setOffImage:[UIImage imageNamed:@"newOff2.png"]];
    [citizenSwitch setOnImage:[UIImage imageNamed:@"newOn3.png"]];
    citizenSwitch.selected = YES;
    citizenSwitch.on = YES;
    [background addSubview:citizenSwitch];

    englishAbilityTf = [[UITextField alloc] init];
    englishAbilityTf.borderStyle = UITextBorderStyleRoundedRect;
    englishAbilityTf.frame = CGRectMake(230, 321, 80, 38);
    englishAbilityTf.backgroundColor = [UIColor whiteColor];
    englishAbilityTf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    englishAbilityTf.textAlignment = NSTextAlignmentCenter;
    englishAbilityTf.placeholder = @"0-9";
    englishAbilityTf.delegate = self;
    englishAbilityTf.keyboardType = UIKeyboardTypeNumberPad;
    englishAbilityTf.returnKeyType = UIReturnKeyGo;
    [background addSubview:englishAbilityTf];
    
    salarySwitch = [[UISwitch alloc] init];
    salarySwitch.frame = CGRectMake(230, 383, 80, 30);
    [salarySwitch addTarget:self action:@selector(salarySwitchValueChange:) forControlEvents:UIControlEventValueChanged];
    [salarySwitch setOffImage:[UIImage imageNamed:@"newOff2.png"]];
    [salarySwitch setOnImage:[UIImage imageNamed:@"newOn3.png"]];
    [background addSubview:salarySwitch];
    
    sponserSwitch = [[UISwitch alloc] init];
    sponserSwitch.frame = CGRectMake(230, 432, 80, 30);
    [sponserSwitch addTarget:self action:@selector(sponserSwitchValueChange:) forControlEvents:UIControlEventValueChanged];
    [sponserSwitch setOffImage:[UIImage imageNamed:@"newOff2.png"]];
    [sponserSwitch setOnImage:[UIImage imageNamed:@"newOn3.png"]];
    sponserSwitch.selected = YES;
    sponserSwitch.on = YES;
    [background addSubview:sponserSwitch];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if(IS_IPHONE_5)
    {
        submitBtn.frame = CGRectMake(81, 500, 158, 38);
    }
    else
    {
        submitBtn.frame = CGRectMake(81, 500, 158, 34);
    }
    [submitBtn setImage:[UIImage imageNamed:@"submitButton.png"] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(newSubmitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:submitBtn];
    
    [self getDataFromDb];
    
    autocompleteTableView = [[UITableView alloc] initWithFrame:
                             CGRectMake(50, 138, 260, 120) style:UITableViewStylePlain];
    autocompleteTableView.delegate = self;
    autocompleteTableView.dataSource = self;
    autocompleteTableView.scrollEnabled = YES;
    autocompleteTableView.hidden = YES;
    [background addSubview:autocompleteTableView];
    
    
}

-(void) getDataFromDb
{
    
    [self initDatabase];
    
    self.occupationArray = [[NSMutableArray alloc] init];

    sqlite3_stmt *imageSelectStmt;
    if(sqlite3_open(dbpath, &calculatorDB) == SQLITE_OK){
        
        //        NSString *selectQuery = [NSString stringWithFormat:@"SELECT Nameofstore, SurfboardBrand, Website, Email, Address1, City, State, F FROM StoreTable where SurfboardBrand like '%%%@%%'", searchString];
        
        NSString *selectQuery;
        
        selectQuery = [NSString stringWithFormat:@"SELECT OCCUPATION FROM occupationTable"];
        
        NSLog(@"%@", selectQuery);
        
        const char *query_stmt1 = [selectQuery UTF8String];
        
        selectQuery = nil;
        
        if (sqlite3_prepare_v2(calculatorDB, query_stmt1, -1, &imageSelectStmt, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(imageSelectStmt) == SQLITE_ROW)
            {
                NSString *occupationStr = [[ NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(imageSelectStmt,0)];
                
                NSLog(@"%@", occupationStr);
                              
                if(occupationStr != nil || [occupationStr rangeOfString:@"n\a"].location == NSNotFound)
                {
                    [self.occupationArray addObject:occupationStr];
                }
                                
                
            }
            sqlite3_finalize(imageSelectStmt);
        }
        sqlite3_close(calculatorDB);
    }
    else
    {
        NSLog(@"Error : %s", sqlite3_errmsg(calculatorDB));
        sqlite3_close(calculatorDB);
    }
    
    NSLog(@"self.storeArray : %@", self.occupationArray);
    
}

#pragma mark - Database initialisation function

- (void) initDatabase
{
	BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"calculatorDb.sqlite"];
    success = [fileManager fileExistsAtPath:writableDBPath];
	dbpath = [writableDBPath UTF8String];
	
	NSLog(@"path : %@", writableDBPath);
    if (success) return;
	
	// The writable database does not exist, so copy the default to the appropriate location.
	NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"calculatorDb.sqlite"];
	
	success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
	if (!success)
	{
		NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}
	
	dbpath = [writableDBPath UTF8String];
	NSLog(@"path : %@", writableDBPath);
}

#pragma mark - Contact Us button action

-(IBAction)contactUsBtnAction:(id)sender
{
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:02-9887-2598"]];
    
    
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if([messageClass canSendText]){
        // Sim available
        //OLD Phone number - 02-9887-2598
       // 02 9887 3590
        NSString *phoneNumber = @"02-9887-3590"; // dynamically assigned
        NSString *phoneURLString = [NSString stringWithFormat:@"tel:%@", phoneNumber];
        NSURL *phoneURL = [NSURL URLWithString:phoneURLString];
        [[UIApplication sharedApplication] openURL:phoneURL];
    }
    else{
        //Sim not available
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Sorry, calling functionality not available" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}

-(IBAction)newSubmitBtnAction:(id)sender
{
    if(occupationTf.text.length == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter occupation" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else{
        
        if([mainDelegate.qualification isEqualToString:@""])
        {
            
            //Qualification is not entered
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter qualification" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
            
        }
        else
        {
            
            //Check Sponsor
            
            if(!sponserSwitch.isOn)
            {
                //Fail
                if(IS_IPHONE_5)
                {
                    
                    failResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iphone5Fail.png"]];
                    failResultView.frame = CGRectMake(0, 0, 320, 568);
                    
                }
                else
                {
                    failResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newFailAlert01.png"]];
                    failResultView.frame = CGRectMake(0, 0, 320, 480);
                }
                
                failResultView.backgroundColor = [UIColor clearColor];
                failResultView.userInteractionEnabled = YES;
                [self.view addSubview:failResultView];
                
                UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                okBtn.frame = CGRectMake(81, 285, 158, 38);
                okBtn.backgroundColor = [UIColor clearColor];
                [okBtn setImage:[UIImage imageNamed:@"okBtn.png"] forState:UIControlStateNormal];
                [okBtn addTarget:self action:@selector(okBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                [failResultView addSubview:okBtn];
            }
            
            //Check qualification
            else if([mainDelegate.qualification isEqualToString:@"None"])
            {
                //Check experience
                if([mainDelegate.occupationYears isEqualToString:@"Yes"])
                {
                    //Check country
                    if([mainDelegate.country isEqualToString:@"Yes"])
                    {
                        //PAss
                        
                        if(IS_IPHONE_5)
                        {
                            passResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iphone5CongoAlert.png"]];
                            passResultView.frame = CGRectMake(0, 0, 320, 568);
                        }
                        else
                        {
                            passResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newCongoAlert01.png"]];
                            passResultView.frame = CGRectMake(0, 0, 320, 480);
                        }
                        
                        passResultView.backgroundColor = [UIColor clearColor];
                        passResultView.userInteractionEnabled = YES;
                        [self.view addSubview:passResultView];
                        
                        UIButton *proceedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                        proceedBtn.frame = CGRectMake(81, 283, 158, 38);
                        proceedBtn.backgroundColor = [UIColor clearColor];
                        [proceedBtn setImage:[UIImage imageNamed:@"proceedBtn.png"] forState:UIControlStateNormal];
                        [proceedBtn addTarget:self action:@selector(proceedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                        [passResultView addSubview:proceedBtn];
                    }
                    else
                    {
                        //check english ability
                        
                        if(englishAbilityTf.text.length == 0)
                        {
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter english ability" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                            [alertView show];
                        }
                        else
                        {
                            int ability = [englishAbilityTf.text intValue];
                            
                            NSLog(@"ability :%d",ability);
                            
//                            if(ability > 7)  // Commented by Minakshi - On client request April 15 2014
                            if(ability >= 5)
                            {
                                //Pass
                                if(IS_IPHONE_5)
                                {
                                    passResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iphone5CongoAlert.png"]];
                                    passResultView.frame = CGRectMake(0, 0, 320, 568);
                                }
                                else
                                {
                                    passResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newCongoAlert01.png"]];
                                    passResultView.frame = CGRectMake(0, 0, 320, 480);
                                }
                                
                                passResultView.backgroundColor = [UIColor clearColor];
                                passResultView.userInteractionEnabled = YES;
                                [self.view addSubview:passResultView];
                                
                                UIButton *proceedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                                proceedBtn.frame = CGRectMake(81, 283, 158, 38);
                                proceedBtn.backgroundColor = [UIColor clearColor];
                                [proceedBtn setImage:[UIImage imageNamed:@"proceedBtn.png"] forState:UIControlStateNormal];
                                [proceedBtn addTarget:self action:@selector(proceedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                                [passResultView addSubview:proceedBtn];
                            }
                            else
                            {
                                //check salary
                                if([mainDelegate.salary isEqualToString:@"Yes"])
                                {
                                    //Pass
                                    if(IS_IPHONE_5)
                                    {
                                        passResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iphone5CongoAlert.png"]];
                                        passResultView.frame = CGRectMake(0, 0, 320, 568);
                                    }
                                    else
                                    {
                                        passResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newCongoAlert01.png"]];
                                        passResultView.frame = CGRectMake(0, 0, 320, 480);
                                    }
                                    
                                    passResultView.backgroundColor = [UIColor clearColor];
                                    passResultView.userInteractionEnabled = YES;
                                    [self.view addSubview:passResultView];
                                    
                                    UIButton *proceedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                                    proceedBtn.frame = CGRectMake(81, 283, 158, 38);
                                    proceedBtn.backgroundColor = [UIColor clearColor];
                                    [proceedBtn setImage:[UIImage imageNamed:@"proceedBtn.png"] forState:UIControlStateNormal];
                                    [proceedBtn addTarget:self action:@selector(proceedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                                    [passResultView addSubview:proceedBtn];
                                }
                                else
                                {
                                    //Fail
                                    if(IS_IPHONE_5)
                                    {
                                        
                                        failResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iphone5Fail.png"]];
                                        failResultView.frame = CGRectMake(0, 0, 320, 568);
                                        
                                    }
                                    else
                                    {
                                        failResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newFailAlert01.png"]];
                                        failResultView.frame = CGRectMake(0, 0, 320, 480);
                                    }
                                    
                                    failResultView.backgroundColor = [UIColor clearColor];
                                    failResultView.userInteractionEnabled = YES;
                                    [self.view addSubview:failResultView];
                                    
                                    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                                    okBtn.frame = CGRectMake(81, 285, 158, 38);
                                    okBtn.backgroundColor = [UIColor clearColor];
                                    [okBtn setImage:[UIImage imageNamed:@"okBtn.png"] forState:UIControlStateNormal];
                                    [okBtn addTarget:self action:@selector(okBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                                    [failResultView addSubview:okBtn];

                                }
                            }
                            
                        }
                    }
                    
                }
                else
                {
                    //Fail
                    if(IS_IPHONE_5)
                    {
                        
                        failResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iphone5Fail.png"]];
                        failResultView.frame = CGRectMake(0, 0, 320, 568);
                        
                    }
                    else
                    {
                        failResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newFailAlert01.png"]];
                        failResultView.frame = CGRectMake(0, 0, 320, 480);
                    }
                    
                    failResultView.backgroundColor = [UIColor clearColor];
                    failResultView.userInteractionEnabled = YES;
                    [self.view addSubview:failResultView];
                    
                    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    okBtn.frame = CGRectMake(81, 285, 158, 38);
                    okBtn.backgroundColor = [UIColor clearColor];
                    [okBtn setImage:[UIImage imageNamed:@"okBtn.png"] forState:UIControlStateNormal];
                    [okBtn addTarget:self action:@selector(okBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                    [failResultView addSubview:okBtn];
                    
                }
            }
            else
            {
                
                //Check country
                if([mainDelegate.country isEqualToString:@"Yes"])
                {
                    //PAss
                    if(IS_IPHONE_5)
                    {
                        passResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iphone5CongoAlert.png"]];
                        passResultView.frame = CGRectMake(0, 0, 320, 568);
                    }
                    else
                    {
                        passResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newCongoAlert01.png"]];
                        passResultView.frame = CGRectMake(0, 0, 320, 480);
                    }
                    
                    passResultView.backgroundColor = [UIColor clearColor];
                    passResultView.userInteractionEnabled = YES;
                    [self.view addSubview:passResultView];
                    
                    UIButton *proceedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    proceedBtn.frame = CGRectMake(81, 283, 158, 38);
                    proceedBtn.backgroundColor = [UIColor clearColor];
                    [proceedBtn setImage:[UIImage imageNamed:@"proceedBtn.png"] forState:UIControlStateNormal];
                    [proceedBtn addTarget:self action:@selector(proceedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                    [passResultView addSubview:proceedBtn];
                }
                else
                {
                    //check english ability
                    
                    if(englishAbilityTf.text.length == 0)
                    {
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter english ability" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                        [alertView show];
                    }
                    else
                    {
                        int ability = [englishAbilityTf.text intValue];
                        
                        NSLog(@"ability :%d",ability);
                        
                        if(ability >= 5)
                        {
                            //Pass
                            if(IS_IPHONE_5)
                            {
                                passResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iphone5CongoAlert.png"]];
                                passResultView.frame = CGRectMake(0, 0, 320, 568);
                            }
                            else
                            {
                                passResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newCongoAlert01.png"]];
                                passResultView.frame = CGRectMake(0, 0, 320, 480);
                            }
                            
                            passResultView.backgroundColor = [UIColor clearColor];
                            passResultView.userInteractionEnabled = YES;
                            [self.view addSubview:passResultView];
                            
                            UIButton *proceedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                            proceedBtn.frame = CGRectMake(81, 283, 158, 38);
                            proceedBtn.backgroundColor = [UIColor clearColor];
                            [proceedBtn setImage:[UIImage imageNamed:@"proceedBtn.png"] forState:UIControlStateNormal];
                            [proceedBtn addTarget:self action:@selector(proceedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                            [passResultView addSubview:proceedBtn];
                        }
                        else
                        {
                            //check salary
                            if([mainDelegate.salary isEqualToString:@"Yes"])
                            {
                                //Pass
                                if(IS_IPHONE_5)
                                {
                                    passResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iphone5CongoAlert.png"]];
                                    passResultView.frame = CGRectMake(0, 0, 320, 568);
                                }
                                else
                                {
                                    passResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newCongoAlert01.png"]];
                                    passResultView.frame = CGRectMake(0, 0, 320, 480);
                                }
                                
                                passResultView.backgroundColor = [UIColor clearColor];
                                passResultView.userInteractionEnabled = YES;
                                [self.view addSubview:passResultView];
                                
                                UIButton *proceedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                                proceedBtn.frame = CGRectMake(81, 283, 158, 38);
                                proceedBtn.backgroundColor = [UIColor clearColor];
                                [proceedBtn setImage:[UIImage imageNamed:@"proceedBtn.png"] forState:UIControlStateNormal];
                                [proceedBtn addTarget:self action:@selector(proceedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                                [passResultView addSubview:proceedBtn];
                            }
                            else
                            {
                                //Fail
                                if(IS_IPHONE_5)
                                {
                                    
                                    failResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iphone5Fail.png"]];
                                    failResultView.frame = CGRectMake(0, 0, 320, 568);
                                    
                                }
                                else
                                {
                                    failResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newFailAlert01.png"]];
                                    failResultView.frame = CGRectMake(0, 0, 320, 480);
                                }
                                
                                failResultView.backgroundColor = [UIColor clearColor];
                                failResultView.userInteractionEnabled = YES;
                                [self.view addSubview:failResultView];
                                
                                UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                                okBtn.frame = CGRectMake(81, 285, 158, 38);
                                okBtn.backgroundColor = [UIColor clearColor];
                                [okBtn setImage:[UIImage imageNamed:@"okBtn.png"] forState:UIControlStateNormal];
                                [okBtn addTarget:self action:@selector(okBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                                [failResultView addSubview:okBtn];

                            }
                        }
                        
                    }
                }
                
                
            }
            
            
        }
    }

}

#pragma mark - Submit button action

-(IBAction)submitBtnAction:(id)sender
{
    
    if(occupationTf.text.length == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter occupation" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else{
    
        if([mainDelegate.qualification isEqualToString:@""])
        {
            
            //Qualification is not entered
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter qualification" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
            
        }
        else
        {
        
            if([mainDelegate.qualification isEqualToString:@"None"] && [mainDelegate.occupationYears isEqualToString:@"No"])
            {
                
                if(IS_IPHONE_5)
                {
                    
                    failResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iphone5Fail.png"]];
                    failResultView.frame = CGRectMake(0, 0, 320, 568);
                    
                }
                else
                {
                    failResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newFailAlert01.png"]];
                    failResultView.frame = CGRectMake(0, 0, 320, 480);
                }
                
                failResultView.backgroundColor = [UIColor clearColor];
                failResultView.userInteractionEnabled = YES;
                [self.view addSubview:failResultView];
                
                UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                okBtn.frame = CGRectMake(81, 285, 158, 38);
                okBtn.backgroundColor = [UIColor clearColor];
                [okBtn setImage:[UIImage imageNamed:@"okBtn.png"] forState:UIControlStateNormal];
                [okBtn addTarget:self action:@selector(okBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                [failResultView addSubview:okBtn];
                
            }
            else if(([mainDelegate.qualification isEqualToString:@"None"] || mainDelegate.qualification.length > 0) && [mainDelegate.occupationYears isEqualToString:@"Yes"] && [mainDelegate.country isEqualToString:@"Yes"])
            {
                

                if(IS_IPHONE_5)
                {
                    passResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iphone5CongoAlert.png"]];
                    passResultView.frame = CGRectMake(0, 0, 320, 568);
                }
                else
                {
                    passResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newCongoAlert01.png"]];
                    passResultView.frame = CGRectMake(0, 0, 320, 480);
                }
                
                passResultView.backgroundColor = [UIColor clearColor];
                passResultView.userInteractionEnabled = YES;
                [self.view addSubview:passResultView];
                
                UIButton *proceedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                proceedBtn.frame = CGRectMake(81, 283, 158, 38);
                proceedBtn.backgroundColor = [UIColor clearColor];
                [proceedBtn setImage:[UIImage imageNamed:@"proceedBtn.png"] forState:UIControlStateNormal];
                [proceedBtn addTarget:self action:@selector(proceedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                [passResultView addSubview:proceedBtn];
                
            }
            else if(([mainDelegate.qualification isEqualToString:@"None"] || mainDelegate.qualification.length > 0)  && [mainDelegate.occupationYears isEqualToString:@"Yes"] && [mainDelegate.country isEqualToString:@"No"])
            {
                //Check English Ability
                
                if(englishAbilityTf.text.length == 0)
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter english ability" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [alertView show];
                }
                else
                {
                    int ability = [englishAbilityTf.text intValue];
                    
                    if(ability >= 5)
                    {
 
                        if(IS_IPHONE_5)
                        {
                            passResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iphone5CongoAlert.png"]];
                            passResultView.frame = CGRectMake(0, 0, 320, 568);
                        }
                        else
                        {
                            passResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newCongoAlert01.png"]];
                            passResultView.frame = CGRectMake(0, 0, 320, 480);
                        }
                        
                        passResultView.backgroundColor = [UIColor clearColor];
                        passResultView.userInteractionEnabled = YES;
                        [self.view addSubview:passResultView];
                        
                        UIButton *proceedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                        proceedBtn.frame = CGRectMake(81, 283, 158, 38);
                        proceedBtn.backgroundColor = [UIColor clearColor];
                        [proceedBtn setImage:[UIImage imageNamed:@"proceedBtn.png"] forState:UIControlStateNormal];
                        [proceedBtn addTarget:self action:@selector(proceedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                        [passResultView addSubview:proceedBtn];
                    
                    }
                    else
                    {
                    
                        if([mainDelegate.salary isEqualToString:@"Yes"])
                        {
                            
                            if(IS_IPHONE_5)
                            {
                                passResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iphone5CongoAlert.png"]];
                                passResultView.frame = CGRectMake(0, 0, 320, 568);
                            }
                            else
                            {
                                passResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newCongoAlert01.png"]];
                                passResultView.frame = CGRectMake(0, 0, 320, 480);
                            }
                            
                            passResultView.backgroundColor = [UIColor clearColor];
                            passResultView.userInteractionEnabled = YES;
                            [self.view addSubview:passResultView];
                            
                            UIButton *proceedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                            proceedBtn.frame = CGRectMake(81, 283, 158, 38);
                            proceedBtn.backgroundColor = [UIColor clearColor];
                            [proceedBtn setImage:[UIImage imageNamed:@"proceedBtn.png"] forState:UIControlStateNormal];
                            [proceedBtn addTarget:self action:@selector(proceedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                            [passResultView addSubview:proceedBtn];
                            
                            
                        }
                        else
                        {
                        
                            if(IS_IPHONE_5)
                            {
                                
                                failResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iphone5Fail.png"]];
                                failResultView.frame = CGRectMake(0, 0, 320, 568);
                                
                            }
                            else
                            {
                                failResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newFailAlert01.png"]];
                                failResultView.frame = CGRectMake(0, 0, 320, 480);
                            }
                            
                            failResultView.backgroundColor = [UIColor clearColor];
                            failResultView.userInteractionEnabled = YES;
                            [self.view addSubview:failResultView];
                            
                            UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                            okBtn.frame = CGRectMake(81, 285, 158, 38);
                            okBtn.backgroundColor = [UIColor clearColor];
                            [okBtn setImage:[UIImage imageNamed:@"okBtn.png"] forState:UIControlStateNormal];
                            [okBtn addTarget:self action:@selector(okBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                            [failResultView addSubview:okBtn];

                        
                        }
                    }
                }
                
            }
        }
    }
    
}

-(IBAction)okBtnAction:(id)sender
{
    
    if(failResultView != nil)
    {
        [failResultView removeFromSuperview];
        failResultView = nil;
    }
    
//    occupationTf.text = @"";
//    occupationTf.placeholder = @"Occupation";
//    
//    dropdownLabel.text = @"Qualifications";
//    
//    mainDelegate.occupationStr = @"";
//    mainDelegate.qualification  = @"";
//    mainDelegate.occupationYears = @"Yes";
//    mainDelegate.country = @"Yes";
//    mainDelegate.englishAbility = @"";
//    mainDelegate.salary = @"No";
//    mainDelegate.sponser = @"Yes";
//    
//    experienceSwitch.selected = YES;
//    experienceSwitch.on = YES;
//    
//    citizenSwitch.selected = YES;
//    citizenSwitch.on = YES;
//    
//    englishAbilityTf.text = @"";
//    englishAbilityTf.placeholder = @"0-9";
//    
//    salarySwitch.selected = NO;
//    salarySwitch.on = NO;
//    
//    sponserSwitch.selected = YES;
//    sponserSwitch.on = YES;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Need assistance?" message:@"To find alternative candidates call “Our Recruiter”. To get visa help, call  Artemis Immigration." delegate:self cancelButtonTitle:@"No thanks" otherButtonTitles:@"Call Our Recruiter", @"Call Artemis", nil];
    alertView.tag = 200;
    [alertView show];
    
}

-(IBAction)proceedBtnAction:(id)sender
{
    
    if(passResultView != nil)
    {
        [passResultView removeFromSuperview];
        passResultView = nil;
        
        if([mainDelegate.sponser isEqualToString:@"Yes"])
        {
            //PROCEED
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Need assistance?" message:@"To find alternative candidates call “Our Recruiter”. To get visa help, call  Artemis Immigration." delegate:self cancelButtonTitle:@"No thanks" otherButtonTitles:@"Call Our Recruiter", @"Call Artemis", nil];
            alertView.tag = 200;
            [alertView show];
        }
        else if([mainDelegate.sponser isEqualToString:@"No"])
        {
            //Find a sposer
            //            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Find a sponser" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            //            [alertView show];
            
//            passResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alertBackground.png"]];
//            passResultView.frame = CGRectMake(0, 0, 320, 480);
//            passResultView.backgroundColor = [UIColor clearColor];
//            passResultView.userInteractionEnabled = YES;
//            [self.view addSubview:passResultView];
//            
//            UIButton *proceedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            proceedBtn.frame = CGRectMake(81, 283, 158, 38);
//            proceedBtn.backgroundColor = [UIColor clearColor];
//            [proceedBtn setImage:[UIImage imageNamed:@"proceedBtn.png"] forState:UIControlStateNormal];
//            [proceedBtn addTarget:self action:@selector(newProceedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//            [passResultView addSubview:proceedBtn];
            
            
            //PROCEED
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Need assistance?" message:@"To find alternative candidates call “Our Recruiter”. To get visa help, call  Artemis Immigration." delegate:self cancelButtonTitle:@"No thanks" otherButtonTitles:@"Call Our Recruiter", @"Call Artemis", nil];
            alertView.tag = 200;
            [alertView show];
            
            
            occupationTf.text = @"";
            occupationTf.placeholder = @"Occupation";
            
            dropdownLabel.text = @"Qualifications";
            
            mainDelegate.occupationStr = @"";
            mainDelegate.qualification  = @"";
            mainDelegate.occupationYears = @"Yes";
            mainDelegate.country = @"Yes";
            mainDelegate.englishAbility = @"";
            mainDelegate.salary = @"No";
            mainDelegate.sponser = @"Yes";
            
            experienceSwitch.selected = YES;
            experienceSwitch.on = YES;
            
            citizenSwitch.selected = YES;
            citizenSwitch.on = YES;
            
            englishAbilityTf.text = @"";
            englishAbilityTf.placeholder = @"0-9";
            
            salarySwitch.selected = NO;
            salarySwitch.on = NO;
            
            sponserSwitch.selected = YES;
            sponserSwitch.on = YES;
            
        }
        
    }
}

-(IBAction)newProceedBtnAction:(id)sender
{
    if(passResultView != nil)
    {
        [passResultView removeFromSuperview];
        passResultView = nil;
    }
}

#pragma mark - Sponser Switch action

- (void)sponserSwitchValueChange:(UISwitch *)theSwitch
{
    if(theSwitch.selected)
    {
        theSwitch.selected = NO;
        theSwitch.on = NO;
        mainDelegate.sponser = @"No";
    }
    else
    {
        theSwitch.selected = YES;
        theSwitch.on = YES;
        mainDelegate.sponser = @"Yes";
    }
    
}
#pragma mark - Salary Switch action

- (void)salarySwitchValueChange:(UISwitch *)theSwitch
{
    if(theSwitch.selected)
    {
        theSwitch.selected = NO;
        theSwitch.on = NO;
        mainDelegate.salary = @"No";
        
    }
    else
    {
        theSwitch.selected = YES;
        theSwitch.on = YES;
        mainDelegate.salary = @"Yes";
        
    }
    
}

#pragma mark - Citizen Switch action

- (void)citizenSwitchValueChange:(UISwitch *)theSwitch
{
    if(theSwitch.selected)
    {
        theSwitch.selected = NO;
        theSwitch.on = NO;
        mainDelegate.country = @"No";
    }
    else
    {
        theSwitch.selected = YES;
        theSwitch.on = YES;
        mainDelegate.country = @"Yes";
    }
    
}

#pragma mark - occupation experience Switch action

- (void)experienceSwitchValueChange:(UISwitch *)theSwitch
{
    if(theSwitch.selected)
    {
        theSwitch.selected = NO;
        theSwitch.on = NO;
        mainDelegate.occupationYears = @"No";
    }
    else
    {
        theSwitch.selected = YES;
        theSwitch.on = YES;
        mainDelegate.occupationYears = @"Yes";
    }
    
}

#pragma mark - Dropdown button action

-(IBAction)dropdownBtnAction:(id)sender
{
    if(qualificationTable.hidden)
    {
        qualificationTable.hidden = NO;
        [background bringSubviewToFront:qualificationTable];
        
    }
    else
    {
        qualificationTable.hidden = YES;
    }
}


#pragma mark - UIAlertView Method

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(alertView.tag == 101)
    {
        if([mainDelegate.sponser isEqualToString:@"Yes"])
        {
            //PROCEED
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Need assistance?" message:@"To find alternative candidates call “Our Recruiter”. To get visa help, call  Artemis Immigration." delegate:self cancelButtonTitle:@"No thanks" otherButtonTitles:@"Call Our Recruiter", @"Call Artemis", nil];
            alertView.tag = 200;
            [alertView show];
        }
        else if([mainDelegate.sponser isEqualToString:@"No"])
        {
            //Find a sposer
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Find a sponser" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//            [alertView show];


            if(IS_IPHONE_5)
            {
                passResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iphone5CongoAlert.png"]];
                passResultView.frame = CGRectMake(0, 0, 320, 568);
            }
            else
            {
                passResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newCongoAlert01.png"]];
                passResultView.frame = CGRectMake(0, 0, 320, 480);
            }
            
            passResultView.backgroundColor = [UIColor clearColor];
            passResultView.userInteractionEnabled = YES;
            [self.view addSubview:passResultView];
            
            UIButton *proceedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            proceedBtn.frame = CGRectMake(81, 283, 158, 38);
            proceedBtn.backgroundColor = [UIColor clearColor];
            [proceedBtn setImage:[UIImage imageNamed:@"proceedBtn.png"] forState:UIControlStateNormal];
            [proceedBtn addTarget:self action:@selector(proceedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [passResultView addSubview:proceedBtn];
        
        }
    }
    
    if(alertView.tag == 200)
    {
        
        occupationTf.text = @"";
        occupationTf.placeholder = @"Occupation";
        
        dropdownLabel.text = @"Qualifications";
        
        mainDelegate.occupationStr = @"";
        mainDelegate.qualification  = @"";
        mainDelegate.occupationYears = @"Yes";
        mainDelegate.country = @"Yes";
        mainDelegate.englishAbility = @"";
        mainDelegate.salary = @"No";
        mainDelegate.sponser = @"Yes";
        
        experienceSwitch.selected = YES;
        experienceSwitch.on = YES;
        
        citizenSwitch.selected = YES;
        citizenSwitch.on = YES;
        
        englishAbilityTf.text = @"";
        englishAbilityTf.placeholder = @"0-9";
        
        salarySwitch.selected = NO;
        salarySwitch.on = NO;
        
        sponserSwitch.selected = YES;
        sponserSwitch.on = YES;
        
        if (buttonIndex == 0)
        {
            //No Thanks
            
            NSLog(@"0");
            
        }
        if (buttonIndex == 1)
        {
            //Call Our Recruiter
            NSLog(@"1");
            
            Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
            if([messageClass canSendText]){
                // Sim available
                
                NSString *phoneNumber = @"02-9887-3590"; // dynamically assigned
                NSString *phoneURLString = [NSString stringWithFormat:@"tel:%@", phoneNumber];
                NSURL *phoneURL = [NSURL URLWithString:phoneURLString];
                [[UIApplication sharedApplication] openURL:phoneURL];
            }
            else{
                //Sim not available
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Sorry, calling functionality not available" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alertView show];
            }
            
            
        }
        if (buttonIndex == 2)
        {
            //Call Artemis
            
            NSLog(@"2");
            
            Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
            if([messageClass canSendText]){
                // Sim available
                
                NSString *phoneNumber = @"02-9887-3590"; // dynamically assigned
                NSString *phoneURLString = [NSString stringWithFormat:@"tel:%@", phoneNumber];
                NSURL *phoneURL = [NSURL URLWithString:phoneURLString];
                [[UIApplication sharedApplication] openURL:phoneURL];
            }
            else{
                //Sim not available
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Sorry, calling functionality not available" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alertView show];
            }
            
        }
    }
    
}

#pragma mark - UITextField Delegate Methods

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    
    [self animateTextField:textField up:YES];
    
    if(textField == englishAbilityTf)
    {
        
        if(englishAbilityTf.isFirstResponder)
        {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        }
        
    }
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if(textField == occupationTf)
    {
        autocompleteTableView.hidden = NO;
        
        NSString *substring = [NSString stringWithString:textField.text];
        substring = [substring stringByReplacingCharactersInRange:range withString:string];
        
        if(substring.length > 0)
        {
            [self searchAutocompleteEntriesWithSubstring:substring];
        }
        else if(substring.length == 0)
        {
            autocompleteTableView.hidden = YES;
        }
    }
    else if(textField == englishAbilityTf)
    {
        NSString *substring = [NSString stringWithString:textField.text];
        substring = [substring stringByReplacingCharactersInRange:range withString:string];
        
        if(substring.length == 2)
        {
            [textField resignFirstResponder];
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"You can enter only one digit number" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    
    return YES;
}

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
    [autocompleteUrls removeAllObjects];
    
    for(NSString *curString in occupationArray) {
        
//        NSLog(@"%@",curString);
//        NSLog(@"%@",substring);
        
        //NSRange substringRange = [substring rangeOfString:curString];
        //NSRange substringRange = [curString rangeOfString:substring options:NSCaseInsensitiveSearch];
        
        //if (substringRange.location == 0) {
            if([curString rangeOfString:substring options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
            [autocompleteUrls addObject:curString];
        }
    }
    [autocompleteTableView reloadData];
    
//    if(substring.length > 0 && [autocompleteUrls count] == 0)
//    {
//        autocompleteTableView.hidden = YES;
//        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"This occupation is not in the list.Choose another description." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [alertView show];
//    }

}

#pragma mark - UITextField Animation Method

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    int animatedDistance;
    int moveUpValue = textField.frame.origin.y+ textField.frame.size.height;
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
		
        animatedDistance = 216-(460-moveUpValue-50);
    }
    else
    {
        animatedDistance = 162-(320-moveUpValue-50);
    }
	
    if(animatedDistance>0)
    {
        const int movementDistance = animatedDistance;
        const float movementDuration = 0.3f;
        int movement = (up ? -movementDistance : movementDistance);
        [UIView beginAnimations: nil context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
}


#pragma mark - KeyboardNotification method

- (void)keyboardDidShow:(NSNotification *)note {
    // create custom button
    doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(0, 163, 106, 53);
    doneButton.adjustsImageWhenHighlighted = NO;
    [doneButton setImage:[UIImage imageNamed:@"doneup.png"] forState:UIControlStateNormal];
    [doneButton setImage:[UIImage imageNamed:@"donedown.png"] forState:UIControlStateHighlighted];
    [doneButton addTarget:self action:@selector(doneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // locate keyboard view
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    UIView* keyboard;
    for(int i=0; i<[tempWindow.subviews count]; i++) {
        keyboard = [tempWindow.subviews objectAtIndex:i];
        // keyboard view found; add the custom button to it
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
            if([[keyboard description] hasPrefix:@"<UIPeripheralHost"] == YES)
                [keyboard addSubview:doneButton];
        } else {
            if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
                [keyboard addSubview:doneButton];
        }
    }
}

- (void)doneButtonClicked:(id)Sender
{
    
    if(englishAbilityTf.isFirstResponder)
    {
        [englishAbilityTf resignFirstResponder];
    }
    
}

#pragma mark - UITableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    int cnt = 0;
    
    if(tableView == qualificationTable)
    {
        cnt = (int)[qualificationArray count];
    }
    else if(tableView == autocompleteTableView)
    {
        cnt = (int)[autocompleteUrls count];
    }
    
    return cnt;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *simpleTable=@"SimpleTable";
	
	UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:simpleTable];
	//cell.contentView.backgroundColor = [UIColor blackColor];
	if(cell==nil){
		cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTable]autorelease];
	}
	
//	NSArray *subviews = [[NSArray alloc]initWithArray:cell.contentView.subviews];
//	
//	for(UILabel *subview in subviews){
//		
//		[subview removeFromSuperview];
//	}
//	[subviews release];
	
	cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
    if(tableView == qualificationTable)
    {
        cell.detailTextLabel.text = [self.qualificationArray objectAtIndex:indexPath.row];
    }
    else if(tableView == autocompleteTableView)
    {
        cell.detailTextLabel.text = [autocompleteUrls objectAtIndex:indexPath.row];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    if(tableView == qualificationTable)
    {
        dropdownLabel.text = [self.qualificationArray objectAtIndex:indexPath.row];
        tableView.hidden = YES;
        
        mainDelegate.qualification = [self.qualificationArray objectAtIndex:indexPath.row];
    }
    else if(tableView == autocompleteTableView)
    {
        occupationTf.text = [autocompleteUrls objectAtIndex:indexPath.row];
        tableView.hidden = YES;
    }
	
}

#pragma mark - Touchebegan

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"occupation touchebegan");
    
    if([englishAbilityTf isFirstResponder])
    {
        [englishAbilityTf resignFirstResponder];
    }
    else if([occupationTf isFirstResponder])
    {
        [occupationTf resignFirstResponder];
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"occupation touchesEnded");
}

#pragma mark - Memory Management Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
