//
//  RecipesTableViewController.m
//  Food2Fork
//
//  Created by Sarah LAFORETS on 11/05/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import "RecipesTableViewController.h"

@interface RecipesTableViewController ()
@property (retain, nonatomic) NSMutableArray<Recipe*> *recipes;
@end

@implementation RecipesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Request to the manager all recipes
    [[RequestManager sharedInstance] getAllRecipes:@"ok" andCompletionHandler:^(NSMutableArray<Recipe *> *recipes) {
        self.recipes = recipes;
        UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backTableView.png"]];
        [tempImageView setFrame:self.tableView.frame];
        
        self.tableView.backgroundView = tempImageView;
        [self.tableView reloadData];
    }];
    
    // Add background colo image to the table view
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"waitScreen.png"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recipes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recipe" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.imageViewRecepie.image = [self.recipes[indexPath.row] picture];
    cell.labelTitle.text = [self.recipes[indexPath.row] name];
    cell.labelPublisher.text = [self.recipes[indexPath.row] publisher];
    cell.btnIngredient.tag = indexPath.row;
    
    if(indexPath.row % 2 == 0){
        cell.backgroundColor = [[UIColor alloc] initWithRed:255/255.f green:255/255.f blue:204/255.f alpha:1];
    } else {
        cell.backgroundColor = [[UIColor alloc] initWithRed:204/255.f green:255/255.f blue:153/255.f alpha:1];
    }
    
    
    cell.separatorInset = UIEdgeInsetsMake(0.f, cell.bounds.size.width, 0.f, 0.f);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *id = [self.recipes[indexPath.row] idRecipe];
    [[RequestManager sharedInstance] getARecipe:id andCompletionHandler:^(Recipe *recipe) {
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RecipeDetailsViewController *recipeDetailsViewController = (RecipeDetailsViewController *)[mainStoryBoard instantiateViewControllerWithIdentifier:@"recipeDetailsViewController"];
        recipeDetailsViewController.recipe = recipe;
        [[self navigationController] pushViewController:recipeDetailsViewController animated:true];
    }];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Action

- (IBAction)displayIngredients:(id)sender {
    UIButton *senderButton = (UIButton *)sender;
    NSIndexPath *path = [NSIndexPath indexPathForRow:senderButton.tag inSection:0];
    NSString *id = [self.recipes[path.row] idRecipe];
    [[RequestManager sharedInstance] getARecipe:id andCompletionHandler:^(Recipe *recipe) {
        NSString *ingredients;
        int i = 0;
        for (Ingredient *ingredient in [recipe ingredients]) {
            if (i == 0) {
                ingredients = [NSString stringWithFormat: @"%@",ingredient.name];
            } else {
                ingredients = [NSString stringWithFormat: @"%@ \n%@",ingredients, ingredient.name];
            }
            i++;
        }
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Ingredients"
                                      message:ingredients
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handel your yes please button action here
                                        
                                        
                                    }];
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
