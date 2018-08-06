//
//  FLJSearchBar.m
//  FLJSearchBar
//
//  Created by 贾林飞 on 2018/8/3.
//  Copyright © 2018年 贾林飞. All rights reserved.
//

#import "FLJSearchBar.h"
#import "UIImage+Extension.h"

#define kDefaultBorderColor [UIColor colorWithRed:(225)/255.0 green:(226)/255.0 blue:(227)/255.0 alpha:1.0]

#define kDefaultPlaceHolderTextFont [UIFont systemFontOfSize:16]

#define kDefaultPlaceHolerTextColor [UIColor colorWithRed:(187)/255.0 green:(187)/255.0 blue:(187)/255.0 alpha:1.0]

#define kDefaultCancelBtnTitleFont [UIFont systemFontOfSize:16]

#define kDefaultCancelBtnTitleColor [UIColor colorWithRed:(102)/255.0 green:(102)/255.0 blue:(102)/255.0 alpha:1.0]

@interface FLJSearchBar ()<UITextFieldDelegate>

@property(nonatomic,assign)BOOL hideClearBtn;

@end

@implementation FLJSearchBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        //cancel按钮显示
        self.showsCancelButton = YES;
        //光标颜色tintColor
//        self.tintColor = [UIColor clearColor];
        self.backgroundImage = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(100, self.bounds.size.height)];
//        [self setImage:[UIImage imageNamed:@"icon_search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
//        [self setImage:[UIImage imageNamed:@"icon_search_clear"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
        //ios11 之前这个高度决定textfield高度 默认28
        [self setSearchFieldBackgroundImage:[UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(100, self.bounds.size.height)] forState:UIControlStateNormal];
        
        self.originPositionSearchOffSet = UIOffsetMake(10, 0);
        //搜索图标偏移
        [self setPositionAdjustment:self.originPositionSearchOffSet forSearchBarIcon:UISearchBarIconSearch];
        //清除按钮偏移向左偏移10
        [self setPositionAdjustment:UIOffsetMake(-10, 0) forSearchBarIcon:UISearchBarIconClear];
        //整个输入框（textfield）的偏移量
//        [self setSearchFieldBackgroundPositionAdjustment:UIOffsetMake(10, 0)];
        //文字距离搜索图标的偏移，默认是紧挨着的
        [self setSearchTextPositionAdjustment:UIOffsetMake(10, 0)];
        
        self.placeHolderString = @"请输入搜索内容";
        self.cornerRadius = self.bounds.size.height/2.f;
        self.borderWidth = 1.f;
        self.borderColor = kDefaultBorderColor;
        self.placeHolderCenter = NO;
        [self setCancelBtnTitle:@"取消"];
    }
    return self;
}

#pragma mark  setter & getter

/**
 设置placeHolder

 @param placeHolderString placeHolder
 */
-(void)setPlaceHolderString:(NSString *)placeHolderString
{
    _placeHolderString = [placeHolderString copy];
    UITextField *textField = [self textField];
    if (textField) {
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_placeHolderString attributes:@{NSForegroundColorAttributeName:_placeHolderStringColor?_placeHolderStringColor:kDefaultPlaceHolerTextColor,NSFontAttributeName:_placeHolderStringFont?_placeHolderStringFont:kDefaultPlaceHolderTextFont}];
    }
}

/**
 设置placeHolder字号

 @param placeHolderStringFont 字号
 */
-(void)setPlaceHolderStringFont:(UIFont *)placeHolderStringFont
{
    _placeHolderStringFont = placeHolderStringFont;
    UITextField *textField = [self textField];
    if (textField) {
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_placeHolderString attributes:@{NSForegroundColorAttributeName:_placeHolderStringColor?_placeHolderStringColor:kDefaultPlaceHolerTextColor,NSFontAttributeName:_placeHolderStringFont}];
        textField.font = _placeHolderStringFont;
    }
}

/**
 设置placehHolder字体颜色

 @param placeHolderStringColor placehHolder字体颜色
 */
-(void)setPlaceHolderStringColor:(UIColor *)placeHolderStringColor
{
    _placeHolderStringColor = placeHolderStringColor;
    
    UITextField *textField = [self textField];
    if (textField) {
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_placeHolderString attributes:@{NSForegroundColorAttributeName:_placeHolderStringColor,NSFontAttributeName:_placeHolderStringFont?_placeHolderStringFont:kDefaultPlaceHolderTextFont}];
    }
}

/**
 设置取消按钮文字
 */
-(void)setCancelBtnTitle:(NSString *)cancelBtnTitle
{
    _cancelBtnTitle = [cancelBtnTitle copy];
    UIButton *cancel = [self cancelBtn];
    if (cancel) {
        [cancel setTitle:cancelBtnTitle forState:UIControlStateNormal];
        
        if (!self.cancelBtnTitleColor) {
            [cancel setTitleColor:kDefaultCancelBtnTitleColor forState:UIControlStateNormal];
        }
        cancel.titleLabel.font = kDefaultCancelBtnTitleFont;
    }
}

/**
 设置取消按钮文字颜色
 */
-(void)setCancelBtnTitleColor:(UIColor *)cancelBtnTitleColor
{
    _cancelBtnTitleColor = cancelBtnTitleColor;
    UIButton *cancel = [self cancelBtn];
    if (cancel) {
        [cancel setTitleColor:_cancelBtnTitleColor forState:UIControlStateNormal];
    }
}

/**
 隐藏清除按钮

 @param clearBtnHidden yes隐藏 no输入的时候显示
 */
-(void)setClearBtnHidden:(BOOL)clearBtnHidden
{
    _clearBtnHidden = clearBtnHidden;
    self.hideClearBtn = _clearBtnHidden;
}

