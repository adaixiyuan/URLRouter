//
//  URLRouter.m
//  URLRouterDemo
//
//  Created by Dariel on 16/8/17.
//  Copyright © 2016年 DarielChen. All rights reserved.
//  

#import "URLRouter.h"
#import "URLNavgation.h"

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

@interface URLRouter()

/** 存储读取的plist文件数据 */
@property(nonatomic,strong) NSDictionary *configDict;

@end

@implementation URLRouter

URLSingletonM(URLRouter)

+ (void)loadConfigDictFromPlist:(NSString *)pistName {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:pistName ofType:nil];
    NSDictionary *configDict = [NSDictionary dictionaryWithContentsOfFile:path];

    if (configDict) {
        [URLRouter sharedURLRouter].configDict = configDict;
    }else {
        DLog(@"请按照说明添加对应的plist文件");
    }
}

#pragma mark - push
+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    [URLNavgation pushViewController:viewController animated:animated replace:NO];
}

+ (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated replace:(BOOL)replace {
    [URLNavgation pushViewController:viewController animated:animated replace:replace];
}

+ (void)pushURLString:(NSString *)urlString animated:(BOOL)animated {

    UIViewController *viewController = [UIViewController initFromString:urlString fromConfig:[URLRouter sharedURLRouter].configDict];
    [URLNavgation pushViewController:viewController animated:animated replace:NO];
}

+ (void)pushURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated{
    UIViewController *viewController = [UIViewController initFromString:urlString withQuery:query fromConfig:[URLRouter sharedURLRouter].configDict];    
    [URLNavgation pushViewController:viewController animated:animated replace:NO];
}

+ (void)pushURLString:(NSString *)urlString animated:(BOOL)animated replace:(BOOL)replace{
    UIViewController *viewController = [UIViewController initFromString:urlString fromConfig:[URLRouter sharedURLRouter].configDict];
    [URLNavgation pushViewController:viewController animated:YES replace:replace];
}

#pragma mark - present
+ (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^ __nullable)(void))completion {
    [URLNavgation presentViewController:viewControllerToPresent animated:flag completion:completion];
}

+ (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag withNavigationClass:(Class)classType completion:(void (^ __nullable)(void))completion {

    if ([classType isSubclassOfClass:[UINavigationController class]]) {
        UINavigationController *nav =  [[classType alloc]initWithRootViewController:viewControllerToPresent];
        [URLNavgation presentViewController:nav animated:flag completion:completion];
    }
}


+ (void)presentURLString:(NSString *)urlString animated:(BOOL)animated completion:(void (^ __nullable)(void))completion{
    UIViewController *viewController = [UIViewController initFromString:urlString fromConfig:[URLRouter sharedURLRouter].configDict];
    [URLNavgation presentViewController:viewController animated:animated completion:completion];
}


+ (void)presentURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated completion:(void (^ __nullable)(void))completion{
    UIViewController *viewController = [UIViewController initFromString:urlString withQuery:query fromConfig:[URLRouter sharedURLRouter].configDict];
    [URLNavgation presentViewController:viewController animated:animated completion:completion];
}


+ (void)pushURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated replace:(BOOL)replace{
    UIViewController *viewController = [UIViewController initFromString:urlString withQuery:query fromConfig:[URLRouter sharedURLRouter].configDict];
    [URLNavgation pushViewController:viewController animated:animated replace:replace];
}


+ (void)presentURLString:(NSString *)urlString animated:(BOOL)animated withNavigationClass:(Class)classType completion:(void (^ __nullable)(void))completion{
    
    UIViewController *viewController = [UIViewController initFromString:urlString fromConfig:[URLRouter sharedURLRouter].configDict];
    if ([classType isSubclassOfClass:[UINavigationController class]]) {
        UINavigationController *nav =  [[classType alloc]initWithRootViewController:viewController];
        [URLNavgation presentViewController:nav animated:animated completion:completion];
    }
}

+ (void)presentURLString:(NSString *)urlString query:(NSDictionary *)query animated:(BOOL)animated withNavigationClass:(Class)clazz completion:(void (^ __nullable)(void))completion{
    UIViewController *viewController = [UIViewController initFromString:urlString withQuery:query fromConfig:[URLRouter sharedURLRouter].configDict];
    if ([clazz isSubclassOfClass:[UINavigationController class]]) {
        UINavigationController *nav =  [[clazz alloc]initWithRootViewController:viewController];
        [URLNavgation presentViewController:nav animated:animated completion:completion];
    }
}
#pragma mark - pop
+ (void)popViewControllerAnimated:(BOOL)animated {
    [URLNavgation popViewControllerWithTimes:1 animated:animated];
}

+ (void)popTwiceViewControllerAnimated:(BOOL)animated {
    [URLNavgation popTwiceViewControllerAnimated:animated];
}
+ (void)popViewControllerWithTimes:(NSUInteger)times animated:(BOOL)animated {
    [URLNavgation popViewControllerWithTimes:times animated:animated];
}
+ (void)popViewControllerWithURLString:(NSString *)urlString animated:(BOOL)animated{
    
    UIViewController *viewController = [self viewControllerForURLString:urlString];
    [URLNavgation popViewController:viewController animated:animated];
}
+ (void)popToRootViewControllerAnimated:(BOOL)animated {
    [URLNavgation popToRootViewControllerAnimated:animated];
}

#pragma mark - dismiss
+ (void)dismissViewControllerAnimated: (BOOL)flag completion:(void (^ __nullable)(void))completion {
    [URLNavgation dismissViewControllerWithTimes:1 animated:flag completion:completion];
}
+ (void)dismissTwiceViewControllerAnimated: (BOOL)flag completion:(void (^ __nullable)(void))completion {
    [URLNavgation dismissTwiceViewControllerAnimated:flag completion:completion];
}

+ (void)dismissViewControllerWithTimes:(NSUInteger)times animated:(BOOL)flag completion: (void (^ __nullable)(void))completion {
    [URLNavgation dismissViewControllerWithTimes:times animated:flag completion:completion];
}

+ (void)dismissToRootViewControllerAnimated: (BOOL)flag completion:(void (^ __nullable)(void))completion {
    [URLNavgation dismissToRootViewControllerAnimated:flag completion:completion];
}

#pragma mark -
+ (UIViewController*)currentViewController {
    return [URLNavgation sharedURLNavgation].currentViewController;
}

+ (UINavigationController*)currentNavigationViewController {
    return [URLNavgation sharedURLNavgation].currentNavigationViewController;
}

+ (UIViewController*)viewControllerForURLString:(NSString *)urlString
{
    UIViewController *VC = nil;
    for (UIViewController *vc in [[URLNavgation sharedURLNavgation].currentNavigationViewController viewControllers]) {
        if ([[vc.originUrl absoluteString] isEqualToString:urlString]) {
            VC = vc;
        }
    }
    return VC;
}

@end
