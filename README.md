# ALGReversedFlowLayout

[![Version](https://img.shields.io/cocoapods/v/ALGReversedFlowLayout.svg?style=flat)](http://cocoadocs.org/docsets/ALGReversedFlowLayout)
[![License](https://img.shields.io/cocoapods/l/ALGReversedFlowLayout.svg?style=flat)](http://cocoadocs.org/docsets/ALGReversedFlowLayout)
[![Platform](https://img.shields.io/cocoapods/p/ALGReversedFlowLayout.svg?style=flat)](http://cocoadocs.org/docsets/ALGReversedFlowLayout)

`ALGReversedFlowLayout` is a subclass of `UICollectionViewFlowLayout` which lays out its items bottom-to-top instead of top-to-bottom.

## Usage

To run the example project, just do `pod try https://github.com/algal/ALGReversedFlowLayout.git`. Run the example project in the simulator with a 4" device. Play with the switches in the example project to compare it to the normal flow layout, and to see the effect of the one configurable property `expandsContentSizeToBounds`.

To use it in your app, just programatically instatiate this class exactly as you would `UICollectionViewFlowLayout`. Or if you are creating your layout in Interface Builder, then select the layout object in your storyboard or nib and use the Identity Inspector to set the class `ALGReversedFlowLayout` instead of `UICollectionViewFlowLayout`.

## Requirements

This should require only iOS6 or higher. (But I have only tested in iOS7.)

## Installation

There are two ways to use the library in your project:

1) Manually add the library files to your project:

    ALGReversedFlowLayout.h
    ALGReversedFlowLayout.m

2) Using CocoaPods

ALGReversedFlowLayout is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "ALGReversedFlowLayout"

## Author

Alexis Gallagher, alexis@alexisgallagher.com

## License

ALGReversedFlowLayout is available under the MIT license. See the LICENSE file for more info.

