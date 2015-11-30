//
//  ALGReversedFlowLayout.m
//  ReversedCollectionView
//
//  Created by Alexis Gallagher on 2014-05-21.
//  Copyright (c) 2014 Alexis Gallagher. All rights reserved.
//

#import "ALGReversedFlowLayout.h"

@interface ALGReversedFlowLayout ()
@end

@implementation ALGReversedFlowLayout


#pragma mark overrides

- (instancetype) initWithCoder:(NSCoder *)coder
{
  self = [super initWithCoder:coder];
  if (self) {
    self->_expandContentSizeToBounds = YES;
    self->_minimumContentSizeHeight = nil;
  }
  return self;
}

- (instancetype) init
{
  self = [super init];
  if (self) {
    self->_expandContentSizeToBounds = YES;
    self->_minimumContentSizeHeight = nil;
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
  CGSize expandedSize = [super collectionViewContentSize];
  
  if (self.expandContentSizeToBounds) {
    expandedSize.height = MAX(expandedSize.height, [[self collectionView] bounds].size.height);
  }

  if (self.minimumContentSizeHeight) {
    expandedSize.height = MAX(expandedSize.height, [self.minimumContentSizeHeight floatValue]);
  }

  return expandedSize;
}

- (UICollectionViewLayoutAttributes *) layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewLayoutAttributes * attribute = [[super layoutAttributesForItemAtIndexPath:indexPath] copy];
  [self modifyLayoutAttribute:attribute];
  return attribute;
}

- (NSArray *) layoutAttributesForElementsInRect:(CGRect)reversedRect
{
  CGRect const normalRect = [self normalRectForReversedRect:reversedRect];
  NSArray * attributes = [super layoutAttributesForElementsInRect:normalRect];
  NSMutableArray *result = [NSMutableArray arrayWithCapacity:attributes.count];
  for(UICollectionViewLayoutAttributes *attribute in attributes){
    UICollectionViewLayoutAttributes *attr = [attribute copy];
    [self modifyLayoutAttribute:attr];
    [result addObject:attr];
  }
  return result;
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
