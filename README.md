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

## Usage

A stack layout is a tree, where each node of the tree is a `StackLayout` object.

The `StackLayout` struct provides 5 static methods to create such nodes:

- `view`
- `spacing`
- `inset`
- `rows`
- `cols`

Rather than thinking of these as methods, though, they can be thought of as types of nodes. 
Some of them contain sub-nodes, and others act as leaf nodes.

Ultimately, each node is associated with a `UIView`.
For parent nodes, that view contains the sub-views that are associated with its child nodes.
For leaf nodes, that view has no sub-views.
Any node in a layout tree can be installed in a view (such as the root view of a view controller) by accessing its view.

The types of nodes are:

**view**

A `view` node is a leaf node that represents a single view. 
It is created by providing the UIView-subclass that you want the node to represent.

For example, to create a layout node for a single label:

```
let layout = StackLayout.view(UILabel())
```

**rows**

A `rows` node is a parent node that arranges its child nodes in a vertical stack.
It is created by providing the child nodes to be arranged in a stack, and optionally specifying their horizontal alignment.

For example, to create a layout of two rows of labels:

```
let layout = StackLayout.rows(of: [
   .view(UILabel()), // First row
   .view(UILabel()) // Second row
])
```

Under the hood, the `rows` method creates a UIStackView, configures its axis and alignment, and then adds the associated view of each of the given child nodes as an arranged subview of the stack view.

**cols**

A `cols` node is functionally equivalent to a `rows` node, except that a `cols` node arranges its child nodes horizontally.
It is created by providing the child nodes to be arranged in a stack, and optionally specifying their vertical alignment.

For example, to create a layout of two columns of layouts:

```
let layout = StackLayout.cols(of: [
   .view(UILabel()), // First column
   .view(UILabel()) // Second column
])
```

Similarly to the `rows` method, the `cols` method creates and configures a UIStackView under the hood.

**spacing**

A `spacing` node is a leaf node that represents empty space of a specific dimension in a specific direction.
It is created by specifying the dimension and direction.
A `spacing` node is used to create padding between or around other elements in a layout.

For example, to create a layout of two rows of labels with 10 points of spacing between them:

```
let layout = StackLayout.rows(of: [
   .view(UILabel()), // First row
   .spacing(of: 10, direction: .vertical), // 10 points of spacing
   .view(UILabel()) // Second row
])
```

Under the hood, the `spacing` method creates a UIView and activates a width or height constraint on it.

**inset**

An `inset` node is a parent node that adds a fixed inset on a single axis on either side of its single child node.
It is created by specifying the dimension and direction of the inset, as well as the child node.

For example, to create a layout of a single label with 10 points of inset to its left and right:

```
let layout = StackLayout.inset(
   by: 10,
   direction: .horizontal,
   of: .view(UILabel()))
```

The `inset` method is actually a convenience method to create a stack view containing three views: the view of the given child node in the middle, and two spacer views around it.
As such, under the hood, it creates a `rows` or `cols` node with a `spacing`, `view`, and another `spacing` node as its child nodes.

## Installation

### Cocoapods

PHBStackLayout is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PHBStackLayout'
```

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

phlippieb, phlippie.bosman@gmail.com

## License

PHBStackLayout is available under the MIT license. See the LICENSE file for more info.
