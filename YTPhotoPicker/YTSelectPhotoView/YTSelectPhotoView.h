//
//  YTSelectPhotoView.h
//  Joy_property
//
//  Created by TonyAng on 2018/3/19.
//  Copyright © 2018年 ButterJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTSelectPhotoView : UIView

- (instancetype)initWithFrame:(CGRect)frame photoMaxNum:(NSInteger)photoMaxNum;

@property (nonatomic,copy) void(^selectFinish)(NSArray<UIImage *> *imageDataArray);

@property (nonatomic,copy) void(^updateFrameFinish)(CGRect frame);

/**
 图片最大选择数 默认9 - 必填
 */
@property (assign, nonatomic) NSInteger photoMaxNum;

/**
 选择后图片展示每行个数 默认3
 */
@property (assign, nonatomic) NSInteger lineCount;

/**
 每个item间距 默认 3
 */
@property (assign, nonatomic) CGFloat spacing;

/**
 左右PhotoViewMargin间距 默认 12
 */
@property (assign, nonatomic) CGFloat margin;

/**
 加载图
 */
@property (nonatomic,   copy) NSString *addImageName;

/**
 清空选择图片
 */
- (void)deleteAllData;

@end
