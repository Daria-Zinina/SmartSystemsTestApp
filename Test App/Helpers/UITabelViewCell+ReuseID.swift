//
//  UITabelViewCell+ReuseID.swift
//  Test App
//
//  Created by Daria on 19.09.2021.
//

import UIKit

extension UITableViewCell {
    
    static var reuseID: String {
        return String(describing: self)
    }
    
}
