//
//  EmptyDevicesView.swift
//  Test App
//
//  Created by Daria on 19.09.2021.
//

import UIKit

protocol EmptyDevicesViewDelegate: AnyObject {
    
    // MARK: - Delegate
    
    func didTapRetry()
    
}

class EmptyDevicesView: UIView {
    
    // MARK: - Appearance
    
    private enum Appearance {
        static let backgroundColor = UIColor(red: 25/255,
                                             green: 33/255,
                                             blue: 44/255,
                                             alpha: 1)
        static let errorTextColor = UIColor.white
        static let repeatButtonBackgroundColor = UIColor(red: 35/255, green: 33/255, blue: 152/255, alpha: 1)
        static let repeatTextColor = UIColor.white
    }
    
    
    // MARK: - Properties
    
    weak var delegate: EmptyDevicesViewDelegate?
    
    private let errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.textColor = Appearance.errorTextColor
        errorLabel.text = "Что-то пошло не так :("
        errorLabel.font = .boldSystemFont(ofSize: 24)
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.lineBreakMode = .byWordWrapping
        return errorLabel
    }()
    
    private lazy var repeatButton: UIButton = {
        let repeatButton = UIButton()
        repeatButton.backgroundColor = Appearance.repeatButtonBackgroundColor
        repeatButton.layer.cornerRadius = 20
        repeatButton.addTarget(self, action: #selector(repeatButtonTapped), for: .touchUpInside)
        return repeatButton
    }()
    
    private let repeatLabel: UILabel = {
        let repeatLabel = UILabel()
        repeatLabel.textColor = Appearance.repeatTextColor
        repeatLabel.text = "ПОВТОРИТЬ"
        repeatLabel.font = .boldSystemFont(ofSize: 14)
        return repeatLabel
    }()
    
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = Appearance.backgroundColor
        
        setupLayout()
    }
    
    private func setupLayout() {
        addSubviews([errorLabel, repeatButton])
        repeatButton.addSubview(repeatLabel)
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(239)
            make.centerX.equalToSuperview()
        }
        
        repeatButton.snp.makeConstraints { make in
            make.top.equalTo(errorLabel.snp.bottom).offset(55)
            make.centerX.equalToSuperview()
        }
        
        repeatLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    
    // MARK: - Actions
    
    @objc func repeatButtonTapped() {
        delegate?.didTapRetry()
    }
    
}
