//
//  Qualification.h
//  Artemis Immigration - 457 Calculator
//
//  Created by Minakshi on 3/28/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h" 

@interface Qualification : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    AppDelegate *mainDelegate;
    
    UIImageView *logoImageView;
    
    UITableView *qualificationTableView;
    
    NSMutableArray *qualificationArray;
}

@property(nonatomic, retain) UITableView *qualificationTableView;

@property(nonatomic, retain) NSMutableArray *qualificationArray;


@end
