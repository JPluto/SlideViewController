//
//  SlideViewController.m
//  SlideViewController
//
//  Created by Andrew Carter on 12/18/11.
//  Copyright (c) 2011 WillowTree Apps. All rights reserved.
//

#import "SlideViewController.h"

#import <QuartzCore/QuartzCore.h>

@implementation SlideViewController

@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"SlideViewController" bundle:nil];
    if (self) {
        
       // _slideNavigationController = [[UINavigationController alloc] init];
        _slideNavigationController.view.layer.shadowColor = [[UIColor blackColor] CGColor];
        _slideNavigationController.view.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        _slideNavigationController.view.layer.shadowRadius = 4.0f;
        _slideNavigationController.view.layer.shadowOpacity = 0.75f;
                
        _touchView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
        _touchView.exclusiveTouch = NO;
        
        _overlayView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 460.0f)];
        
        _slideNavigationControllerState = kSlideNavigationControllerStateNormal;
        
    }
    return self;
}

- (void)dealloc {
    
    [_touchView release];
    [_overlayView release];
    [_slideNavigationController release];
    
    [super dealloc];
    
}

- (void)viewDidLoad {
    
    self.view.backgroundColor = [UIColor grayColor];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
    UIImage *searchBarBackground = [UIImage imageNamed:@"search_bar_background"];
    [searchBar setBackgroundImage:[searchBarBackground stretchableImageWithLeftCapWidth:0 topCapHeight:0]];
    [self.view addSubview:searchBar];
    [searchBar release];
    
    UIViewController *initalViewController = [self.delegate initialViewController];
    [self configureViewController:initalViewController];
    
    [_slideNavigationController setViewControllers:[NSArray arrayWithObject:initalViewController] animated:NO];
    
    [self addChildViewController:_slideNavigationController];
    
    [self.view addSubview:_slideNavigationController.view];
    
}

- (void)configureViewController:(UIViewController *)viewController {
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(menuBarButtonItemPressed:)];
    viewController.navigationItem.leftBarButtonItem = [barButtonItem autorelease];
    
}

- (void)menuBarButtonItemPressed:(id)sender {
    
    UIViewController *currentViewController = [[_slideNavigationController viewControllers] objectAtIndex:0];
    
    if ([currentViewController conformsToProtocol:@protocol(SlideViewControllerSlideDelegate)] && [currentViewController respondsToSelector:@selector(shouldSlideOut)]) {
        
        
        if ([(id <SlideViewControllerSlideDelegate>)currentViewController shouldSlideOut]) {
            
            [self slideOutSlideNavigationControllerView];
            
        }
        
        
    } else {
        
        [self slideOutSlideNavigationControllerView];
        
    }
    
}

- (void)slideOutSlideNavigationControllerView {
        
    [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        _slideNavigationController.view.transform = CGAffineTransformMakeTranslation(260.0f, 0.0f);
        
    } completion:^(BOOL finished) {
        
        _slideNavigationControllerState = kSlideNavigationControllerStatePeeking;
        [_slideNavigationController.view addSubview:_overlayView];
        
    }];
    
}

- (void)slideInSlideNavigationControllerView {
            
    [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        _slideNavigationController.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        _slideNavigationControllerState = kSlideNavigationControllerStateNormal;
        [_overlayView removeFromSuperview];
        
    }];
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [touches anyObject];
    
    _startingDragPoint = [touch locationInView:self.view];
    
    if ((CGRectContainsPoint(_slideNavigationController.view.frame, _startingDragPoint)) && _slideNavigationControllerState == kSlideNavigationControllerStatePeeking) {
        
        _slideNavigationControllerState = kSlideNavigationControllerStateDragging;
        
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (_slideNavigationControllerState != kSlideNavigationControllerStateDragging)
        return;
    
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:self.view];
  
    _slideNavigationController.view.transform = CGAffineTransformMakeTranslation(260 + (location.x - _startingDragPoint.x), 0.0f);
    
    NSLog(@"%f", location.x - _startingDragPoint.x);
  
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (_slideNavigationControllerState == kSlideNavigationControllerStateDragging) {

        if (_slideNavigationController.view.transform.tx >= 260.0f) {
            
            [self slideOutSlideNavigationControllerView];            
            
        } else {
            
            [self slideInSlideNavigationControllerView];
            
        }
    
    }
    
}

@end
