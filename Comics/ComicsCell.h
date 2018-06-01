//
//  ComicsCell.h
//  Comics
//
//  Created by Jason on 2018/5/30.
//  Copyright © 2018年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComicsCell : UICollectionViewCell<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *sectionCount;

@end
