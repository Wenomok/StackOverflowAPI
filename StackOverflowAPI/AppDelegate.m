//
//  AppDelegate.m
//  StackOverflowAPI
//
//  Created by Vladislav on 11.04.17.
//  Copyright © 2017 Vladislav. All rights reserved.
//

#import "AppDelegate.h"
#import "SOMainTableViewController.h"
#import "SORevealViewController.h"
#import "SOMenuTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    SORevealViewController *revealController = (SORevealViewController *)self.window.rootViewController;
//    UINavigationController *navigationController = (UINavigationController *)revealController.frontViewController;
//    SOMenuTableViewController *menuController = (SOMenuTableViewController *)revealController.rearViewController;
//    SOMainTableViewController *mainTableController = (SOMainTableViewController *)navigationController.topViewController;
//    mainTableController.managedObjectContext = self.persistentContainer.viewContext;
//    SORevealViewController *revealController = [[SORevealViewController alloc] init];
//    self.window.rootViewController = revealController;
//    SOMainTableViewController *mainTableController = [[SOMainTableViewController alloc] init];
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainTableController];
//    revealController.frontViewController = navigationController;
//    mainTableController = (SOMainTableViewController *)[navigationController topViewController];
//    self.mainTableViewController = [[SOMainTableViewController alloc] init];
//    self.mainTableViewController.managedObjectContext = self.persistentContainer.viewContext;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer
{
    @synchronized (self) {
        if(_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"SODataModel"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error)
             {
                 if(error != nil) {
                     NSLog(@"unresolved error %@, %@", error, error.userInfo);
                     abort();
                 }
             }];
        }
    }
    return _persistentContainer;
}

- (void)saveContext
{
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if([context hasChanges] && ![context save:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        //Только при отладке приложения, выводя в prod удалить
        abort();
    }
}

@end
