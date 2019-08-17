//
//  NonInteractableViews.swift
//  PHBStackLayout
//
//  Created by Phlippie Bosman on 2019/08/09.
//

import UIKit

// Non-interactable versions of UIViews that pass their taps through to their parent views.

class NonInteractableView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? nil : view
    }
}

class NonInteractableStackView: UIStackView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? nil : view
    }
}
