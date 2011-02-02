//
//  shapes1AppDelegate.h
//  shapes1
//
//  Created by Devin Chalmers on 8/28/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class shapes1ViewController;

@interface shapes1AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    shapes1ViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet shapes1ViewController *viewController;

@end

