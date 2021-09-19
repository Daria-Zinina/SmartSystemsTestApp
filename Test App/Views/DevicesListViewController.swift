//
//  DevicesListViewController.swift
//  Test App
//
//  Created by Daria on 16.09.2021.
//

import UIKit
import SnapKit

// MARK: - DevicesListViewState

enum DevicesListViewState {
    case content([DeviceCardCell.ViewModel])
    case loading
    case error
}

class DevicesListViewController: UIViewController {
    
    // MARK: - Appearance
    
    private enum Appearance {
        static let backgroundColor = UIColor(red: 25/255,
                                             green: 33/255,
                                             blue: 44/255,
                                             alpha: 1)
        static let updateButtonBackgroundColor = UIColor.white
        static let updateButtonTitleColor = UIColor.black
    }
    
    
    // MARK: - Properties
    
    private let presenter: DevicesListPresenter
    private let tableView = UITableView()
    private let headerView = HeaderView()
    private lazy var emptyView: EmptyDevicesView = {
        let emptyView = EmptyDevicesView()
        emptyView.delegate = self
        return emptyView
    }()
    
    private let updateButton: UpdateButton = {
        let button = UpdateButton()
        button.addTarget(self, action: #selector(didTapUpdateButton), for: .touchUpInside)
        return button
    }()
    
    private var state: DevicesListViewState = .loading
    
    
    // MARK: - Initialization
    
    init(presenter: DevicesListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupTableView()
        presenter.loadData()
    }
    
    
    // MARK: - Interface
    
    func display(state: DevicesListViewState) {
        self.state = state
        switch state {
        case .content:
            updateButton.setNormalState()
            headerView.setNormalState()
            emptyView.removeFromSuperview()
        case .loading:
            updateButton.setLoadingState()
            headerView.setLoadingState()
            emptyView.removeFromSuperview()
        case .error:
            showEmptyView()
        }
        tableView.reloadData()
    }
    
    func pushDeviceRemoving(with device: Device, delegate: RemoveAlertDelegate?) {
        let presenter = RemoveAlertPresenter(device: device)
        let viewController = RemoveAlertViewController(presenter: presenter)
        presenter.view = viewController
        presenter.delegate = delegate
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController, animated: true)
    }
    
    
    // MARK: - Private methods
    
    private func setupLayout() {
        view.addSubviews([tableView, updateButton])
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        updateButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-17)
            make.bottom.equalToSuperview().offset(-26)
            make.height.equalTo(51)
        }
    }
    
    private func setupTableView() {
        tableView.register(HeaderView.self,
                           forCellReuseIdentifier: String(describing: HeaderView.self))
        tableView.register(DeviceCardCell.self,
                           forCellReuseIdentifier: String(describing: DeviceCardCell.self))
        tableView.register(DeviceCardEmptyCell.self,
                           forCellReuseIdentifier: String(describing: DeviceCardEmptyCell.self))
        
        tableView.backgroundColor = Appearance.backgroundColor
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        
        headerView.frame.size.height = 110
        tableView.tableHeaderView = headerView
        
        tableView.contentInset = UIEdgeInsets(top: 0,
                                              left: 0,
                                              bottom: 80,
                                              right: 0)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func showEmptyView() {
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    
    // MARK: - Actions
    
    @objc private func didTapUpdateButton() {
        presenter.didTapUpdate()
    }

}

extension DevicesListViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .content(let models):
            return models.count
        case .loading:
            return 5
        case .error:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        switch state {
        case .content(let models):
            let deviceCardCell = tableView.dequeueReusableCell(withIdentifier: DeviceCardCell.reuseID) as? DeviceCardCell
            if indexPath.row < models.count {
                let viewModel = models[indexPath.row]
                deviceCardCell?.setup(with: viewModel)
            }
            cell = deviceCardCell
        case .loading:
            cell = tableView.dequeueReusableCell(withIdentifier: DeviceCardEmptyCell.reuseID)
        default:
            break
        }
        return cell ?? UITableViewCell()
    }
    
}

extension DevicesListViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectDevice(at: indexPath.row)
    }
    
}

extension DevicesListViewController: EmptyDevicesViewDelegate {
    
    // MARK: - EmptyDevicesViewDelegate
    
    func didTapRetry() {
        presenter.didTapRetry()
    }
    
}
