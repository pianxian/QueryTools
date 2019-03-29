//
//  TipsView.h
//  showView
//
//  Created by hww on 2019/3/27.
//  Copyright © 2019 www.hww.wljy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UILabel (space)
- (void)setlabelSpace;
@end

@interface QTTipsView : UIView
+(QTTipsView *)sharTipsView;
-(void)timeOut;
@end

NS_ASSUME_NONNULL_END
