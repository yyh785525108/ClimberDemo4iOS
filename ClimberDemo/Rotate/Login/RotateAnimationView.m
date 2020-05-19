

#import "RotateAnimationView.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]
#define totalCount 1000
@interface RotateAnimationView()

@property (nonatomic, strong)UIView *circleView;

@property (nonatomic,strong)CAShapeLayer *backLayer;

@property (nonatomic,strong)CAShapeLayer *progressLayer;

//单前的进度
@property (nonatomic,assign)CGFloat currentProgress;

//开始角度
@property (nonatomic,assign)CGFloat startAngle;

@property (nonatomic, strong)UIButton *hotImageView;

@property (nonatomic,assign)CGFloat currentStep;
@property (nonatomic,assign)CGFloat totalStep;

@property (nonatomic,assign)NSInteger Step;


@end

@implementation RotateAnimationView{
    
    UILabel *centerLabel;
    NSTimer *timer;
    int spaceStep;
}


-(instancetype)initWithFrame:(CGRect)frame pathWidth:(CGFloat)pathWidth markWidth:(CGFloat)markWidth animationTime:(CGFloat)animationTime strokeColor:(UIColor *)strokeColor{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.frame = frame;
        
        self.Step = 1200;
      
        self.pathWidth = pathWidth;
        self.markWidth = markWidth;
        self.animationTime = animationTime;
        self.strokeColor = strokeColor;
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.currentProgress = 0.30f;
    self.startAngle = -M_PI;
    float centerX = self.bounds.size.width/2.0;
    float centerY = self.bounds.size.height/2.0;
  
    //半径
    float radius = (self.bounds.size.width-self.pathWidth)/2.0;
  
    //贝塞尔路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:(-M_PI) endAngle:M_PI clockwise:YES];
    //背景圆环
    CAShapeLayer *backLayer = [CAShapeLayer layer];
    self.backLayer = backLayer;
    backLayer.frame = self.bounds;
    backLayer.fillColor =  [[UIColor clearColor] CGColor];
    backLayer.strokeColor = self.strokeColor.CGColor;
    backLayer.lineWidth = self.pathWidth;
    backLayer.path = [path CGPath];
    backLayer.strokeEnd = 1.0;
    [self.layer addSublayer:backLayer];
    
    //进度layer
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    self.progressLayer = progressLayer;
    progressLayer.frame = self.bounds;
    progressLayer.fillColor =  [[UIColor clearColor] CGColor];
    progressLayer.strokeColor = [UIColor whiteColor].CGColor;
    progressLayer.lineWidth = self.pathWidth;
    progressLayer.path = [path CGPath];
    progressLayer.lineCap = kCALineCapRound;
    progressLayer.strokeEnd = 0.0;
    [self.layer addSublayer:progressLayer];
    
    //设置渐变颜色
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    [gradientLayer setColors:@[(id)[[UIColor redColor] CGColor],(id)[[UIColor redColor] CGColor]]];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    [gradientLayer setMask:progressLayer]; //用progressLayer来截取渐变层
    [self.layer addSublayer:gradientLayer];
       
    centerLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetHeight(self.frame)/2 - 100, CGRectGetHeight(self.frame)/2 - 20, 200, 40)];
    [self addSubview:centerLabel];
    centerLabel.text = @"1200";
    centerLabel.textAlignment = NSTextAlignmentCenter;
    centerLabel.textColor = [UIColor whiteColor];
    centerLabel.font = [UIFont systemFontOfSize:50];
      
     
    UILabel *toplabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetHeight(self.frame)/2 - 100, CGRectGetMinY(centerLabel.frame) - 40 , 200, 30)];
    [self addSubview:toplabel];
    toplabel.textAlignment = NSTextAlignmentCenter;
    toplabel.text = @"Steps";
    toplabel.textColor = [UIColor whiteColor];
    toplabel.font = [UIFont systemFontOfSize:30];
      
      
    UILabel *bottomlabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetHeight(self.frame)/2 - 100, CGRectGetMaxY(centerLabel.frame)+10 , 200, 20)];
    [self addSubview:bottomlabel];
    bottomlabel.textAlignment = NSTextAlignmentCenter;
    bottomlabel.text = @"today";
    bottomlabel.textColor = [UIColor whiteColor];
    bottomlabel.font = [UIFont systemFontOfSize:17];

    
}

-(void)setTotalStep:(CGFloat)totalStep withCurrentStep:(CGFloat)currentStep clockwise:(BOOL)isclockwise  {
    _currentStep = currentStep;
     _totalStep = totalStep;
    CGFloat progress = [[NSString stringWithFormat:@"%.2f",(CGFloat)(currentStep/totalStep)] floatValue];
    if (progress >= 1.0f) {
        progress = 1.0f;
    }
    
    if (progress <= 0.0) {
        progress = 0.0;
    }

  
    [self doAnimationProgeress:progress  clockwise:isclockwise];
    self.currentProgress = progress;


       
}



-(void)doAnimationProgeress:(CGFloat)progress clockwise:(BOOL)isclockwise{
   
    if (progress == self.currentProgress) return;
   
    //绘制渐变色
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 0.1f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    animation.fromValue = @(self.currentProgress);
    animation.fromValue = @(0);
    animation.toValue = @(progress);
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.progressLayer addAnimation:animation forKey:@"strokeEndAnimation"];
    
    [self performSelector:@selector(performAction) withObject:nil afterDelay:2];

}

//延迟执行
- (void)performAction{
      
    //绘制渐变色
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 2.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = @(self.currentProgress);
    animation.toValue = @(0.4);
    animation.repeatCount = 1.0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.progressLayer addAnimation:animation forKey:@"strokeEndAnimation"];
        
    if (timer == nil) {
        CGFloat spaceTime =  (CGFloat)(2.0f/200) ;
        timer = [NSTimer timerWithTimeInterval:spaceTime target:self selector:@selector(timerAction) userInfo:nil repeats:YES];

        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        [timer fire];
    }

}


- (void)timerAction{
  
    if (_Step < self.currentStep) {
         
        _Step = _Step + 1;
        centerLabel.text = [NSString stringWithFormat:@"%ld",(long)_Step] ;
    
    }else{
        centerLabel.text = [NSString stringWithFormat:@"%ld",(long)_currentStep] ;
        [timer invalidate];
    }
   
}
-(void)clickFireBtn{
    if ([self.delegate respondsToSelector:@selector(clickFireBtn)]) {
        [self.delegate clickFireBtn];
    }
}
- (void)dealloc{
     timer = nil;
}
@end
