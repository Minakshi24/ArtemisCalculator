//
//  EnglishAbility.h
//  Artemis Immigration - 457 Calculator
//
//  Created by Minakshi on 3/28/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface EnglishAbility : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    AppDelegate *mainDelegate;
    
    UIImageView *logoImageView;
    
    UITableView *englishAbilityTableView;
    
    NSMutableArray *englishAbilityArray;
}

@property(nonatomic, retain) UITableView *englishAbilityTableView;

@property(nonatomic, retain) NSMutableArray *englishAbilityArray;


@end
