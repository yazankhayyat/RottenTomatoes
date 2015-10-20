//
//  MoviesCollectionViewCell.h
//  RottenTomatoes
//
//  Created by Yazan Khayyat on 2015-10-19.
//  Copyright © 2015 Yazan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;

@end
