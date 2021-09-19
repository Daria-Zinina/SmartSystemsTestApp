//
//  UIView+AddSubviews.swift
//  Test App
//
//  Created by Daria on 16.09.2021.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
    
}
