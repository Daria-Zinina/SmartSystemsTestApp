//
//  RemoveAlertViewController.swift
//  Test App
//
//  Created by Daria on 17.09.2021.
//

import UIKit

class RemoveAlertViewController: UIViewController {
    
    private let presenter: DeletePresenter
    
    init(presenter: DeletePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    private let removeAlertView: UIView = {
        let removeAlertView = UIView()
        return removeAlertView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
