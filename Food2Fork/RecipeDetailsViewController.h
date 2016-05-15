//
//  RecipeDetailsViewController.h
//  Food2Fork
//
//  Created by Sarah LAFORETS on 12/05/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface RecipeDetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *pictureRecipe;
@property (strong, nonatomic) IBOutlet UILabel *labelPublisher;
@property (strong, nonatomic) IBOutlet UITextView *tfIngredients;

@property (strong, nonatomic) IBOutlet UIButton *btnLink;

@property (strong, nonatomic) IBOutlet UILabel *labelTitle;

@property (retain, nonatomic) Recipe *recipe;
@end
