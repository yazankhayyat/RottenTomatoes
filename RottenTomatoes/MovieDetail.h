//
//  ViewController.h
//  RottenTomatoes
//
//  Created by Yazan Khayyat on 2015-10-19.
//  Copyright © 2015 Yazan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movies.h"

@interface MovieDetail : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *criticsScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *audienceScoreLabel;

@property (weak, nonatomic) IBOutlet UITextView *synopsisTextView;
@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;

@property (strong, nonatomic) Movies *movie;

@end

