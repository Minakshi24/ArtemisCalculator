//
//  AppDelegate.h
//  Artemis Immigration - 457 Calculator
//
//  Created by Minakshi on 3/28/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Occupation.h"

@class ViewController;


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    Occupation *occupation;
    
    UINavigationController *navigationController;
    
    NSString *occupationStr, *qualification, *occupationYears, *country, *englishAbility, *salary, *sponser;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) Occupation *occupation;

@property (strong, nonatomic) UINavigationController *navigationController;

@property (strong, nonatomic) NSString *occupationStr, *qualification, *occupationYears, *country, *englishAbility, *salary, *sponser;

@end
