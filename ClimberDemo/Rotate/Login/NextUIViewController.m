 
#import "NextUIViewController.h"
#import "RotateAnimationView.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface NextUIViewController ()
@property (nonatomic, strong) RotateAnimationView *rotateAnimation;
@property (weak, nonatomic) IBOutlet UIImageView *bgview;

@property (nonatomic, assign) CGFloat currentProgress;
@end

@implementation NextUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      
     
    //创建圆环视图
    RotateAnimationView *rotateAnimation = [[RotateAnimationView alloc] initWithFrame:CGRectMake(60, SCREEN_HEIGHT/2-SCREEN_WIDTH/2+ 60, SCREEN_WIDTH- 120, SCREEN_WIDTH-120) pathWidth:20.f markWidth:20.f animationTime:1.f strokeColor:[UIColor whiteColor]];
    self.rotateAnimation = rotateAnimation;
    [self.view addSubview:rotateAnimation];
 
    //4000 为设置的总步数 1400.0f 为设置的当前的步数  内部设置了初始步数 1200 clockwise Yes 表示顺时针，No 表示逆时针
    [self.rotateAnimation setTotalStep:4000.0f  withCurrentStep:1400.0f clockwise:YES];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
       
    //毛玻璃视图
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];;
    effectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.bgview addSubview:effectView];

}

@end
