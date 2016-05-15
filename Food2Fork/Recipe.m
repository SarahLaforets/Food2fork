//
//  Recipe.m
//  Food2Fork
//
//  Created by Sarah LAFORETS on 11/05/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe

- (instancetype)init: (NSString*) name byPublicher: (NSString*) publisher withPicture: (NSURL*) pictureURL withURL: (NSURL*) URL andIngredients: (NSMutableArray<Ingredient*>*) ingredients withID: (NSString*) idRecipe {
    self = [super init];
    if (self) {
        self.name = name;
        self.publisher = publisher;
        NSLog(@"%@", pictureURL);
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: pictureURL];
        self.picture = [UIImage imageWithData: imageData];
        
        self.URL = URL;
        self.ingredients = ingredients;
        self.idRecipe = idRecipe;
    }
    return self;
}

- (instancetype)init: (NSString*) name byPublicher: (NSString*) publisher withPicture: (NSURL*) pictureURL withURL: (NSURL*) URL withID: (NSString*) idRecipe{
    self = [super init];
    if (self) {
        self.name = name;
        self.publisher = publisher;
        
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: pictureURL];
        self.picture = [UIImage imageWithData: imageData];
        
        self.URL = URL;
        self.idRecipe = idRecipe;
    }
    return self;
}

@end
