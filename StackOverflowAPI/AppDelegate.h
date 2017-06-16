//
//  AppDelegate.h
//  StackOverflowAPI
//
//  Created by Vladislav on 11.04.17.
//  Copyright © 2017 Vladislav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData/CoreData.h"
#import "SOMainTableViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (strong, nonatomic) SOMainTableViewController *mainTableViewController;

- (void)saveContext;

@end

