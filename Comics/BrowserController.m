//
//  BrowserController.m
//  Comics
//
//  Created by Jason on 2018/5/30.
//  Copyright © 2018年 Jason. All rights reserved.
//

#import "BrowserController.h"
#import "NSString+fileName.h"

@interface BrowserController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;


@property (assign, nonatomic) int page;

@end

@implementation BrowserController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _scrollView.frame = self.view.bounds;
    _imgView.frame = self.view.bounds;
    _scrollView.maximumZoomScale = 5;
    //初始化缩放级别
    _scrollView.zoomScale = 1;
    _scrollView.alwaysBounceVertical = NO;
    
    _page = 0;
    [self loadPage];
}

// 设置UIScrollView中要缩放的视图
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imgView;
}

// 让UIImageView在UIScrollView缩放后居中显示
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.imgView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                          scrollView.contentSize.height * 0.5 + offsetY);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGSize imgSize = self.imgView.image.size;
    CGSize imgViewSize = self.imgView.frame.size;
    CGFloat offsetH = (imgViewSize.height - imgSize.height*imgViewSize.width/imgSize.width)/2;
    if (isnan(offsetH)) return;
    scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, offsetH);
}


- (IBAction)previos:(id)sender {
    if (self.page == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    self.page--;
    [self loadPage];
}
- (IBAction)next:(id)sender {
    self.page++;
    [self loadPage];
}

- (void)loadPage{
    if (self.page > _pages.count - 1 || self.page < 0) {
        if (_page > _pages.count) {
            _page = (int)_pages.count;
        }
        return;
    }
    NSString *filePath = _pages[_page];
    self.title = [filePath fileName];
    UIImage *img = [UIImage imageWithContentsOfFile:filePath];
    self.imgView.image = img;
    self.scrollView.contentOffset = CGPointMake(self.imgView.frame.size.width - self.scrollView.frame.size.width, self.scrollView.contentOffset.x);
}


@end
