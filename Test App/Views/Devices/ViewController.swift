//
//  DevicesListViewController.swift
//  Test App
//
//  Created by Daria on 16.09.2021.
//

import UIKit
import SnapKit

class DevicesListViewController: UIViewController {
    
    private var refreshControl: UIRefreshControl?
    private lazy var presenter = Presenter(view: self)
    
    private let tableView = UITableView()
    private lazy var updateButton: UIButton = {
        let updateButton = UIButton()
        updateButton.layer.cornerRadius = 25
        updateButton.backgroundColor = .white
        updateButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        updateButton.setTitle("   ОБНОВИТЬ   ", for: .normal)
        updateButton.setTitleColor(.black, for: .normal)
        return updateButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupTableView()
        presenter.loadData()
    }
    
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
        tableView.register(TitleCell.self,
                           forCellReuseIdentifier: String(describing: TitleCell.self))
        tableView.register(DeviceCardCell.self,
                           forCellReuseIdentifier: String(describing: DeviceCardCell.self))
        
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = nil
        tableView.refreshControl = refreshControl
        tableView.backgroundColor = #colorLiteral(red: 0.05038774014, green: 0.0472632423, blue: 0.1597575247, alpha: 1)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // дисплэй с кейсами 
    func reload() {
        tableView.reloadData()
    }


}

extension DevicesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeviceCardCell.reuseID) as? DeviceCardCell
        let viewModels = presenter.devices[indexPath.row]
        let imageURL = NetworkService.getImageURL(fromPath: viewModels.icon)
        let model = DeviceCardCell.DevicesCellViewModel(id: viewModels.id,
                                                        name: viewModels.name,
                                                        icon: imageURL,
                                                        isOnline: viewModels.isOnline,
                                                        type: viewModels.type,
                                                        status: viewModels.status,
                                                        lastWorkTime: viewModels.lastWorkTime)
        cell?.setup(with: model)
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
}

extension DevicesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let device = presenter.devices[indexPath.row]
        let viewController = DeviceAssembly.createView(with: device)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
