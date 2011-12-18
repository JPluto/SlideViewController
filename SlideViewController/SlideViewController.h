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
@class SlideViewNavigationBar;

@protocol SlideViewControllerDelegate <NSObject>

@optional

@required

- (UIViewController *)initialViewController;

@end

@protocol SlideViewControllerSlideDelegate <NSObject>

@optional

- (BOOL)shouldSlideOut;

@end

@protocol SlideViewNavigationBarDelegate <NSObject>

- (void)slideViewNavigationBar:(SlideViewNavigationBar *)navigationBar touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)slideViewNavigationBar:(SlideViewNavigationBar *)navigationBar touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)slideViewNavigationBar:(SlideViewNavigationBar *)navigationBar touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@interface SlideViewController : UIViewController <SlideViewNavigationBarDelegate> {
    
    IBOutlet UINavigationController *_slideNavigationController;
    id <SlideViewControllerDelegate> _delegate;
    CGPoint _startingDragPoint;
    CGFloat _startingDragTransformTx;
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
