//
//  ViewController.m
//  Comics
//
//  Created by Jason on 2018/5/30.
//  Copyright © 2018年 Jason. All rights reserved.
//

#import "ViewController.h"
#import "ComicsCell.h"
#import "BrowserController.h"
#import "ChapterViewModel.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (assign, nonatomic) int page;

@property (strong, nonatomic) NSArray *chapters;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.collectionView.frame = [UIScreen mainScreen].bounds;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ComicsCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([ComicsCell class])];
    
    _chapters = [ChapterViewModel sections];
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _chapters.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(100, 100);
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    ComicsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ComicsCell class]) forIndexPath:indexPath];
    
    NSURL *url = [NSURL fileURLWithPath:_chapters[indexPath.item][0]];
    
    cell.imgView.image = [UIImage imageWithContentsOfFile:url.relativePath];
    
    cell.sectionCount.text = [[url lastPathComponent] stringByDeletingPathExtension];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"BrowserController" sender:_chapters[indexPath.item]];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    BrowserController *vc = segue.destinationViewController;
    vc.pages = sender;
}





@end
