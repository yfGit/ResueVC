//
//  MainViewController.m
//  ResueVC
//
//  Created by Wolf on 16/2/17.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import "MainViewController.h"
#import "YRootViewController.h"

@interface MainViewController ()<UIScrollViewDelegate>
{}

/** 重用的VC和ID对应关系 */
@property (nonatomic, strong) NSDictionary *relationOfVC;
/** 重用顺序 */
@property (nonatomic, strong) NSArray *sortIdentifiers;;
/** 总个数 */
@property (nonatomic, assign) NSInteger sumPages;

/** 重用队列 */
@property (nonatomic, strong) NSMutableArray *resueViewControllers;
/** 可见的VC */
@property (nonatomic, strong) NSMutableArray *visibleViewControllers;

/** 当前页数 */
@property (nonatomic, assign) NSUInteger currentPage;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setup];
}

- (void)awakeFromNib
{
    [self setup];
}


#pragma mark- register

- (void)registerIdentifiers:(NSArray *)identifiers andViewRelationOfVC:(NSDictionary *)relationOfVC
{
    _sortIdentifiers = identifiers;
    _relationOfVC = relationOfVC;
    
    _sumPages = identifiers.count;
}

#pragma mark- setup

- (void)setup
{
    CGRect frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    _scrollView  = [[UIScrollView alloc] initWithFrame:frame];
    
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollView];
    _scrollView.contentSize     = CGSizeMake([[UIScreen mainScreen] bounds].size.width*_sumPages, _scrollView.frame.size.height);
    _scrollView.pagingEnabled   = YES;
    _scrollView.delegate        = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator   = NO;
    
    _currentPage                = -1;
    _resueViewControllers       = [NSMutableArray array];
    _visibleViewControllers     = [NSMutableArray array];
    
    [self loadPage:0];
}

- (void)loadPage:(NSInteger)page
{
    if (_currentPage == page) return;
    
    _currentPage                = page;
    
    NSMutableArray *pageToLoad  = [NSMutableArray arrayWithArray:@[@(page-1), @(page), @(page+1), ]];
    NSMutableArray *vcToEnqueue = [NSMutableArray array];
    
    
    /*
     维护一个重用队列
     当元素离开可见范围时，removeFromSuperview 并加入重用队列（enqueue）
     当需要加入新的元素时，先尝试从重用队列获取可重用元素（dequeue）并且从重用队列移除
     如果队列为空，新建元素
     这些一般都在 scrollViewDidScroll: 方法中完成
     
     tip: 重用的地址是不变的,变的只是内容
     viewWillDisAppear 只要不是 @(page-1),@(page),@(page+1) 都会调 (removeFromSuperview,放入了重用队列)
     viewDidDisAppear  只会在只有两个的时候才会调那一个移出屏幕的(放入了重用队列,而且没有被使用)
     在will时被从重用队列里拿出来了,所以没有did
     */
    
    
    
    // 哪些是不需要再加载的,哪些需要进重用
    /**
     * vc.page 是当前scroll的第几个
     * 重用: pageToLoad不包含page的vc
     * 不需要加载: 已经存在的不需要再加载
     */
    for (YRootViewController *vc in _visibleViewControllers) {
        if ([pageToLoad containsObject:vc.yPage]) {
            [pageToLoad removeObject:vc.yPage];
        }else{
            [vcToEnqueue addObject:vc];
        }
    }
    
    
    /**
     * 重用队列:
     *  removeFromSuperview
     */
    for (YRootViewController *vc in vcToEnqueue) {
        [vc.view removeFromSuperview];
        [_visibleViewControllers removeObject:vc];
        [self enqueueReusableViewController:vc];
    }
    
    
    /**
     * 重用 或 addChildViewController
     */
    for (NSNumber *page in pageToLoad) {
        [self addViewControllerForPage:page.integerValue];
    }
    

    // 显示回调
    for (YRootViewController *vc in _visibleViewControllers) {
        if (page == vc.yPage.integerValue) {
            if (self.viewControllerDidAppear) {
                self.viewControllerDidAppear(vc);
                break;
            }
        }
    }
    
}


#pragma mark- Reuse

- (void)enqueueReusableViewController:(YRootViewController *)viewController
{
    [_resueViewControllers addObject:viewController];
}

- (YRootViewController *)dequeueViewControllerWithIdentifier:(NSString *)identifier
{
    YRootViewController *viewController;
    for (YRootViewController *vc in _resueViewControllers) {
        if ([identifier isEqualToString:vc.yIdentifierID]) {
            viewController = vc;
            break;
        }
    }
    
    if (viewController) {
        [_resueViewControllers removeObject:viewController];
    }else {
        Class cls      = _relationOfVC[identifier];
        viewController = [[cls alloc] init];
        
        [viewController willMoveToParentViewController:self];
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
    }
    
    return viewController;
}

- (void)addViewControllerForPage:(NSInteger)page
{
    if (page < 0 || page >= _sumPages)  return;
    
    NSString *identifier    = _sortIdentifiers[page];
    YRootViewController *vc = [self dequeueViewControllerWithIdentifier:identifier];
    vc.view.frame = CGRectMake(_scrollView.frame.size.width*page, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    vc.yPage                = @(page);
    [_scrollView addSubview:vc.view];
    [_visibleViewControllers addObject:vc];
    
}



#pragma makr- ScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);
    if (_currentPage != page) {
        [self loadPage:page];
    }
    
    if (scrollView.contentOffset.x < 0) {
        if (self.leftDidAppear) {
            self.leftDidAppear(self);
        }
    }
    
    if (scrollView.contentOffset.x > scrollView.contentSize.width-scrollView.frame.size.width) {
        if (self.rightDidAppear) {
            self.rightDidAppear(self);
        }
    }
}









@end
