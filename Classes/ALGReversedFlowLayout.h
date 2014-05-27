//
//  ALGReversedFlowLayout.h
//  ReversedCollectionView
//
//  Created by Alexis Gallagher on 2014-05-21.
//  Copyright (c) 2014 Bloom FIlter. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 
 This collection view acts like a vertical UICollectionViewFlowLayout,
 but instead of laying out items left-to-right and top-to-bottom,
 it lays out items left-to-right and bottom-to-top. This reverses not only
 the vertical order of rows of cells but also of sections and of the headers
 and footers within sections.
 
 If expandContentSizeToBounds==NO, then this layout only reverses the layout
 of the collection view's content, i.e., all its items. However, this reversed
 content will itself be placed at the top of the collection view, because this is
 how any scroll view treats its content.
 
 If expandContentSizeToBounds==YES (the defualt), then the the bottom-to-top layout
 starts at the bottom of the collectionView.bounds. It does this by expanding the
 collection view's content size to create a top buffer. (You could also
 produce the smae affect using the collectionView.contentInset.top property.)
 
 */

@interface ALGReversedFlowLayout : UICollectionViewFlowLayout
/// should be yes, or else should set contentInsets
@property (assign,nonatomic) BOOL expandContentSizeToBounds;
@end