-(void)setHideClearBtn:(BOOL)hideClearBtn
{
    _hideClearBtn = hideClearBtn;
    UITextField *textField = [self textField];
    if (textField) {
        if (_hideClearBtn) {
            textField.clearButtonMode = UITextFieldViewModeNever;
        }else
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
}

/**
 设置搜索框圆角
 */
-(void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    UITextField *textField = [self textField];
    if (textField) {
        textField.layer.cornerRadius = _cornerRadius;
        textField.layer.masksToBounds =YES;
        textField.clipsToBounds = YES;
    }
}

/**
 设置搜索框边框颜色
 */
-(void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    UITextField *textField = [self textField];
    if (textField) {
        textField.layer.borderColor = borderColor.CGColor;
    }
}

/**
 设置搜索框边框 宽度
 */
-(void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    UITextField *textField = [self textField];
    if (textField) {
        textField.layer.borderWidth = borderWidth;
        textField.layer.masksToBounds =YES;
    }
}

/**
 设置placeholder是否居中显示
 */
- (void)setPlaceHolderCenter:(BOOL)placeHolderCenter
{
    _placeHolderCenter = placeHolderCenter;
    
    if (@available(iOS 11.0, *)) {
        UITextField* textField = [self textField];
        textField.delegate = self;
        if (_placeHolderCenter) {
            [self setPositionAdjustment:UIOffsetMake((textField.frame.size.width-[self placeHolderTextWidth])/2, 0) forSearchBarIcon:UISearchBarIconSearch];
        }else
            [self setPositionAdjustment:self.originPositionSearchOffSet forSearchBarIcon:UISearchBarIconSearch];

    }else
    {
        SEL centerSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@", @"setCenter", @"Placeholder:"]);
        if ([self respondsToSelector:centerSelector])
        {
            NSMethodSignature *signature = [[UISearchBar class] instanceMethodSignatureForSelector:centerSelector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:self];
            [invocation setSelector:centerSelector];
            [invocation setArgument:&_placeHolderCenter atIndex:2];
            [invocation invoke];
        }
    }
}

/**
 设置当输入框没有获得焦点时，点击取消按钮是否直接响应取消事件，而不是响应输入事件
 */
-(void)setCancelInputDisabled:(BOOL)cancelInputDisabled
{
    _cancelInputDisabled = cancelInputDisabled;
    UIButton *cancelBtn = [self cancelBtn];
    cancelBtn.enabled = YES;
}

#pragma mark UITextFieldDelegate

#warning 实现这两个代理方法后 searchbar的textFieldShouldBeginEditing 和textFieldShouldEndEditing将不执行 需要代理调起方法
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]) {
       BOOL begin = [self.delegate searchBarShouldBeginEditing:self];
        if (begin) {
            if (@available(iOS 11.0, *) && self.placeHolderCenter) {
                [self setPositionAdjustment:self.originPositionSearchOffSet forSearchBarIcon:UISearchBarIconSearch];
            }
            if (!self.clearBtnHidden) {
                self.hideClearBtn = NO;
            }
        }
        return begin;
    }
    
    if (@available(iOS 11.0, *) && self.placeHolderCenter) {
        [self setPositionAdjustment:self.originPositionSearchOffSet forSearchBarIcon:UISearchBarIconSearch];
    }
    if (!self.clearBtnHidden) {
        self.hideClearBtn = NO;
    }

    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]){
        BOOL end = [self.delegate searchBarShouldEndEditing:self];
        
        if (end) {
            if (@available(iOS 11.0, *) && self.placeHolderCenter) {
                if (textField.text.length==0) {
                    [self setPositionAdjustment:UIOffsetMake((textField.frame.size.width-[self placeHolderTextWidth])/2, 0) forSearchBarIcon:UISearchBarIconSearch];
                }
            }
            if (self.clearBtnHidden) {
                self.hideClearBtn = YES;
            }
        }
        return end;
    }
    
    if (@available(iOS 11.0, *) && self.placeHolderCenter) {
        if (textField.text.length==0) {
            [self setPositionAdjustment:UIOffsetMake((textField.frame.size.width-[self placeHolderTextWidth])/2, 0) forSearchBarIcon:UISearchBarIconSearch];
        }
    }
    if (self.clearBtnHidden) {
        self.hideClearBtn = YES;
    }

    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.cancelInputDisabled) {
        self.cancelInputDisabled = YES;
    }
}

/**
 获得搜索框
 */
-(UITextField*)textField
{
    UITextField *searchField = [self valueForKey:@"searchField"];
    
    //    for (UIView *view in self.subviews.lastObject.subviews) {
    //        if([view isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
    //            return (UITextField*)view;
    //        }
    //    }
    return searchField;
}

/**
 获得取消按钮
 */
-(UIButton*)cancelBtn
{
    UIView* view = [self valueForKeyPath:@"cancelButton"];
    //    if ([view isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
    UIButton *cancelBtn = (UIButton *)view;
    //    }
    return cancelBtn;
}

/**
 计算placeHolder的宽度
 */
-(CGFloat)placeHolderTextWidth
{
    UITextField* textField = [self textField];

    return [self.placeHolderString boundingRectWithSize:textField.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSForegroundColorAttributeName:_placeHolderStringColor?_placeHolderStringColor:kDefaultPlaceHolerTextColor,NSFontAttributeName:_placeHolderStringFont?_placeHolderStringFont:kDefaultPlaceHolderTextFont} context:nil].size.width;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if (@available(iOS 11.0, *) && self.placeHolderCenter) {
        UITextField* textField = [self textField];
        [self setPositionAdjustment:UIOffsetMake((textField.frame.size.width-[self placeHolderTextWidth])/2, 0) forSearchBarIcon:UISearchBarIconSearch];
    }
}

@end
