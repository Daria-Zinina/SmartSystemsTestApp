//
//  NetworkService.swift
//  Test App
//
//  Created by Daria on 16.09.2021.
//

import Foundation

class NetworkService {
    
    // MARK: - Constants
    
    private enum Constants {
        static let baseUrlString = "https://dev.api.sls.ompr.io/api/v1/test"
        static let baseImageURLString = "https://dev.api.sls.ompr.io"
        static let listPath = "/devices"
        static let resetPath = "/reset-deleted"
        
    }
    
    
    // MARK: - Interface
    
    static func getDevices(onComplete: @escaping (Result<[Device], Error>) -> Void) {
        guard let url = URL(string: Constants.baseUrlString + Constants.listPath) else {
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let devicesList = try decoder.decode(DevicesResponse.self, from: data)
                
                DispatchQueue.main.async {
                    onComplete(.success(devicesList.data ?? []))
                }
            } catch {
                DispatchQueue.main.async {
                    onComplete(.failure(error))
                }
            }
        }
        
        dataTask.resume()
    }
    
    static func removeDevice(with id: Int, onComplete: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: Constants.baseUrlString + Constants.listPath + "/\(id)") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    onComplete(.failure(error))
                } else {
                    onComplete(.success(()))
                }
            }
        }.resume()
    }
    
    static func resetDevices(onComplete: @escaping((Result<Void, Error>) -> Void)) {
        guard let url = URL(string: Constants.baseUrlString + Constants.listPath + Constants.resetPath) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    onComplete(.failure(error))
                } else {
                    onComplete(.success(()))
                }
            }
        }.resume()
    }
    
    static func loadImage(fromPath path: String, onComplete: @escaping (Result<Data, Error>) -> Void) {
        let stringURL = Constants.baseImageURLString + path
        
        guard let url = URL(string: stringURL) else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    onComplete(.failure(error))
                } else if let data = data {
                    onComplete(.success(data))
                }
            }
        }
        dataTask.resume()
    }
}
