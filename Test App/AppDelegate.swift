//
//  AppDelegate.swift
//  Test App
//
//  Created by Daria on 16.09.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootController = makeRootView()
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
        return true
    }

    private func makeRootView() -> UIViewController {
        let presenter = DevicesListPresenter()
        let view = DevicesListViewController(presenter: presenter)
        presenter.view = view
        return view
    }

}

