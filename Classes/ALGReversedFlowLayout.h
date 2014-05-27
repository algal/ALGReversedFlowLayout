//
//  ALGReversedFlowLayout.h
//  ReversedCollectionView
//
//  Created by Alexis Gallagher on 2014-05-21.
//  Copyright (c) 2014 Alexis Gallagher. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 `ALGReversedFlowLayout` is a subclass of `UICollectionViewFlowLayout`,
 but instead of laying out items left-to-right and top-to-bottom,
 it lays out items left-to-right and bottom-to-top. It reverses 
 the layout order not only of rows of cells but also of sections 
 and of the headers and footers within sections.
 
 */
@interface ALGReversedFlowLayout : UICollectionViewFlowLayout

/**
 Expand the collectionViewContentSize to fit the collectionView.bounds. Default is YES.
 
 @discussion
 
 If `expandContentSizeToBounds==NO`, then this layout reverses only the layout
 of the collection view's content, i.e., the sections, headers, footers, and rows
 of cells. However, this rect of reversed content will itself be placed at the 
 top of the collection view, because this is the normal behavior of any
 `UIScrollView` (of which the `UICollectionView` is a subclass). The result is that
 , when the collection view's bounds's size is greater than the content size, the 
 layout-reversed items will be placed at the top of the view.

 If `expandContentSizeToBounds==YES` (the default), then the bottom-to-top layout
 starts at the bottom of the UICollectionView.bounds, even when the bounds's size 
 is bigger than the natural contentSize. It does this by conditionally expanding the 
 collection view's content size, effectively creating a top inset. (If for some reason
 you need the the content size to reflect the natural content size, then you could produce
 the same effect by using the `UICollectionView.contentInset.top` property.)

 */
@property (assign,nonatomic) BOOL expandContentSizeToBounds;
@end
