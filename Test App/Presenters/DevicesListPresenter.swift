//
//  Presenter.swift
//  Test App
//
//  Created by Daria on 16.09.2021.
//

import Foundation

class DevicesListPresenter {
    
    // MARK: - Properties
    
    weak var view: DevicesListViewController?
    private var devices = [Device]()
    
    
    // MARK: - Interface
    
    func loadData() {
        view?.display(state: .loading)
        NetworkService.getDevices { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let loadedDevices):
                self.devices = loadedDevices
                self.updateContent()
            case .failure:
                self.view?.display(state: .error)
            }
        }
    }
    
    func didSelectDevice(at index: Int) {
        if devices.count > index {
            let device = devices[index]
            view?.pushDeviceRemoving(with: device, delegate: self)
        }
    }
    
    func didTapUpdate() {
        view?.display(state: .loading)
        NetworkService.resetDevices { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success:
                self.loadData()
            case .failure:
                self.view?.display(state: .error)
            }
        }
    }
    
    func didTapRetry() {
        loadData()
    }
    
    
    // MARK: - Private Methods
    
    private func updateContent() {
        let models: [DeviceCardCell.ViewModel] = devices.map { item in
            return DeviceCardCell.ViewModel(id: item.id,
                                            name: item.name,
                                            icon: item.icon,
                                            isOnline: item.isOnline,
                                            type: item.type,
                                            status: item.status,
                                            lastWorkTime: item.lastWorkTime)
        }
        view?.display(state: .content(models))
    }
    
}

extension DevicesListPresenter: RemoveAlertDelegate {
    
    // MARK: - RemoveAlertDelegate
    
    func didRemoveDevice(_ device: Device) {
        guard let removeIndex = devices.firstIndex(where: { $0.id == device.id }) else {
            return
        }
        devices.remove(at: removeIndex)
        updateContent()
    }
    
}
