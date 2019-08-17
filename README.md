# PHBStackLayout

[![Version](https://img.shields.io/cocoapods/v/PHBStackLayout.svg?style=flat)](https://cocoapods.org/pods/PHBStackLayout)
[![License](https://img.shields.io/cocoapods/l/PHBStackLayout.svg?style=flat)](https://cocoapods.org/pods/PHBStackLayout)
[![Platform](https://img.shields.io/cocoapods/p/PHBStackLayout.svg?style=flat)](https://cocoapods.org/pods/PHBStackLayout)

## What is this?

tl;dr -- This is a μFramework that provides declarative syntax for UIStackView-based layouts in Swift.

### Background -- UIStackView layout

UIStackViews facilitate some surprisingly powerful layout-building. 
For example, say I want to create a layout for a table view cell with the following components:

- An image on the left, centered vertically
- A heading to the right of that image, aligned to the top of the cell
- A subheading underneath that heading
- A chevron icon on the right of the cell

I could lay this out using a lot of `thing.anchor.constraint(equalTo: otherThing.anchor).isActive = true`-statements. 
But, depending on how much you've worked with constraint-based autolayout, such statements don't always read as clearly as they could -- especially when you're not just laying components out in a single direction.

In my opinion, the *intent* of the layout becomes more clear if I do it as follows:

- Create a horizontal UIStackView to contain, from left to right, the image, text, and chevron
- Create a vertical UIStackView to contain, from top to bottom, the heading and the subheading

Such an implementation is more in line with an intuitive understanding of the layout, which consists of a main left-to-right layout, with a nested top-to-bottom sub-layout.
This implementation creates an adaptive, AutoLayout-backed UI, without the need for any constraints.

As an added bonus, stack views handle hidden subviews much better than constraint-based layouts. If an arranged subview of a stack view gets hidden, the entire layout adapts as if the view isn't in the layout at all.
For example, in my table view cell above, if I don't want my cell to have a chevron icon in some cases, I can simply set the label or image view's `isHidden` property to true, and the text views will now fill up the available space all the way to the right of the cell.

### The declarative syntax wrapper

The one problem with UIStackView layouts is the tedium of creating, configuring and maintaining all those stack views.
I wanted to create a wrapper that handles all that boilerplate code for me.
Such a wrapper also presents an opportunity to expose some extra functionality that may come in handy when creating UIs, such as adding spacing between elements, or adding insets around elements.
And since we're doing away with constraints, the wrapper can also give us a convenient way of installing a layout in a parent view.

So that's what this is: a framework that wraps UIStackView-based layouts in a convenient and powerful syntax.

### What about SwiftUI?

SwiftUI is Apple's shiny new declarative UI paradigm. By all accounts, it's going to solve the problem of tedious layout code for good. PHBStackLayout pales in comparison. So why did I make it? Simply because I need something to help me with UI code now, and 

- SwiftUI isn't ready yet
- I need to support versions of iOS that will not be supported by SwiftUI when it does get released

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

PHBStackLayout is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PHBStackLayout'
```

## Author

phlippieb, phlippie.bosman@gmail.com

## License

PHBStackLayout is available under the MIT license. See the LICENSE file for more info.
