//
//  MarvelAPI.swift
//  MarvelAPI
//
//  Created by David Alarcon on 02/10/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class MarvelAPI: NSObject {
    lazy var apiClient = MarvelAPIClient(publicKey: "650e801e1408159969078d2a1361c71c", privateKey: "20112b45612fd05f0d21d80d70bc8c971695c7f1")
    
    public func characters(page: Int = 0, number: Int = 20) -> Signal<[ComicCharacter], MarvelError> {
        return apiClient.requestSignal(CharactersAPIRequest(limit: number, offset: page)).map { return $0.results }
    }
}
