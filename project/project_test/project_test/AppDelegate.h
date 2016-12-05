//
//  AppDelegate.h
//  project_test
//
//  Created by Luciano Moreira Turrini on 05/12/16.
//  Copyright © 2016 Luciano Turrini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

