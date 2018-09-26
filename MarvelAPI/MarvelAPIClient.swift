//
//  MarvelAPIClient.swift
//  MarvelAPI
//
//  Created by David Alarcon on 26/09/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import UIKit

class MarvelAPIClient {
    private let baseEndpointUrl = URL(string: "https://gateway.marvel.com:443/v1/public/")!
    private let session = URLSession(configuration: .default)
    
    private let publicKey: String
    private let privateKey: String
    
    public init(publicKey: String, privateKey: String) {
        self.publicKey = publicKey
        self.privateKey = privateKey
    }
    
    public func request<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<DataContainer<T.Response>>) {
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
                completion(.failure(error))
            }
        }
        task.resume()
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
}
