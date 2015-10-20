//
//  Movies.h
//  RottenTomatoes
//
//  Created by Yazan Khayyat on 2015-10-19.
//  Copyright © 2015 Yazan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movies : NSObject

@property (nonatomic, strong) NSString *movieName;
@property (nonatomic, strong) NSString *movieImageName;
@property (nonatomic ,strong) NSString *movieCriticsRating;
@property (nonatomic ,strong) NSString *movieAudienceRating;
@property (nonatomic ,strong) NSString *movieSynopsis;


@end
