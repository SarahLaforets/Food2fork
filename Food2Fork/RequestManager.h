//
//  RequestManager.h
//  Food2Fork
//
//  Created by Sarah LAFORETS on 11/05/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "Recipe.h"
#import "Ingredient.h"

@interface RequestManager : NSObject
+ (instancetype)sharedInstance;
- (void)getAllRecipes:(NSString*)string andCompletionHandler:(void(^)(NSMutableArray<Recipe*> *recipes))completionHandler;
- (void)getARecipe:(NSString*)idRecipe andCompletionHandler:(void(^)(Recipe *recipe))completionHandler;
@end
