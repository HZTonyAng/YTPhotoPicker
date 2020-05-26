//
//  YTSelectPhotoView.m
//  Joy_property
//
//  Created by TonyAng on 2018/3/19.
//  Copyright © 2018年 ButterJie. All rights reserved.
//

#import "YTSelectPhotoView.h"
#import "HXPhotoPicker.h"

@interface YTSelectPhotoView () <HXPhotoViewDelegate>

@property (strong, nonatomic) HXPhotoManager *manager;
@property (weak, nonatomic) HXPhotoView *photoView;
@property (nonatomic, strong) NSArray *allSelectPhotoAry;
@property (nonatomic, assign) BOOL isDeleteing;

@end

@implementation YTSelectPhotoView


- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame photoMaxNum:9];
}

- (instancetype)initWithFrame:(CGRect)frame photoMaxNum:(NSInteger)photoMaxNum {
    if (self = [super initWithFrame:frame]) {
        _photoMaxNum = photoMaxNum;
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    CGFloat width = self.frame.size.width;
    HXPhotoView *photoView = [HXPhotoView photoManager:self.manager];
    photoView.frame = CGRectMake(self.margin, self.margin, width - self.margin * 2, 0);
    photoView.lineCount = 3;
    photoView.previewStyle = HXPhotoViewPreViewShowStyleDefault;
    photoView.outerCamera = YES;
    photoView.delegate = self;
    self.photoView = photoView;
    [self addSubview:self.photoView];
}

- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.configuration.openCamera = NO;
        _manager.configuration.saveSystemAblum = YES;
        _manager.configuration.photoMaxNum = 9;
        _manager.configuration.videoMaxNum = 0;
        _manager.configuration.maxNum = 9;
        _manager.configuration.reverseDate = YES;
        _manager.configuration.selectTogether = NO;
    }
    return _manager;
}

- (void)setAddImageName:(NSString *)addImageName {
    _addImageName = addImageName;
    self.photoView.addImageName = addImageName;
}

- (void)setLineCount:(NSInteger)lineCount {
    _lineCount = lineCount;
    self.photoView.lineCount = lineCount ? : 3;
}

- (void)setSpacing:(CGFloat)spacing {
    self.photoView.spacing = spacing;
}

- (void)setMargin:(CGFloat)margin {
    _margin = margin;
}

- (void)setPhotoMaxNum:(NSInteger)photoMaxNum {
    _photoMaxNum = photoMaxNum;
    self.manager.configuration.maxNum = self.photoMaxNum;
}

- (void)deleteAllData {
    if (self.selectFinish) {
        self.selectFinish([NSMutableArray new]);
    }
    if (self.allSelectPhotoAry == nil || self.allSelectPhotoAry.count == 0) {
        self.isDeleteing = NO;
        return;
    }
    
    self.isDeleteing = YES;
    for (NSInteger index = 0; index < self.photoMaxNum; index++) {
        [self.photoView deleteModelWithIndex:index];
    }
}

- (void)photoView:(HXPhotoView *)photoView deleteNetworkPhoto:(NSString *)networkPhotoUrl {
    NSSLog(@"%@",networkPhotoUrl);
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
    NSSLog(@"%@",NSStringFromCGRect(frame));
    if (self.updateFrameFinish) {
        self.updateFrameFinish(frame);
    }
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(CGRectGetMaxY(frame) + self.margin);
    }];
}

- (void)photoView:(HXPhotoView *)photoView currentDeleteModel:(HXPhotoModel *)model currentIndex:(NSInteger)index {
    NSSLog(@"%@ --> index - %ld",model,index);
}

- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    
    [allList hx_requestImageWithOriginal:isOriginal completion:^(NSArray<UIImage *> * _Nullable imageArray, NSArray<HXPhotoModel *> * _Nullable errorArray) {
        if (self.selectFinish) {
            self.selectFinish(imageArray);
        }
    }];
}

- (void)setSelectFinish:(void (^)(NSArray<UIImage *> *))selectFinish {
    _selectFinish = selectFinish;
}

- (void)setUpdateFrameFinish:(void (^)(CGRect))updateFrameFinish {
    _updateFrameFinish = updateFrameFinish;
}

@end
