//
//  UIImageView + LoadImage.swift
//  Test App
//
//  Created by Daria on 17.09.2021.
//

import UIKit

extension UIImageView {
    
    func setImage(from path: String?, size: CGSize?) {
        guard let path = path else {
            return
        }
        
        NetworkService.loadImage(fromPath: path) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let data):
                self.image = UIImage(data: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
