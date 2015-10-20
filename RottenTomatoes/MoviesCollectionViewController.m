//
//  MoviesCollectionViewController.m
//  RottenTomatoes
//
//  Created by Yazan Khayyat on 2015-10-19.
//  Copyright © 2015 Yazan. All rights reserved.
//

#import "MoviesCollectionViewController.h"
#import "Movies.h"
#import "MoviesCollectionViewCell.h"
#import "MovieDetail.h"

@interface MoviesCollectionViewController ()

@property (nonatomic, strong) NSMutableArray *movies;

@end

@implementation MoviesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.movies = [[NSMutableArray alloc] init];
   
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    NSString *urlString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=j9fhnct2tp8wu2q9h75kanh9&page_limit=50";
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSError *jsonError;
            NSDictionary *myMoviesDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            if (!jsonError) {
                NSArray *myMoviesArray = myMoviesDictionary[@"movies"];
                for (NSDictionary *dictionary in myMoviesArray) {
                    Movies *movie = [[Movies alloc] init];
                    NSDictionary *thePostersDictionary = dictionary[@"posters"];
                    NSString *imageURL = thePostersDictionary[@"original"];
                    
                    NSLog(@"string %@", imageURL);
                    
                    NSArray *stringsOfURLArray = [imageURL componentsSeparatedByString:@"/"];
                    NSInteger startingPoint = [stringsOfURLArray indexOfObject:@"dkpu1ddg7pbsk.cloudfront.net"];
                    NSLog(@"%ld",startingPoint);
                    
                    NSInteger arrayCount = stringsOfURLArray.count;
                    NSRange arrayRange = NSMakeRange(startingPoint, arrayCount - startingPoint);
                    NSArray *newArray = [stringsOfURLArray subarrayWithRange:arrayRange];
                    NSString *prefix = @"https://";
                    NSString *newHDImageURL = [prefix stringByAppendingString:[newArray componentsJoinedByString:@"/"]];
                    NSLog(@"%@", newHDImageURL);
                    
                    NSString *movieTitle = dictionary[@"title"];
                    NSDictionary *ratings = dictionary[@"ratings"];
                    NSString *audienceRating = [NSString stringWithFormat:@"%@", ratings[@"audience_score"]];
                    NSString *criticsRating = [NSString stringWithFormat:@"%@", ratings[@"critics_score"]];
                    NSString *synopsis = dictionary[@"synopsis"];
                    movie.movieAudienceRating = audienceRating;
                    movie.movieCriticsRating = criticsRating;
                    movie.movieSynopsis = synopsis;
                    
                    movie.movieImageName = newHDImageURL;
                    movie.movieName = movieTitle;
                    [self.movies addObject:movie];
                }
            }
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });

    }];
    [dataTask resume];
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MoviesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    Movies *movie = self.movies[indexPath.item];
    NSURL *imageURL = [NSURL URLWithString:movie.movieImageName];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    cell.movieImage.image = [UIImage imageWithData:imageData];
    cell.movieNameLabel.text = movie.movieName;
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showMovieDetails"] ) {
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems]objectAtIndex:0];
        Movies *movie = self.movies[indexPath.item];
        MovieDetail *detailVC = segue.destinationViewController;
        detailVC.movie = movie;



    }
    
    
}



@end
