//
//  MarvelAPI.swift
//  MarvelAPI
//
//  Created by David Alarcon on 02/10/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import UIKit
import ReactiveSwift

class MarvelAPI: NSObject {
    //lazy var apiClient = MarvelAPIClient(publicKey: "650e801e1408159969078d2a1361c71c", privateKey: "20112b45612fd05f0d21d80d70bc8c971695c7f1")
    
    lazy var apiClient = MarvelAPIClient(publicKey: "d6580a897f29e5d71527d2f6e331363d", privateKey: "d48f85d457eb32e300123a21ca0c200dbd1b18ac")
    
    // MARK: - Comic Characters
    public func characters(page: Int = 0, number: Int = 20, name: String? = .none, startsWith: String? = .none) -> Signal<[ComicCharacter], MarvelError> {
        
        if let startsWith = startsWith {
            return apiClient.requestSignal(CharactersAPIRequest(nameStartsWith: startsWith, limit: number, offset: page)).map { return $0.results }
        } else {
            return apiClient.requestSignal(CharactersAPIRequest(name: name, limit: number, offset: page)).map { return $0.results }
        }
    }
    
    // MARK: - Comics
    public func comics(page: Int = 0, number: Int = 20) -> Signal<[Comic], MarvelError> {
        return apiClient.requestSignal(ComicsAPIRequest(limit: number, offset: page)).map { return $0.results }
    }
    
}
