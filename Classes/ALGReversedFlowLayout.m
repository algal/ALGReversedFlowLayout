//
//  ALGReversedFlowLayout.m
//  ReversedCollectionView
//
//  Created by Alexis Gallagher on 2014-05-21.
//  Copyright (c) 2014 Alexis Gallagher. All rights reserved.
//

#import "ALGReversedFlowLayout.h"



@implementation ALGReversedFlowLayout


#pragma mark overrides

- (instancetype) initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
      self->_expandContentSizeToBounds = YES;
    }
    return self;
}

- (instancetype) init
{
    self = [super init];
    if (self) {
      self->_expandContentSizeToBounds = YES;
    }
    return self;
}

- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
  if (self.expandContentSizeToBounds &&
      fabsf(self.collectionView.bounds.size.height - newBounds.size.height) > FLT_EPSILON ) {
    return YES;
  }
  else {
    return [super shouldInvalidateLayoutForBoundsChange:newBounds];
  }
}

- (CGSize) collectionViewContentSize
{
  if (self.expandContentSizeToBounds) {
    /* 
     We ensure the declared contentSize is at least as tall as the bounds.
     Otherwise, the collectionView --by virtue of being a scrollview-- places
     it at the top of the bounds.
     */
    CGSize const cvContentSize = [super collectionViewContentSize];
    CGSize const cvBounds = [[self collectionView] bounds].size;
    
    CGFloat const width = cvContentSize.width;
    CGFloat const height = MAX(cvContentSize.height, cvBounds.height);
    return CGSizeMake(width,height);
  }
  else {
    return [super collectionViewContentSize];
  }
}

- (UICollectionViewLayoutAttributes *) layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewLayoutAttributes * attribute = [super layoutAttributesForItemAtIndexPath:indexPath];
  [self modifyLayoutAttribute:attribute];
  return attribute;
}

- (NSArray *) layoutAttributesForElementsInRect:(CGRect)reversedRect
{
  CGRect const normalRect = [self normalRectForReversedRect:reversedRect];
  NSArray * attributes = [super layoutAttributesForElementsInRect:normalRect];
  for(UICollectionViewLayoutAttributes *attribute in attributes){
    [self modifyLayoutAttribute:attribute];
  }
  return attributes;
}

- (void) setScrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
  NSAssert(scrollDirection == UICollectionViewScrollDirectionVertical,
           @"horizontal scrolling is not supported");
  [super setScrollDirection:scrollDirection];
}

#pragma mark - helpers

- (void) modifyLayoutAttribute:(UICollectionViewLayoutAttributes*)attribute
{
  CGPoint const normalCenter = attribute.center;
  CGPoint const reversedCenter = [self reversedPointForNormalPoint:normalCenter];
  attribute.center = reversedCenter;
}

// rect transform

/// Returns the reversed-layout rect corresponding to the normal-layout rect
- (CGRect) reversedRectForNormalRect:(CGRect)normalRect
{
  CGSize const size = normalRect.size;
  CGPoint const normalTopLeft = normalRect.origin;
  CGPoint const reversedBottomLeft = [self reversedPointForNormalPoint:normalTopLeft];
  CGPoint const reversedTopLeft = CGPointMake(reversedBottomLeft.x, reversedBottomLeft.y - size.height);
  CGRect const reversedRect = CGRectMake(reversedTopLeft.x, reversedTopLeft.y, size.width, size.height);
  return reversedRect;
}

/// Returns the normal-layout rect corresponding to the reversed-layout rect
- (CGRect)normalRectForReversedRect:(CGRect)reversedRect
{
  // reflection is its own inverse
  return [self reversedRectForNormalRect:reversedRect];
}

// point transforms

/// Returns the reversed-layout point corresponding to the normal-layout point
- (CGPoint)reversedPointForNormalPoint:(CGPoint)normalPoint
{
  return CGPointMake(normalPoint.x, [self reversedYforNormalY:normalPoint.y]);
}

/// Returns the normal-layout point corresponding to the reversed-layout point
- (CGPoint)normalPointForReversedPoint:(CGPoint)reversedPoint
{
  // reflection is its own inverse
  return [self reversedPointForNormalPoint:reversedPoint];
}

// y transforms

/// Returns the reversed-layout y-offset, corresponding the normal-layout y-offset
- (CGFloat)reversedYforNormalY:(CGFloat)normalY
{
  CGFloat YreversedAroundContentSizeCenter = [self collectionViewContentSize].height - normalY;
  return YreversedAroundContentSizeCenter;
}

/// Returns the normal-layout y-offset, correspoding the reversed-layout y-offset
- (CGFloat)normalYforReversedY:(CGFloat)reversedY
{
  // reflection is its own inverse
  return [self reversedYforNormalY:reversedY];
}

@end
