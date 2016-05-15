//
//  RecipeDetailsViewController.m
//  Food2Fork
//
//  Created by Sarah LAFORETS on 12/05/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import "RecipeDetailsViewController.h"

@interface RecipeDetailsViewController ()

@end

@implementation RecipeDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set all attributes with the good value
    _pictureRecipe.image = _recipe.picture;
    _labelPublisher.text = _recipe.publisher;
    _labelTitle.text = _recipe.name;
    _btnLink.titleLabel.text = @"Recipe Page";
    
    // set all ingredients in one string and display as a list
    NSMutableString * ingredients = [NSMutableString stringWithCapacity:[_recipe ingredients].count*30];
    for (Ingredient *ingredient in [_recipe ingredients]) {
        [ingredients appendFormat:@"\u2022 %@\n", ingredient.name];
    }
    
    // Display ingredients
    _tfIngredients.text = ingredients;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Action
- (IBAction)accessLink:(id)sender {
    //Access to the recipe web site
    [[UIApplication sharedApplication] openURL:_recipe.URL];
}

@end
