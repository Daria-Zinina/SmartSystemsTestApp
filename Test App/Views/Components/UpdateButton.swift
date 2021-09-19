//
//  UpdateButton.swift
//  Test App
//
//  Created by Daria on 19.09.2021.
//

import UIKit
import SnapKit

class UpdateButton: UIButton {
    
    // MARK: - Appearance
    
    private enum Appearance {
        static let updateButtonBackgroundColor = UIColor.white
        static let updateButtonTitleColor = UIColor.black
    }
    
    
    // MARK: - Properties
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .black
        return indicator
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = Appearance.updateButtonTitleColor
        return label
    }()
    
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        
        commonInit()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Interface
    
    func setLoadingState() {
        activityIndicatorView.startAnimating()
        nameLabel.text = nil
    }
    
    func setNormalState() {
        activityIndicatorView.stopAnimating()
        nameLabel.text = "ОБНОВИТЬ"
    }
    
    
    // MARK: - Private Methods
    
    private func commonInit() {
        layer.cornerRadius = 25
        backgroundColor = Appearance.updateButtonBackgroundColor

        setupLayout()
    }
    
    private func setupLayout() {
        addSubviews([activityIndicatorView, nameLabel])
        
        activityIndicatorView.snp.makeConstraints { make in
            make.left.greaterThanOrEqualToSuperview().offset(20)
            make.right.lessThanOrEqualToSuperview().offset(-20)
            make.center.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
    
}
