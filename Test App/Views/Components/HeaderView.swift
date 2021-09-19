//
//  HeaderView.swift
//  Test App
//
//  Created by Daria on 16.09.2021.
//

import UIKit
import SnapKit

class HeaderView: UITableViewCell {
    
    // MARK: - Appearance
    
    private enum Appearance {
        static let backgroundColor = UIColor.clear
        static let normalTextColor = UIColor(red: 136/255,
                                             green: 95/255,
                                             blue: 248/255,
                                             alpha: 1)
        static let loadingTextColor = UIColor(red: 63/255,
                                              green: 73/255,
                                              blue: 86/255,
                                              alpha: 1)
        static let titleShadowColor = UIColor.black.cgColor
    }
    
    
    // MARK: - Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Appearance.normalTextColor
        label.text = "Умные\nвещи"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.layer.shadowColor = Appearance.titleShadowColor
        label.layer.shadowOpacity = 1
        label.layer.shadowRadius = 4
        label.layer.shadowOffset = CGSize(width: 0, height: 4)
        label.layer.masksToBounds = false
        return label
    }()
    
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Interface
    
    func setLoadingState() {
        titleLabel.textColor = Appearance.loadingTextColor
    }
    
    func setNormalState() {
        titleLabel.textColor = Appearance.normalTextColor
    }
    
    
    // MARK: - Private Methods
    
    private func commonInit() {
        contentView.backgroundColor = Appearance.backgroundColor
        
        setupLayout()
    }
    
    private func setupLayout() {
        contentView.addSubviews([titleLabel])
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(30)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        
    }
    
}

