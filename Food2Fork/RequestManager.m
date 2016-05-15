//
//  RequestManager.m
//  Food2Fork
//
//  Created by Sarah LAFORETS on 11/05/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager

#pragma mark - Singleton

+ (instancetype)sharedInstance {
    static RequestManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RequestManager alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Request all Recipes

- (void)getAllRecipes:(NSString*)string andCompletionHandler:(void(^)(NSMutableArray<Recipe*> *recipes))completionHandler {
    
    //URL from the api to get a new random picture
    NSURL *URL = [NSURL URLWithString:@"http://food2fork.com/api/search?key=540c68b31becbe464e75be7bfcb2057a"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    // Set the response acceptable with XML
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =  [manager.responseSerializer.acceptableContentTypes
                                                          setByAddingObject:@"text/json"];
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            // Success
            
            NSMutableArray<Recipe*> *recipesMA = [[NSMutableArray<Recipe*> alloc] init];
            
            NSError *localError = nil;
            NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&localError];
            NSArray *recipes = [parsedObject valueForKey:@"recipes"];
            
            for (NSDictionary *recipeDic in recipes) {
                NSLog(@"Recette : %@", recipeDic);
                Recipe *recipe = [[Recipe alloc] init];
                NSString *name;
                NSString *publisher;
                NSURL *pictureURL;
                NSURL *URL;
                NSString *id;
            
                for (NSString *key in recipeDic) {
                    if ([key isEqualToString:@"image_url"]) {
                        pictureURL = [NSURL URLWithString:[recipeDic valueForKey:key]];
                    } else if ([key isEqualToString:@"publisher"]) {
                        publisher = [recipeDic valueForKey:key];
                    } else if ([key isEqualToString:@"title"]) {
                        name = [recipeDic valueForKey:key];
                    } else if ([key isEqualToString:@"source_url"]) {
                        URL = [NSURL URLWithString:[recipeDic valueForKey:key]];
                    } else if ([key isEqualToString:@"recipe_id"]) {
                        id = [recipeDic valueForKey:key];
                    }
                }
                
                recipe = [recipe init:name byPublicher:publisher withPicture:pictureURL withURL:URL withID:id];
                
                [recipesMA addObject:recipe];
            }
            completionHandler(recipesMA);
        }
    }];
    
    [task resume];
}

#pragma mark - Request a recipe

- (void)getARecipe:(NSString*)idRecipe andCompletionHandler:(void(^)(Recipe *recipe))completionHandler {
    
    //URL from the api to get a new random picture
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat: @"http://food2fork.com/api/get?key=540c68b31becbe464e75be7bfcb2057a&rId=%@",idRecipe]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    // Set the response acceptable with XML
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =  [manager.responseSerializer.acceptableContentTypes
                                                          setByAddingObject:@"text/json"];
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            // Success
            
            Recipe *recipe;
            
            NSError *localError = nil;
            NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&localError];
            NSLog(@"Parsed %@", parsedObject);
            NSDictionary *recipes = [parsedObject valueForKey:@"recipe"];
            Recipe *mRecipe = [[Recipe alloc] init];
            NSString *name = [recipes valueForKey:@"title"];
            NSString *publisher = [recipes valueForKey:@"publisher"];
            NSURL *pictureURL = [NSURL URLWithString:[recipes valueForKey:@"image_url"]];
            NSURL *URL = [NSURL URLWithString:[recipes valueForKey:@"source_url"]];
            NSString *id = [recipes valueForKey:@"recipe_id"];
            NSMutableArray<Ingredient*> *ingredients = [[NSMutableArray<Ingredient*> alloc] init];;
            
            NSDictionary *recipeDic = [recipes valueForKey:@"ingredients"];
            NSLog(@"Recette : %@", recipeDic);
            
            for (NSString *ingredientName in recipeDic) {
                Ingredient *ingredient = [[Ingredient alloc] init];
                ingredient = [ingredient init:ingredientName];
                [ingredients addObject:ingredient];
            }
            
            mRecipe = [mRecipe init:name byPublicher:publisher withPicture:pictureURL withURL:URL andIngredients:ingredients withID:id];
            completionHandler(mRecipe);
        }
    }];
    
    [task resume];
}
@end
