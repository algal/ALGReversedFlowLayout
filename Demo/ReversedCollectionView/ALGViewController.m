//
//  ALGViewController.m
//  ReversedCollectionView
//
//  Created by Alexis Gallagher on 2014-05-20.
//  Copyright (c) 2014 Bloom FIlter. All rights reserved.
//

#import "ALGViewController.h"

#import "ALGReversedFlowLayout.h"

static CGFloat const kSmallHeight = 150.f;
static CGFloat const kMediumHeight = 250.f;
static CGFloat const kBigHeight = 350.f;


@interface ALGViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UISwitch *expandsContentSizeSwitch;
@property (strong,nonatomic) NSMutableArray * items;
@end

@implementation ALGViewController
- (instancetype)initWithCoder:(NSCoder *)coder
{
  self = [super initWithCoder:coder];
  if (self) {
    self->_items = [NSMutableArray array];
    for (NSUInteger i=0; i < 6; ++i) {
      NSString * string = [NSString stringWithFormat:@"%@",@(i)];
      [self->_items addObject:string];
    }
  }
  return self;
}

#pragma mark action methods

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  [self setUsesNormalFlowLayout:NO];
  [self setCollectionViewBoundsBigHeight:YES];
}

- (IBAction) toggleUsesNormalFlowLayout:(UISwitch *)sender {
  [self setUsesNormalFlowLayout:sender.on];
}

- (IBAction) toggleExpandsContentSize:(UISwitch *)sender {
  [self setExpandsContentSize:sender.on];
}

- (IBAction) toggleEnforcesMinimumHeight:(UISwitch *)sender {
  [self setCollectionViewContentSizeMinimumHeight:sender.on];
}

- (IBAction) toggleCVSize:(UISwitch *)sender {
  [self setCollectionViewBoundsBigHeight:sender.on];
}

#pragma mark helpers

/// Returns fresh flow layout, either normal or reversed
- (UICollectionViewFlowLayout *) flowLayoutNormal:(BOOL)normal
{
  UICollectionViewFlowLayout * layout = normal ? [[UICollectionViewFlowLayout alloc] init] : [[ALGReversedFlowLayout alloc] init];
  
  layout.headerReferenceSize = CGSizeMake(50, 50);
  layout.footerReferenceSize = CGSizeMake(25, 25);

  return layout;
}

- (void) setUsesNormalFlowLayout:(BOOL)enabled
{
  UICollectionViewLayout * newLayout = [self flowLayoutNormal:enabled];
  [self.collectionView setCollectionViewLayout:newLayout animated:YES];
  [newLayout invalidateLayout];
  
  [self normalizeExpandsContentSizeSwitch];
}

- (void) setExpandsContentSize:(BOOL)expandsContentSize
{
  UICollectionViewLayout  * layout = self.collectionView.collectionViewLayout;
  
  if ([layout isKindOfClass:[ALGReversedFlowLayout class]]) {
    ALGReversedFlowLayout * reversedLayout = ( ALGReversedFlowLayout *) layout;
    reversedLayout.expandContentSizeToBounds = expandsContentSize;
    [reversedLayout invalidateLayout];
  }
  
  [self normalizeExpandsContentSizeSwitch];
}

- (void) setCollectionViewBoundsBigHeight:(BOOL)useBigHeight
{
  CGFloat bigHeight = kBigHeight;
  CGFloat smallheight = kSmallHeight;
  
  self.collectionView.frame = CGRectMake(self.collectionView.frame.origin.x,
                                         self.collectionView.frame.origin.y,
                                         self.collectionView.frame.size.width,
                                         useBigHeight ? bigHeight : smallheight);
  [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void) setCollectionViewContentSizeMinimumHeight:(BOOL)useMediumHeight
{
  CGFloat const mediumHeight = kMediumHeight;

  UICollectionViewFlowLayout * layout = (ALGReversedFlowLayout *) self.collectionView.collectionViewLayout;

  if ([layout isKindOfClass:[ALGReversedFlowLayout class]]) {
    ALGReversedFlowLayout * reversedLayout = (ALGReversedFlowLayout *) layout;
    if (useMediumHeight)
    {
      NSNumber * const myNumber = [NSNumber numberWithFloat:mediumHeight];
      reversedLayout.minimumContentSizeHeight = myNumber;
    }
    else
    {
      reversedLayout.minimumContentSizeHeight = nil;
    }
    [reversedLayout invalidateLayout];
  }
}

- (void) normalizeExpandsContentSizeSwitch
{
  UICollectionViewLayout * layout = self.collectionView.collectionViewLayout;
  if ([layout isKindOfClass:[ALGReversedFlowLayout class]]) {
    ALGReversedFlowLayout * reversedLayout = (ALGReversedFlowLayout *) layout;
    self.expandsContentSizeSwitch.on = reversedLayout.expandContentSizeToBounds;
    [self setCollectionViewContentSizeMinimumHeight:(reversedLayout.minimumContentSizeHeight ? YES : NO)];
  }
}

#pragma mark UICollectionViewDelegate


#pragma mark UICollectionViewDataSource 

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return section == 0 ? [self.items count] : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId"
                                                                          forIndexPath:indexPath];
  UILabel * label = (UILabel *) [cell viewWithTag:100];
  label.text = self.items[indexPath.row];

  return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
  NSString * identifier;
  if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
    identifier = @"header";
  }
  else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
    identifier = @"footer";
  }
  else {
    NSLog(@"unknown element kind %@", kind);
    return nil;
  }

  UICollectionReusableView * supplementaryView = (UICollectionReusableView *) [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                                                 withReuseIdentifier:identifier
                                                                                                                        forIndexPath:indexPath];
  return supplementaryView;
}



@end
