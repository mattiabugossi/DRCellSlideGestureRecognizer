//
//  DRCellSlideActionView.m
//  DRCellSlideGestureRecognizer
//
//  Created by David Román Aguirre on 17/5/15.
//
//

#import "DRCellSlideActionView.h"

#import "DRCellSlideAction.h"

@interface DRCellSlideActionView ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation DRCellSlideActionView

- (instancetype)init {
	if (self = [super init]) {
		self.iconImageView = [UIImageView new];
		[self addSubview:self.iconImageView];
        
        self.titleLabel = [UILabel new];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont fontWithName:@"PingFangHK-Regular" size:13];
        [self addSubview:self.titleLabel];
	}
	
	return self;
}

- (void)updateIconImageViewFrame {
	self.iconImageView.frame = CGRectMake(0, 0, 30, 30);
    self.iconImageView.center = CGPointMake(_action.fraction > 0 ? 35 : self.frame.size.width - 35, self.iconImageView.frame.size.height + 10);
    self.iconImageView.clipsToBounds = true;
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.titleLabel sizeToFit];
    
    if (_action.fraction > 0) {
        self.titleLabel.frame = CGRectMake(60, self.iconImageView.center.y - self.titleLabel.frame.size.height / 2, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
    } else {
        self.titleLabel.frame = CGRectMake(self.frame.size.width - 60 - self.titleLabel.frame.size.width, self.iconImageView.center.y - self.titleLabel.frame.size.height / 2, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
    }
}

- (void)cellDidUpdatePosition:(UITableViewCell *)cell {
	// NSLog(@"%@", self.superview);
	[self updateIconImageViewFrame];
	self.iconImageView.alpha = fabs(cell.frame.origin.x)/(self.iconImageView.image.size.width+self.action.iconMargin*2);
}

- (void)tint {
    [UIView animateWithDuration:0.3 animations:^{
        self.iconImageView.tintColor = self.active ? self.action.activeColor : self.action.inactiveColor;
        self.backgroundColor = self.active ? self.action.activeBackgroundColor : self.action.inactiveBackgroundColor;
    }];
}

- (void)setAction:(DRCellSlideAction *)action {
	_action = action;
	
    self.titleLabel.text = action.title;
    
	self.iconImageView.image = [action.icon imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	self.iconImageView.contentMode = action.fraction >= 0 ? UIViewContentModeLeft : UIViewContentModeRight;
	
	[self tint];
	[self updateIconImageViewFrame];
}

- (void)setActive:(BOOL)active {
	if (_active != active) {
		_active = active;
		
		[self tint];
	}
}

@end
