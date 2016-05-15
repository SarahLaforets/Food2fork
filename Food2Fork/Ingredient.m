//
//  Ingredient.m
//  Food2Fork
//
//  Created by Sarah LAFORETS on 11/05/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import "Ingredient.h"

@implementation Ingredient
- (instancetype)init: (NSString*) name {
    self = [super init];
    if (self) {
        self.name = name;
    }
    return self;
}
@end
