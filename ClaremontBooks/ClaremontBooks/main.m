//
//  main.m
//  ClaremontBooks
//
//  Created by Chris on 2/22/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CMBAppDelegate.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        @try {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([CMBAppDelegate class]));
        }
        @catch (NSException * e) {
            NSLog(@"Exception in main: %@", e);
        }

    }
}
