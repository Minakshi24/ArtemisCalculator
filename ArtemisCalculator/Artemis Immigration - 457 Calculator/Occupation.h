//
//  Occupation.h
//  Artemis Immigration - 457 Calculator
// com.Nano.ArtemisCalculator
//  Created by Minakshi on 3/28/13.
//Default-568h@2x.png
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface Occupation : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    
    
    UIImageView *logoImageView;
    
    UITableView *occupationTableView;
    
    NSMutableArray *occupationArray;
    
    UIImageView *background;
    
    float w,h;
    
    UITableView *qualificationTable;
    
    NSMutableArray *qualificationArray;
    
    UILabel *dropdownLabel;
    
    UISwitch *experienceSwitch, *citizenSwitch, *salarySwitch, *sponserSwitch;
    
    UITextField *englishAbilityTf;
    
    UIButton *doneButton;
    
    UITextField *occupationTf;
    
    UITableView *autocompleteTableView;
    
    //Database
    
    const char* dbpath;
    sqlite3 *calculatorDB;
    
    NSMutableArray *autocompleteUrls;
    
    UIImageView *passResultView;
    UIImageView *failResultView;
    
    
}

@property(nonatomic, retain) UITableView *occupationTableView;

@property(nonatomic, retain) NSMutableArray *occupationArray;

@property(nonatomic, retain) UIImageView *background;

@property(nonatomic, retain) UITableView *qualificationTable;

@property(nonatomic, retain) NSMutableArray *qualificationArray;

@end
