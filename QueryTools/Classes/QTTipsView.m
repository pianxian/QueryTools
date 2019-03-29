//
//  TipsView.m
//  showView
//
//  Created by hww on 2019/3/27.
//  Copyright © 2019 www.hww.wljy. All rights reserved.
//

#import "QTTipsView.h"
#import "QTAlertView.h"

@implementation UILabel (space)

- (void)setlabelSpace{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:10];//调整行间距
//    [paragraphStyle setFirstLineHeadIndent:10.0];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
    //    [self sizeToFit];
    
}

@end


@interface QTTipsView ()
@property (nonatomic,strong) UILabel *top;
@property (nonatomic,strong) UIView *lineOne;
@property (nonatomic,strong) UILabel *mid;
@property (nonatomic,strong) UIView *lineTwo;
@property (nonatomic,strong) UIButton *timoutButton;
@property (nonatomic,strong) dispatch_source_t timer;
@end


static QTTipsView *tips = nil;
@implementation QTTipsView


+(QTTipsView *)sharTipsView{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tips = [[self alloc] init];
        tips.frame = CGRectMake(0, 0, 300, 250);
    });
   
    return tips;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.clipsToBounds = YES;
        _top = [[UILabel alloc] init];
        _top.textColor = [UIColor colorWithRed:87/255 green:87/255 blue:87/255 alpha:1.0];
        _top.font = [UIFont systemFontOfSize:17];
        _top.text = @"风险提示";
        _top.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_top];
        
        _lineOne = [[UIView alloc] init];
        _lineOne.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
        [self addSubview:_lineOne];
        
        _mid = [[UILabel alloc] init];
        _mid.textColor = [UIColor colorWithRed:249/255.f green:59/255.f blue:79/255.f alpha:1.0];
        _mid.font = [UIFont systemFontOfSize:15];
        _mid.numberOfLines = 0;
        _mid.text = @"网络借贷为自愿\n出借资金需谨慎\n风险意识记心上\n本息损失皆自担";
        _mid.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_mid];
        
        _lineTwo = [[UIView alloc] init];
        _lineTwo.backgroundColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:245/255.f alpha:1.0];
        [self addSubview:_lineTwo];
    
        _timoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_timoutButton setTitle:@"5秒后确认" forState:UIControlStateDisabled];
        _timoutButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_timoutButton setTitleColor:[UIColor colorWithRed:197/255.f green:197/255.f blue:197/255.f alpha:1.0] forState:UIControlStateDisabled];
        [_timoutButton setTitleColor:[UIColor colorWithRed:87/255 green:87/255 blue:87/255 alpha:1.0] forState:UIControlStateNormal];
        _timoutButton.enabled = NO;
        [_timoutButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_timoutButton];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
     _timoutButton.enabled = NO;
    _top.frame = CGRectMake(0, 0, self.frame.size.width, 45);
    _lineOne.frame = CGRectMake(0, CGRectGetMaxY(_top.frame), self.frame.size.width, 1);
    _mid.frame = CGRectMake(0, CGRectGetMaxY(_lineOne.frame), self.frame.size.width, self.frame.size.height - 92);
    [_mid setlabelSpace];
    [_mid setTextAlignment:NSTextAlignmentCenter];
    _lineTwo.frame = CGRectMake(0, CGRectGetMaxY(_mid.frame), self.frame.size.width, 1);
    _timoutButton.frame =  CGRectMake(0, CGRectGetMaxY(_lineTwo.frame), self.frame.size.width, 45);
    
}
-(void)dismiss{
    [[QTAlertView sharedMask] dismiss];
    dispatch_cancel(_timer);
}
-(void)timeOut{
    __block NSInteger timeout = 5;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);//每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout <= 0) {//待机时结束,关闭
            dispatch_source_cancel(self.timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.timoutButton.enabled = YES;
                [self.timoutButton setTitle:@"确认" forState:UIControlStateNormal];
            });
        }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.timoutButton setTitle:[NSString stringWithFormat:@"%ld秒后确认",timeout] forState:UIControlStateDisabled];
                });
        
                
          
            timeout --;
        }
    });
    dispatch_resume(_timer);
}
@end
