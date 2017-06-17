//
//  AppDelegate.h
//  GPUImage的使用
//
//  Created by 王志盼 on 17/06/2017.
//  Copyright © 2017 王志盼. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

