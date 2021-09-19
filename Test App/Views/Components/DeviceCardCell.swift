//
//  DeviceCardCell.swift
//  Test App
//
//  Created by Daria on 17.09.2021.
//

import UIKit
import SnapKit

class DeviceCardCell: UITableViewCell {
    
    // MARK: - ViewModel
    
    struct ViewModel {
        let id: Int?
        let name: String?
        let icon: String?
        let isOnline: Bool?
        let type: Int?
        let status: String?
        let lastWorkTime: Int?
    }
    
    
    // MARK: - Appearance
    
    private enum Appearance {
        static let backgroundColor = UIColor(red: 25/255, green: 33/255, blue: 44/255, alpha: 1)
        static let gradientColor = [
            UIColor(red: 171/255, green: 105/255, blue: 1, alpha: 1).cgColor,
            UIColor(red: 73/255, green: 75/255, blue: 235/255, alpha: 1).cgColor
        ]
        static let onlineStatusViewColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
        static let offlineIconViewColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        static let onlineAndOfflineTextColor = UIColor.white
        static let nameTextColor = UIColor(red: 25/255, green: 33/255, blue: 44/255, alpha: 1)
        static let statusTextColor = UIColor.white
        static let backgroundStatusColor = UIColor(red: 35/255, green: 33/255, blue: 152/255, alpha: 1)
        static let lastWorkTimeTextColor = UIColor.white
    }
    
    
    // MARK: - Properties
    
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss"
        return formatter
    }()
    
    private let gradientLayer: CALayer = {
        let layer = CAGradientLayer()
        layer.colors = Appearance.gradientColor
        return layer
    }()
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.layer.addSublayer(gradientLayer)
        return view
    }()
    
    private lazy var onlineStatusView: UIView = {
        let onlineStatusView = UIView()
        onlineStatusView.layer.cornerRadius = 6
        onlineStatusView.clipsToBounds = true
        return onlineStatusView
    }()
    
    private lazy var onlineStatusLabel: UILabel = {
        let onlineStatusLabel = UILabel()
        onlineStatusLabel.font = UIFont.boldSystemFont(ofSize: 12)
        onlineStatusLabel.textColor = Appearance.onlineAndOfflineTextColor
        return onlineStatusLabel
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.numberOfLines = 2
        nameLabel.textColor = Appearance.nameTextColor
        return nameLabel
    }()
    
    private lazy var iconImage: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFill
        return icon
    }()
    
    private lazy var statusLabelContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.backgroundColor = Appearance.backgroundStatusColor
        return view
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = Appearance.statusTextColor
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var lastWorkTimeLabel: UILabel = {
        let lastWorkTime = UILabel()
        lastWorkTime.textColor = Appearance.lastWorkTimeTextColor
        lastWorkTime.font = UIFont.boldSystemFont(ofSize: 12)
        return lastWorkTime
    }()
    
    
    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Overrides
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = contentView.bounds
    }
    
    
    // MARK: - Interface
    
    func setup(with model: ViewModel) {
        if let isOnline = model.isOnline, isOnline {
            onlineStatusView.backgroundColor = Appearance.onlineStatusViewColor
            onlineStatusLabel.text = "ON LINE"
        } else {
            onlineStatusView.backgroundColor = Appearance.offlineIconViewColor
            onlineStatusLabel.text = "OFF LINE"
        }
        
        if let name = model.name {
            nameLabel.text = name.uppercased()
        }
        
        iconImage.setImage(from: model.icon, size: CGSize(width: 98, height: 98))
        
        if let status = model.status {
            statusLabel.text = status.uppercased()
        }
        
        if let lastWorkTime = model.lastWorkTime {
            let date = Date(timeIntervalSince1970: TimeInterval(lastWorkTime))
            lastWorkTimeLabel.text = formatter.string(from: date)
        }

    }
    
    
    // MARK - Private Methods
    
    private func commonInit() {
        contentView.backgroundColor = Appearance.backgroundColor
        
        setupLayout()
        selectionStyle = .none
    }
    
    private func setupLayout() {
        contentView.addSubview(cardView)
        cardView.addSubviews([onlineStatusView,
                              onlineStatusLabel,
                              nameLabel,
                              iconImage,
                              statusLabelContainerView,
                              lastWorkTimeLabel])
        statusLabelContainerView.addSubview(statusLabel)
        
        cardView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(200)
        }
        
        onlineStatusView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(17)
            make.top.equalToSuperview().offset(17)
            make.size.equalTo(12)
        }
        
        onlineStatusLabel.snp.makeConstraints { make in
            make.left.equalTo(onlineStatusView.snp.right).offset(5)
            make.top.equalToSuperview().offset(16)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(17)
            make.top.equalTo(onlineStatusLabel.snp.bottom).offset(14)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        iconImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.size.equalTo(98)
        }
        
        statusLabelContainerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-11)
            make.height.equalTo(27)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(29)
            make.right.equalToSuperview().offset(-29)
            make.centerY.equalToSuperview()
        }
        
        lastWorkTimeLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-17)
            make.bottom.equalToSuperview().offset(-18)
        }
    }
    
}
