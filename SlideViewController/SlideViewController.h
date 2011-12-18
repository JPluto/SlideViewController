//
//  SlideViewController.h
//  SlideViewController
//
//  Created by Andrew Carter on 12/18/11.
//  Copyright (c) 2011 WillowTree Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    kSlideNavigationControllerStateNormal,
    kSlideNavigationControllerStateDragging,
    kSlideNavigationControllerStatePeeking
    
} SlideNavigationControllerState;

@class SlideViewController;

@protocol SlideViewControllerDelegate <NSObject>

@optional

@required

- (UIViewController *)initialViewController;

@end

@protocol SlideViewControllerSlideDelegate <NSObject>

@optional

- (BOOL)shouldSlideOut;

@end

@interface SlideViewController : UIViewController {
    
    IBOutlet UINavigationController *_slideNavigationController;
    id <SlideViewControllerDelegate> _delegate;
    CGPoint _startingDragPoint;
    UIView *_touchView;
    SlideNavigationControllerState _slideNavigationControllerState;
    UIView *_overlayView;
}

@property (nonatomic, assign) id <SlideViewControllerDelegate> delegate;

- (void)configureViewController:(UIViewController *)viewController;
- (void)menuBarButtonItemPressed:(id)sender;
- (void)slideOutSlideNavigationControllerView;
- (void)slideInSlideNavigationControllerView;

@end
