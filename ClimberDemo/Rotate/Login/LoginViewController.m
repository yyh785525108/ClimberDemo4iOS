
#import "LoginViewController.h"
#import "NextUIViewController.h"
#import "MBProgressHUD.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//test userName passWord
#define userName @"abc"
#define password @"123456"


@interface LoginViewController ()<UITextFieldDelegate>{
    NSString *userString;
    NSString *userString1;
   
}
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.backgroundColor = [UIColor blackColor].CGColor;

    // 键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
     
    // 键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
    
    //给背景图添加一个点击事件，控制视图键盘弹出后输入框和背景图的位置
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.bgImg addGestureRecognizer:tap];
    
    
    //修改默认提示
    [self modifyFieldPlaceholder];
    

}

- (void)modifyFieldPlaceholder{
    
    NSString *userNameStr = @"userName";
    NSMutableAttributedString *placeholder0 = [[NSMutableAttributedString alloc] initWithString:userNameStr];
    [placeholder0 addAttribute:NSForegroundColorAttributeName
                            value:[UIColor grayColor]
                            range:NSMakeRange(0, userNameStr.length)];
    _userNameField.attributedPlaceholder = placeholder0;
    
    NSString *passWord = @"passWord";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:passWord];
    [placeholder addAttribute:NSForegroundColorAttributeName
                           value:[UIColor grayColor]
                           range:NSMakeRange(0, passWord.length)];
   _passwordField.attributedPlaceholder = placeholder;
  
    _userNameField.tintColor = [UIColor whiteColor];

    _passwordField.tintColor = [UIColor whiteColor];
}

- (void)tapAction{
    [_passwordField resignFirstResponder];
      
    [_userNameField resignFirstResponder];
}

- (IBAction)LoginAction:(UIButton *)sender {
    
    if ([userString isEqualToString:userName]&&[userString1 isEqualToString:password]) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        NextUIViewController *NextVC = [NextUIViewController new];
        NextVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self presentViewController:NextVC animated:YES completion:nil];

    } else {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"密码或账号错误！";
        [hud hide:YES afterDelay:2];
    }
  

    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [_passwordField resignFirstResponder];
    [_userNameField resignFirstResponder];
    return YES;
}

//监听用户名称输入框和密码输入框的输入，便于控制点击按钮是否可点击，只有两者都不为空时可触发点击事件
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *str = textField.text;
   
    if (textField.tag == 101 ) {
 
        userString = (string.length == 0)?[textField.text substringToIndex:str.length-1]: [NSString stringWithFormat:@"%@%@",textField.text,string];
   
         if (userString.length != 0) {
                 
            _usernametitle.hidden = NO;

        } else {
                  
            _usernametitle.hidden = YES;

        }
    }
    if (textField.tag == 102 ) {
        
        userString1 = (string.length == 0)?[textField.text substringToIndex:str.length-1]: [NSString stringWithFormat:@"%@%@",textField.text,string];
          if (userString1.length != 0) {
                   
              _passwortitle.hidden = NO;

          } else {
                    
              _passwortitle.hidden = YES;

          }
      }
    
    if ((userString.length == 0 ) ||( userString1.length == 0)) {
        _LoginBtn.userInteractionEnabled = NO;
        [_LoginBtn setBackgroundColor:[UIColor colorWithRed:158/255.0  green:188/255.0  blue:234/255.0 alpha:1.0f]];
     }else{
         _LoginBtn.userInteractionEnabled = YES;
         [_LoginBtn setBackgroundColor:[UIColor colorWithRed:93/255.0  green:157/255.0  blue:255/255.0 alpha:1.0f]];

     }
    
    return YES;
}

#pragma mark -键盘监听方法
- (void)keyboardWasShown:(NSNotification *)notification
{
     CGRect Keyframe = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
     
    if (self.view.frame.origin.y==0) {
         [UIView animateWithDuration:0.4f animations:^{
                  self.view.transform = CGAffineTransformTranslate(self.view.transform, 0, -Keyframe.size.height);
            
         }];
    }
   
    
}
- (void)keyboardWillBeHiden:(NSNotification *)notification{
 
    [UIView animateWithDuration:0.4f animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


@end
