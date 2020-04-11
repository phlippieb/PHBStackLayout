//
//  ViewController.swift
//  PHBStackLayout
//
//  Created by phlippieb on 08/09/2019.
//  Copyright (c) 2019 phlippieb. All rights reserved.
//

import UIKit
import PHBStackLayout

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = StackLayout.inset(
            by: 16,
            direction: .horizontal,
            of: .rows(
                alignment: .left,
                of: [
                    .spacing(of: 64, direction: .vertical),
                    .view(self.headingLabel),
                    .view(self.subheadingLabel),
                    .spacing(of: 24, direction: .vertical),
                    .cols(
                        alignment: .top,
                        of: [
                            .view(self.leftColumnLabel),
                            .view(self.rightColumnLabel)
                        ]),
                    .spacing(of: 24, direction: .vertical),
                    .view(self.changeButton)
                ]))
        
        self.view.addSubview(layout.view)
        layout.view.translatesAutoresizingMaskIntoConstraints = false
        layout.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        layout.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        layout.view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        self.applyState(self.state)
    }
    
    private lazy var headingLabel: UILabel = {
        let label = UILabel()
        label.text = "Heading"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    
    private lazy var subheadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Subheading"
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private lazy var leftColumnLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var rightColumnLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var changeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Change", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(onChange), for: .touchUpInside)
        return button
    }()
    
    private let body1 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
    
    private let body2 = "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"
    
    private let body3 = "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    
    private let body4 = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet."
    
    private var state: States = .one
}

// Content changing

extension ViewController {
    @objc private func onChange() {
        let nextStateRawValue = (self.state.rawValue + 1) % States.allCases.count
        let nextState = States(rawValue: nextStateRawValue) ?? .one
        self.state = nextState
        
        DispatchQueue.main.async {
            self.applyState(self.state)
            self.view.setNeedsLayout()
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private enum States: Int, CaseIterable {
        case one
        case two
        case three
        case four
    }
    
    private func applyState(_ state: States) {
        switch state {
        case .one:
            self.leftColumnLabel.text = self.body1
            self.rightColumnLabel.text = self.body2
            
        case .two:
            self.leftColumnLabel.text = self.body3
            self.rightColumnLabel.text = self.body2
            
        case .three:
            self.leftColumnLabel.text = self.body3
            self.rightColumnLabel.text = self.body4
            
        case .four:
            self.leftColumnLabel.text = self.body1
            self.rightColumnLabel.text = self.body4
        }
    }
}

