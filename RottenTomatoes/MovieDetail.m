//
//  ViewController.m
//  RottenTomatoes
//
//  Created by Yazan Khayyat on 2015-10-19.
//  Copyright © 2015 Yazan. All rights reserved.
//

#import "MovieDetail.h"

@interface MovieDetail ()
@property (nonatomic, strong) NSMutableArray *moviesArray;

@end

@implementation MovieDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateLabels];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateLabels {
    self.criticsScoreLabel.text = self.movie.movieCriticsRating;
    self.audienceScoreLabel.text = self.movie.movieAudienceRating;
    self.synopsisTextView.text = self.movie.movieSynopsis;
    self.movieNameLabel.text = self.movie.movieName;
}

@end
