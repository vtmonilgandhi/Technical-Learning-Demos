//
//  ViewController.m
//  Dropit
//
//  Created by Monil Gandhi on 06/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import "ViewController.h"
#import "DropitBehaviour.h"
#import "BezierPathView.h"

@interface ViewController () <UIDynamicAnimatorDelegate>
@property (weak, nonatomic) IBOutlet BezierPathView *gameView;
@property (strong,nonatomic) UIDynamicAnimator *animator;
@property (strong,nonatomic) DropitBehaviour *dropitBehaviour;
@property (strong,nonatomic) UIAttachmentBehavior *attachment;
@property (strong,nonatomic) UIView *droppingView;
@end

@implementation ViewController

static const CGSize DROP_SIZE = {83,83};

- (UIDynamicAnimator *)animator {
  if(!_animator){
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gameView];
  }
  return _animator;
}

- (DropitBehaviour *)dropitBehaviour {
  if(!_dropitBehaviour){
    _dropitBehaviour = [[DropitBehaviour alloc] init];
    [self.animator addBehavior:_dropitBehaviour];
  }
  return _dropitBehaviour;
}

- (void) dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
  [self removeCompletedRows];
}

- (BOOL) removeCompletedRows {
  NSMutableArray *dropsToRemove = [[NSMutableArray alloc] init];
  for(CGFloat y = self.gameView.bounds.size.height - DROP_SIZE.height / 2; y > 0; y -= DROP_SIZE.height) {
    BOOL rowsIsComplete = YES;
    NSMutableArray *dropsFound = [[NSMutableArray alloc] init];
    for(CGFloat x = DROP_SIZE.width / 2; x <= self.gameView.bounds.size.width - DROP_SIZE.width / 2; y += DROP_SIZE.width) {
      UIView *hitView = [self.gameView hitTest:CGPointMake(x,y) withEvent:NULL];
      if([hitView superview] == self.gameView){
        [dropsFound addObject:hitView];
      }else{
        rowsIsComplete = NO;
        break;
      }
    }
    if(![dropsFound count]) break;
    if(rowsIsComplete) [dropsToRemove addObjectsFromArray:dropsFound];
  }
  if([dropsToRemove count]){
    for(UIView *drop in dropsToRemove){
      [self.dropitBehaviour removeItem:drop];
    }
    [self animateRemovingDrops:dropsToRemove];
  }
  return NO;
}

- (void)animateRemovingDrops:(NSArray *)dropsToRemove {
  [UIView animateWithDuration:1.0
                   animations:^{
                     for(UIView *drop in dropsToRemove){
                       int x = arc4random()%(int)(self.gameView.bounds.size.width * 5) - (int)(self.gameView.bounds.size.width * 2);
                       int y = self.gameView.bounds.size.height;
                       drop.center = CGPointMake(x, -y);
                     }
                   }
                   completion:^(BOOL finished) {
                     [dropsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
                   }];
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
  [self drop];
}

- (IBAction)pan:(UIPanGestureRecognizer *)sender {
  CGPoint gesturePoint = [sender locationInView:self.gameView];
  if(sender.state == UIGestureRecognizerStateBegan){
    [self attachDroppingViewToPoint:gesturePoint];
  }else if(sender.state == UIGestureRecognizerStateChanged){
    self.attachment.anchorPoint = gesturePoint;
  }else if(sender.state == UIGestureRecognizerStateEnded){
    [self.animator removeBehavior:self.attachment];
    self.gameView.path = nil;
  }
}

- (void) attachDroppingViewToPoint:(CGPoint)anchorPoint {
  if(self.droppingView){
    self.attachment = [[UIAttachmentBehavior alloc] initWithItem:self.droppingView  attachedToAnchor:anchorPoint];
    UIView *droppingView = self.droppingView;
    __weak ViewController *weakSelf = self;
    self.attachment.action = ^{
      UIBezierPath *path = [[UIBezierPath alloc] init];
      [path moveToPoint:weakSelf.attachment.anchorPoint];
      [path addLineToPoint:droppingView.center];
      weakSelf.gameView.path = path;
    };
    self.droppingView = nil;
    [self.animator addBehavior:self.attachment];
  }
}

- (void) drop {
  
  CGRect frame;
  frame.origin = CGPointZero;
  frame.size = DROP_SIZE;
  int x = (arc4random()%(int)self.gameView.bounds.size.width) / DROP_SIZE.width;
  frame.origin.x = x * DROP_SIZE.width;
  
  UIView *dropView = [[UIView alloc] initWithFrame:frame];
  dropView.backgroundColor = [self randomColor];
  [self.gameView addSubview:dropView];
  
  self.droppingView = dropView;
  [self.dropitBehaviour addItem:dropView];

}

- (UIColor *)randomColor {
  switch (arc4random()%5) {
    case 0: return [UIColor greenColor];
    case 1: return [UIColor blueColor];
    case 2: return [UIColor orangeColor];
    case 3: return [UIColor redColor];
    case 4: return [UIColor purpleColor];
  }
  return [UIColor blackColor];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}
@end
