//
//  StackLayout.swift
//  PHBStackLayout
//
//  Created by Phlippie Bosman on 2019/08/09.
//

/// This type provides methods for creating a UIStackView-based layout of views.
/// The layout is built up as a tree, starting from a root node, where each node can branch out to more nodes, or contain a view.
/// Each node has an associated view, which is used to build up the concrete layout.
struct StackLayout {
    
    // Layout elements/nodes each have a view.
    // The view can be read by clients to add the layout to a UI,
    // and is set when creating a layout element, using one of the factory methods (see below -- view, spacing, rows, cols).
    
    let view: UIView
    
    private init(_ view: UIView) { self.view = view }
    
    // Layout element factory methods -- use these!
    
    /// A layout element for a view.
    static func view(_ view: UIView) -> StackLayout {
        return .init(view)
    }
    
    /// A layout element for spacing in the given direction.
    static func spacing(of amount: CGFloat, direction: Axis) -> StackLayout {
        let view = spacingView(spacingAmount: amount, direction: direction)
        return .init(view)
    }
    
    /// A convenience element for adding spacing around the child layout on either side.
    /// (Creates a stack layout under the hood.)
    static func inset(by amount: CGFloat, direction: Axis, of layout: StackLayout) -> StackLayout {
        let view = stackView(
            axis: direction,
            alignment: .fill,
            layouts: [
                .spacing(of: amount, direction: direction),
                layout,
                .spacing(of: amount, direction: direction)
            ])
        return .init(view)
    }
    
    /// A layout element for rows of sub-elements.
    /// - Parameter alignment: The vertical alignment of elements.
    static func rows(alignment: Alignment = .center, of layouts: [StackLayout]) -> StackLayout {
        let view = stackView(axis: .vertical, alignment: alignment, layouts: layouts)
        return .init(view)
    }
    
    /// A layout element for columns of sub-elements.
    /// - Parameter alignment: The horizontal alignment of elements.
    static func cols(alignment: Alignment = .center, of layouts: [StackLayout]) -> StackLayout {
        let view = stackView(axis: .horizontal, alignment: alignment, layouts: layouts)
        return .init(view)
    }
    
    // Configuration types
    
    typealias Axis = NSLayoutConstraint.Axis
    
    enum Alignment {
        case leading, center, trailing, fill
        static let left: Alignment = .leading
        static let right: Alignment = .trailing
        static let top: Alignment = .leading
        static let bottom: Alignment = .trailing
        
        fileprivate var forStackView: UIStackView.Alignment {
            switch self {
            case .leading: return .leading
            case .center: return .center
            case .trailing: return .trailing
            case .fill: return .fill
            }
        }
    }
}

// Convenience method for installing a layout to a view.

extension StackLayout {
    func install(in view: UIView, with insets: UIEdgeInsets = .zero) {
        view.addSubview(self.view)
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// Helpers for creating the views associated with layout nodes.

extension StackLayout {
    /// Create a UIView associated with a spacing node.
    /// The view is simply constrained to have a width or height of the given amount.
    private static func spacingView(spacingAmount: CGFloat, direction: Axis) -> UIView {
        let view = NonInteractableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        switch direction {
        case .horizontal: view.widthAnchor.constraint(equalToConstant: spacingAmount).isActive = true
        case .vertical: view.heightAnchor.constraint(equalToConstant: spacingAmount).isActive = true
        @unknown default: return view
        }
        return view
    }
    
    /// Create a UIView associated with a stack (rows or cols) node.
    private static func stackView(axis: Axis, alignment: Alignment, layouts: [StackLayout]) -> UIView {
        let stackView = NonInteractableStackView()
        stackView.axis = axis
        stackView.alignment = alignment.forStackView
        stackView.distribution = .fill
        layouts.forEach { layout in
            stackView.addArrangedSubview(layout.view)
        }
        return stackView
    }
}
