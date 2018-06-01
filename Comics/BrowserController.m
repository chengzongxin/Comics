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

@property (weak, nonatomic) IBOutlet UIView *controlView;

@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (weak, nonatomic) IBOutlet UILabel *pageName;

@property (weak, nonatomic) IBOutlet UILabel *pageCount;


@property (assign, nonatomic) int page;

@end

@implementation BrowserController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    
    _scrollView.frame = self.view.bounds;
    _imgView.frame = self.view.bounds;
    _scrollView.maximumZoomScale = 5;
    //初始化缩放级别
    _scrollView.zoomScale = 1;
    _scrollView.alwaysBounceVertical = NO;
    
    _page = 0;
    [self loadPage];
    
    _slider.minimumValue = 0;
    _slider.maximumValue = _pages.count;
    
//    _imgView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
//    [self.view addGestureRecognizer:tap];
}

- (void)tap:(id)sender{
    NSLog(@"%s",__FUNCTION__);
}

//当有一个或多个手指触摸事件在当前视图或window窗体中响应
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    int x = point.x;
    int y = point.y;
    NSLog(@"touch (x, y) is (%d, %d)", x, y);
    
    _controlView.hidden = !_controlView.isHidden;
//    int value = self.view.frame.size.width / 3;
//    
//    if (x < value) {
//        [self previos:nil];
//    }else if (x < 2*value) {
//        self.navigationController.navigationBarHidden = !self.navigationController.isNavigationBarHidden;
//    }else if (x < 3*value) {
//        [self next:nil];
//    }else{
//        
//    }
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


- (IBAction)slider:(id)sender {
    UISlider *slider = sender;
    _page = slider.value;
    [self loadPage];
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
    _slider.value = _page;
    NSString *filePath = _pages[_page];
    _pageName.text = [filePath fileName];
    _pageCount.text = [NSString stringWithFormat:@"%02d/%lu",_page,(unsigned long)_pages.count];
    UIImage *img = [UIImage imageWithContentsOfFile:filePath];
    self.imgView.image = img;
    self.scrollView.contentOffset = CGPointMake(self.imgView.frame.size.width - self.scrollView.frame.size.width, self.scrollView.contentOffset.x);
}


@end
