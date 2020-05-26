//
//  ViewController.m
//  YTPhotoPicker
//
//  Created by TonyAng on 2020/5/22.
//  Copyright © 2020 TonyAng. All rights reserved.
//

#import "ViewController.h"
#import "YTSelectPhotoView.h"

@interface ViewController ()

@property (nonatomic, strong) YTSelectPhotoView *selectPhotoView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI {
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.selectPhotoView];
    [self.selectPhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(100);
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(15);
        make.height.offset(78);
    }];
    
    self.selectPhotoView.selectFinish = ^(NSArray<UIImage *> *imageDataArray) {
                NSLog(@"imageDataArray----->%@",imageDataArray);
    };
}

- (YTSelectPhotoView *)selectPhotoView {
    if (!_selectPhotoView) {
        _selectPhotoView = [[YTSelectPhotoView alloc] initWithFrame:CGRectMake(15, 0, self.view.bounds.size.width - 30, 78) photoMaxNum:9];
        _selectPhotoView.backgroundColor = [UIColor clearColor];
        _selectPhotoView.lineCount = 3;
        _selectPhotoView.spacing = 12;
        _selectPhotoView.addImageName = @"feedback_pic";
    }
    return _selectPhotoView;
}

@end
