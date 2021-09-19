//
//  RemovePresenter.swift
//  Test App
//
//  Created by Daria on 19.09.2021.
//

protocol RemoveAlertDelegate: AnyObject {
    
    // MARK: - Delegate
    
    func didRemoveDevice(_ device: Device)
    
}

class RemoveAlertPresenter {
    
    // MARK: - Propetries
    
    weak var view: RemoveAlertViewController?
    weak var delegate: RemoveAlertDelegate?
    private var device: Device
    
    
    // MARK: - Initialization
    
    init(device: Device) {
        self.device = device
    }
    
    
    // MARK: - Interface
    
    func start() {
        guard let deviceName = device.name else {
            return
        }
        view?.setAlertText(with: deviceName)
    }
    
    func didTapRemove() {
        guard let deviceId = device.id else {
            return
        }
        NetworkService.removeDevice(with: deviceId) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success:
                self.delegate?.didRemoveDevice(self.device)
                self.view?.dismiss(animated: true)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didTapCancel() {
        view?.dismiss(animated: true)
    }
    
}
