//
//  RemoveAlertViewController.swift
//  Test App
//
//  Created by Daria on 17.09.2021.
//

import UIKit
import SnapKit

class RemoveAlertViewController: UIViewController {
    
    // MARK: - Appearance
    
    private enum Appearance {
        static let backgroundColor = UIColor.black.withAlphaComponent(0.7)
        static let removeAlertViewBackgroundColor = UIColor.white
        static let questionLabelTextColor = UIColor(red: 25/255, green: 33/255, blue: 44/255, alpha: 1)
        static let cancelButtonBackgroundColor = UIColor(red: 191/255, green: 197/255, blue: 207/255, alpha: 1)
        static let cancelButtonTitleColor = UIColor.white
        static let removeButtonBackgroundColor = UIColor(red: 1, green: 105/255, blue: 105/255, alpha: 1)
        static let removeButtonTitleColor = UIColor.white
    }
    
    
    // MARK: - Properties
    
    private let presenter: RemoveAlertPresenter
    
    private lazy var removeAlertView: UIView = {
        let removeAlertView = UIView()
        removeAlertView.backgroundColor = Appearance.removeAlertViewBackgroundColor
        removeAlertView.layer.cornerRadius = 24
        return removeAlertView
    }()
    
    private lazy var questionLabel: UILabel = {
        let questionLabel = UILabel()
        questionLabel.font = UIFont.boldSystemFont(ofSize: 24)
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.numberOfLines = 0
        questionLabel.textColor = Appearance.questionLabelTextColor
        return questionLabel
    }()
    
    private lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.layer.cornerRadius = 20
        cancelButton.backgroundColor = Appearance.cancelButtonBackgroundColor
        cancelButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        cancelButton.setTitle("ОТМЕНА", for: .normal)
        cancelButton.setTitleColor(Appearance.cancelButtonTitleColor, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return cancelButton
    }()
    
    private lazy var removeButton: UIButton = {
        let removeButton = UIButton()
        removeButton.layer.cornerRadius = 20
        removeButton.backgroundColor = Appearance.removeButtonBackgroundColor
        removeButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        removeButton.setTitle("УДАЛИТЬ", for: .normal)
        removeButton.setTitleColor(Appearance.removeButtonTitleColor, for: .normal)
        removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        return removeButton
    }()
    
    
    // MARK: - Initialization
    
    init(presenter: RemoveAlertPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Appearance.backgroundColor
        
        setupLayout()
        presenter.start()
    }
    
    
    // MARK: - Interface
    
    func setAlertText(with deviceName: String) {
        questionLabel.text = "Вы хотите удалить " + deviceName.lowercased() + "?"
    }
    
    
    // MARK: - Private methods
        
    private func setupLayout() {
        view.addSubviews([removeAlertView, questionLabel, cancelButton, removeButton])
        
        removeAlertView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.centerY.equalToSuperview()
            make.height.equalTo(201)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.left.equalTo(removeAlertView.snp.left).offset(18)
            make.top.equalTo(removeAlertView.snp.top).offset(25)
            make.right.equalTo(removeAlertView.snp.right).offset(-18)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.left.equalTo(removeAlertView.snp.left).offset(18)
            make.bottom.equalTo(removeAlertView.snp.bottom).offset(-25)
            make.height.equalTo(40)
        }
        
        removeButton.snp.makeConstraints { make in
            make.left.equalTo(cancelButton.snp.right).offset(9)
            make.right.equalTo(removeAlertView.snp.right).offset(-18)
            make.bottom.equalTo(removeAlertView.snp.bottom).offset(-25)
            make.height.equalTo(40)
            make.width.equalTo(cancelButton.snp.width)
        }
    }
    
    
    // MARK: - Actions
    
    @objc private func cancelButtonTapped() {
        presenter.didTapCancel()
    }
    
    @objc private func removeButtonTapped() {
        presenter.didTapRemove()
    }
    
}
