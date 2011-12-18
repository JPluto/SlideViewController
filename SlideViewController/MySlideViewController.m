//
//  MySlideViewController.m
//  SlideViewController
//
//  Created by Andrew Carter on 12/18/11.
//  Copyright (c) 2011 WillowTree Apps. All rights reserved.
//

#import "MySlideViewController.h"

#import "HomeViewController.h"

@implementation MySlideViewController

- (UIViewController *)initialViewController {
    
    HomeViewController *homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    
    return [homeViewController autorelease];
    
}

@end
