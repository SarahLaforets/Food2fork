//
//  RecipesTableViewCell.h
//  Food2Fork
//
//  Created by Sarah LAFORETS on 11/05/2016.
//  Copyright © 2016 Sarah LAFORETS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipesTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) IBOutlet UILabel *labelPublisher;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewRecepie;
@property (strong, nonatomic) IBOutlet UIButton *btnIngredient;

@end


