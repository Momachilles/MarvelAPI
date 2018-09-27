//
//  MarvelAPIClient.swift
//  MarvelAPI
//
//  Created by David Alarcon on 26/09/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

typealias ResponseSignal<T: APIRequest> = SignalProducer<DataContainer<T.Response>, MarvelError>

class MarvelAPIClient {
    private let baseEndpointUrl = URL(string: "https://gateway.marvel.com:443/v1/public/")!
    private let session = URLSession(configuration: .default)
    
    private let publicKey: String
    private let privateKey: String
    
    public init(publicKey: String, privateKey: String) {
        self.publicKey = publicKey
        self.privateKey = privateKey
    }
    
    private func endpoint<T: APIRequest>(for request: T) -> URL? {
        guard let baseURL = URL(string: request.path, relativeTo: baseEndpointUrl) else { fatalError("Bad resourceName: \(request.path)") }
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = "\(timestamp)\(privateKey)\(publicKey)".md5
        let commonQueryItems = [
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "apikey", value: publicKey),
            ]
        let customQueryItems: [URLQueryItem]
        
        do {
            customQueryItems = try URLQueryItemEncoder.encode(request)
        } catch {
            fatalError("Wrong parameters: \(error)")
        }
        
        components?.queryItems = commonQueryItems + customQueryItems
        
        return components?.url
    }
    
    public func request<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<DataContainer<T.Response>, MarvelError>) {
        guard let endpoint = endpoint(for: request) else { completion(.failure(MarvelError.url)); return }
        
        let task = session.dataTask(with: endpoint) { data, response, error in
            guard let data = data else { completion(.failure(MarvelError.noData)); return }
            if let error = error { completion(.failure(MarvelError.server(message: error.localizedDescription))); return }
            do {
                let marvelResponse = try JSONDecoder().decode(MarvelResponse<T.Response>.self, from: data)
                if let dataContainer = marvelResponse.data {
                    completion(.success(dataContainer))
                } else if let message = marvelResponse.message {
                    completion(.failure(MarvelError.server(message: message)))
                } else {
                    completion(.failure(MarvelError.decoding))
                }
            } catch {
                completion(.failure(MarvelError.server(message: error.localizedDescription)))
            }
        }
        
        task.resume()
    }

    public func request<T: APIRequest>(_ request: T) -> ResponseSignal<T> {
        return ResponseSignal<T> { [weak self] observable, lifetime in
            
            guard let endpoint = self?.endpoint(for: request) else {
                observable.send(error: MarvelError.url)
                observable.sendCompleted()
                return
            }
            
            let task = self?.session.dataTask(with: URLRequest(url: endpoint)) { data, response, error in
                
                defer {
                    observable.sendCompleted()
                }
                
                guard let data = data else {
                    observable.send(error: MarvelError.noData)
                    return
                }
                if let error = error {
                    observable.send(error: MarvelError.server(message: error.localizedDescription))
                }
                do {
                    let marvelResponse = try JSONDecoder().decode(MarvelResponse<T.Response>.self, from: data)
                    if let dataContainer = marvelResponse.data {
                        observable.send(value: dataContainer)
                    } else if let message = marvelResponse.message {
                        observable.send(error: MarvelError.server(message: message))
                    } else {
                        observable.send(error: MarvelError.decoding)
                    }
                } catch {
                    observable.send(error: MarvelError.server(message: error.localizedDescription))
                }
            }
            
            lifetime.observeEnded {
                task?.cancel()
            }
            
        }.retry(upTo: 3).timeout(after: 10, raising: MarvelError.timeout, on: QueueScheduler())
    }
    
    
    /*
     guard let endpoint = endpoint(for: request) else {
     return Signal<DataContainer<T.Response>?, MarvelError>() // SignalProducer.init(error: MarvelError.url)
     }
     
     return session.reactive
     .data(with: URLRequest(url: endpoint))
     .retry(upTo: 3)
     .mapError { anyError -> MarvelError in
     return anyError.error as! MarvelError
     }
     .map { response -> DataContainer<T.Response>? in
     do {
     let marvelResponse = try JSONDecoder().decode(MarvelResponse<T.Response>.self, from: response.0)
     if let dataContainer = marvelResponse.data {
     return dataContainer
     } else {
     return .none
     }
     } catch {
     return .none
     }
     }
     }*/
}
