 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol RotateAnimationViewDelegate <NSObject>

-(void)clickFireBtn;

@end
@interface RotateAnimationView : UIView

/**
 init

 @param frame 视图坐标
 @param pathWidth 轨道的宽度
 @param markWidth 小图标的宽度
 @param animationTime 每次执行动画的时间
 */
-(instancetype)initWithFrame:(CGRect)frame pathWidth:(CGFloat)pathWidth markWidth:(CGFloat)markWidth animationTime:(CGFloat)animationTime strokeColor:(UIColor *)strokeColor;
//小图标的宽度
@property (nonatomic, assign) CGFloat markWidth;
//轨道的宽度
@property (nonatomic, assign) CGFloat pathWidth;
//每次执行动画的时间
@property (nonatomic, assign) CGFloat animationTime;
//轨道颜色
@property (nonatomic, strong) UIColor *strokeColor;
-(void)setTotalStep:(CGFloat)totalStep  withCurrentStep:(CGFloat)currentStep  clockwise:(BOOL)isclockwise;

@property (nonatomic, weak) id<RotateAnimationViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
