//
//  Ingredient.h
//  Food2Fork
//
//  Created by Sarah LAFORETS on 11/05/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ingredient : NSObject
@property (retain, nonatomic) NSString *name;
- (instancetype)init: (NSString*) name;
@end
