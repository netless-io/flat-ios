//
//  WhiteProgressView.m
//  WhiteCombinePlayer
//
//  Created by yleaf on 2019/7/19.
//

#import "WhiteSliderView.h"

@interface WhiteSliderView ()
@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, strong) UIView *bufferProgressView;
@property (nonatomic, strong) UIButton *sliderBtn;
@end

@implementation WhiteSliderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateProgressView];
    [self updateBufferView];
}

- (void)updateProgressView
{
    CGRect bounds = self.bounds;
    
    bounds.size.width = self.bounds.size.width * self.value;
    bounds.size.height = 4;
    bounds.origin.y = CGRectGetMidY(self.bounds) - CGRectGetHeight(bounds) / 2;

    self.progressView.frame = bounds;
}

- (void)updateBufferView
{
    CGRect bounds = self.bounds;

    bounds.size.width = self.bounds.size.width * self.bufferValue;
    bounds.size.height = 4;
    bounds.origin.y = CGRectGetMidY(self.bounds) - CGRectGetHeight(bounds) / 2;

    self.bufferProgressView.frame = bounds;
}

- (void)updateSlider
{
    CGRect bounds = self.bounds;

    CGRect rect = CGRectMake(0, 0, 10, 10);
    rect.origin.x = fmaxf(bounds.size.width * self.value - CGRectGetMidX(rect), CGRectGetMidX(rect));
    rect.origin.y = CGRectGetMidY(self.bounds) - CGRectGetWidth(rect) / 2;
    self.sliderBtn.frame = rect;
}

- (void)setup
{
    self.progressView = [[UIView alloc] initWithFrame:self.bounds];
    self.progressView.backgroundColor = self.tintColor;
    [self addSubview:self.progressView];
    
    self.bufferProgressView = [[UIView alloc] initWithFrame:self.bounds];
    self.bufferProgressView.backgroundColor = [UIColor grayColor];
    [self addSubview:self.bufferProgressView];
    
    self.sliderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.sliderBtn];
    
    UIPanGestureRecognizer *sliderGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(sliderGesture:)];
    [self addGestureRecognizer:sliderGesture];
}

- (void)setBufferValue:(CGFloat)bufferValue
{
    _bufferValue = bufferValue;
    [self updateBufferView];
}

- (void)setValue:(CGFloat)value
{
    _value = value;
    [self updateProgressView];
    [self updateSlider];
}

- (void)sliderGesture:(UIGestureRecognizer *)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            [self sliderBtnTouchBegin:self.sliderBtn];
        }
            break;
        case UIGestureRecognizerStateChanged: {
            [self sliderBtnDragMoving:self.sliderBtn point:[gesture locationInView:self.progressView]];
        }
            break;
        case UIGestureRecognizerStateEnded: {
            [self sliderBtnTouchEnded:self.sliderBtn];
        }
            break;
        default:
            break;
    }
}

- (void)sliderBtnTouchBegin:(UIButton *)btn {

}

- (void)sliderBtnTouchEnded:(UIButton *)btn {

}

- (void)sliderBtnDragMoving:(UIButton *)btn point:(CGPoint)touchPoint {
}


#pragma mark -

@end
