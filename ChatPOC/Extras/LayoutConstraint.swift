//
//  LayoutConstraint.swift
//  ChatPOC
//
//  Created by CSS on 06/03/18.
//  Copyright © 2018 CSS. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    func constraint(with multiplier: CGFloat, inView view : UIView) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self.firstItem ?? UIView(), attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem ?? UIView(), attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
        view.removeConstraint(self)
        view.addConstraint(constraint)
        view.layoutIfNeeded()
        return constraint
    }
}
