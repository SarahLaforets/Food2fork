//
//  Recipe.h
//  Food2Fork
//
//  Created by Sarah LAFORETS on 11/05/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ingredient.h"
#import <UIKit/UIKit.h>

@interface Recipe : NSObject

- (instancetype)init: (NSString*) name byPublicher: (NSString*) publisher withPicture: (NSURL*) pictureURL withURL: (NSURL*) URL andIngredients: (NSMutableArray<Ingredient*>*) ingredients withID: (NSString*) idRecipe;
- (instancetype)init: (NSString*) name byPublicher: (NSString*) publisher withPicture: (NSURL*) pictureURL withURL: (NSURL*) URL withID: (NSString*) idRecipe;

@property (retain, nonatomic) NSString *name;
@property (retain, nonatomic) NSString *publisher;
@property (retain, nonatomic) UIImage *picture;
@property (retain, nonatomic) NSURL *URL;
@property (retain, nonatomic) NSString *idRecipe;

@property (retain, nonatomic) NSMutableArray<Ingredient *> *ingredients;
@end
