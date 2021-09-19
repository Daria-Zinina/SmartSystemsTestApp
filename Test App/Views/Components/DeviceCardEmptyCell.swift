//
//  DeviceCardEmptyCell.swift
//  Test App
//
//  Created by Daria on 18.09.2021.
//

import UIKit
import SnapKit

class DeviceCardEmptyCell: UITableViewCell {
    
    // MARK: - Appearance
    
    private enum Appearance {
        static let backgroundColor = UIColor(red: 25/255, green: 33/255, blue: 44/255, alpha: 1)
        static let viewBackgroundColor = UIColor(red: 63/255, green: 73/255, blue: 86/255, alpha: 1)
        static let onlineStatusIconViewBackgroundColor = UIColor(red: 25/255, green: 33/255, blue: 44/255, alpha: 0.5)
        static let onlineStatusViewBackgroundColor = UIColor(red: 25/255, green: 33/255, blue: 44/255, alpha: 0.5)
        static let nameViewBackgroundColor = UIColor(red: 25/255, green: 33/255, blue: 44/255, alpha: 0.5)
        static let backgroundStatusColor = UIColor(red: 25/255, green: 33/255, blue: 44/255, alpha: 0.5)
    }
    
    
    // MARK: - Properties
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = Appearance.viewBackgroundColor
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var onlineStatusIconView: UIView = {
        let onlineStatusIconView = UIView()
        onlineStatusIconView.backgroundColor = Appearance.onlineStatusIconViewBackgroundColor
        onlineStatusIconView.layer.cornerRadius = 6
        onlineStatusIconView.clipsToBounds = true
        return onlineStatusIconView
    }()
    
    private lazy var onlineStatusView: UIView = {
        let onlineStatusView = UIView()
        onlineStatusView.backgroundColor = Appearance.onlineStatusViewBackgroundColor
        onlineStatusView.layer.cornerRadius = 5
        onlineStatusView.layer.masksToBounds = true
        return onlineStatusView
    }()
    
    private lazy var nameView: UIView = {
        let nameView = UIView()
        nameView.backgroundColor = Appearance.nameViewBackgroundColor
        onlineStatusView.layer.cornerRadius = 5
        onlineStatusView.layer.masksToBounds = true
        return nameView
    }()
    
    private lazy var statusView: UIView = {
        let status = UIView()
        status.backgroundColor = Appearance.backgroundStatusColor
        status.layer.cornerRadius = 15
        status.layer.masksToBounds = true
        return status
    }()
    
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Methods
    
    private func commonInit() {
        contentView.backgroundColor = Appearance.backgroundColor
        
        setupLayout()
    }
    
    private func setupLayout() {
        contentView.addSubview(cardView)
        cardView.addSubviews([onlineStatusIconView, onlineStatusView, nameView, statusView])
        
        cardView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(200)
        }
        
        onlineStatusIconView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(17)
            make.top.equalToSuperview().offset(17)
            make.size.equalTo(12)
        }
        
        onlineStatusView.snp.makeConstraints { make in
            make.left.equalTo(onlineStatusIconView.snp.right).offset(7)
            make.top.equalToSuperview().offset(17)
            make.height.equalTo(12)
            make.width.equalTo(46)
        }
        
        nameView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(19)
            make.top.equalTo(onlineStatusView.snp.bottom).offset(15)
            make.height.equalTo(28)
            make.width.equalTo(168)
        }
        
        statusView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(14)
            make.bottom.equalToSuperview().offset(-11)
            make.height.equalTo(27)
            make.width.equalTo(130)
        }
    }

}
