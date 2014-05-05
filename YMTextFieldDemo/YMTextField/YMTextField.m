//
//  YMTextField.m
//  YMTextFieldDemo
//
//  Created by Merck on 4/28/14.
//  Copyright (c) 2014 Merck. All rights reserved.
//

#import "YMTextField.h"

#define kBorderOriginY 8.f

typedef NS_ENUM(NSUInteger, YMTextFieldStatus)
{
    YMTextFieldNormal,
    YMTextFieldHighlighted,
    YMTextFieldContentNormal,
    YMTextFieldContentHighlighted
};

@interface YMTextField () <UITextFieldDelegate>

@property (nonatomic, assign) CGFloat titleLabelHeight;
@property (nonatomic, assign) CGFloat titleLabelOriginY;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *contentTextField;
@property (nonatomic, assign) YMTextFieldStatus currentStatus;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;

@end

@implementation YMTextField

- (id)initWithFrame:(CGRect)frame title:(NSString *)aTitle
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.contentTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 4, frame.size.width - 10, frame.size.height)];
        _contentTextField.delegate = self;
        [self addSubview:_contentTextField];
        
        self.titleLabelHeight = ceilf(frame.size.height * .3f);
        self.titleLabelOriginY = kBorderOriginY / 2 + ceilf((frame.size.height - _titleLabelHeight) / 2);
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, _titleLabelOriginY, frame.size.width - 10, _titleLabelHeight)];
        _titleLabel.text = aTitle;
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLabel];
        
        self.title = aTitle;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, 1.0);
    
    if (_currentStatus == YMTextFieldHighlighted || _currentStatus == YMTextFieldContentHighlighted)
    {
        CGContextSetRGBStrokeColor(context, 51/255.0, 51/255.0, 1.0, 1.0);
    }
    else
    {
        CGContextSetRGBStrokeColor(context, 128/255.0, 128/255.0, 128/255.0, 1.0);
    }
    
    CGContextBeginPath(context);
    if (_currentStatus == YMTextFieldHighlighted || _currentStatus == YMTextFieldContentHighlighted || _currentStatus == YMTextFieldContentNormal)
    {
        CGContextMoveToPoint(context, 2, kBorderOriginY);
        CGContextAddLineToPoint(context, 8, kBorderOriginY);
        CGContextMoveToPoint(context, [self titleWidth] + 12, kBorderOriginY);
        CGContextAddLineToPoint(context, rect.size.width - 2, kBorderOriginY);
        CGContextAddLineToPoint(context, rect.size.width - 2, rect.size.height - 2);
        CGContextAddLineToPoint(context, 2, rect.size.height - 2);
        CGContextAddLineToPoint(context, 2, kBorderOriginY);
    }
    else
    {
        CGContextAddRect(context, CGRectMake(2, kBorderOriginY, rect.size.width - 4, rect.size.height - 10));
    }
    
    CGContextStrokePath(context);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField.text length] > 0)
    {
        self.currentStatus = YMTextFieldContentHighlighted;
    }
    else
    {
        self.currentStatus = YMTextFieldHighlighted;
    }
    
    [UIView animateWithDuration:.3f
                     animations:^{
                         
                         CGRect theFame = _titleLabel.frame;
                         theFame.origin.x = 10;
                         theFame.origin.y = 0;
                         _titleLabel.frame = theFame;
                         
                     } completion:^(BOOL finished) {
                         
                         _titleLabel.textColor = [UIColor blueColor];
                         [self setNeedsDisplay];
                         
                     }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text length] > 0)
    {
        self.currentStatus = YMTextFieldContentNormal;
    }
    else
    {
        self.currentStatus = YMTextFieldNormal;
    }
    
    [UIView animateWithDuration:.3f
                     animations:^{
                         
                         if ([textField.text length] <= 0)
                         {
                             CGRect theFrame = _titleLabel.frame;
                             theFrame.origin.x = 4.f;
                             theFrame.origin.y = _titleLabelOriginY;
                             _titleLabel.frame = theFrame;
                         }
                         
                     } completion:^(BOOL finished) {
                         
                         _titleLabel.textColor = [UIColor darkGrayColor];
                         [self setNeedsDisplay];
                         
                     }];
}

- (CGFloat)titleWidth
{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16.f], NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:_title attributes:attributes] size].width;
}

@end
