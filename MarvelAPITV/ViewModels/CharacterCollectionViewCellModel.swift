//
//  CharacterCollectionViewCellModel.swift
//  MarvelAPITV
//
//  Created by David Alarcon on 03/10/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import UIKit
import ReactiveSwift

class CharacterCollectionViewCellModel: NSObject {
    let character = MutableProperty<ComicCharacter?>(.none)
    let title = MutableProperty<String?>(.none)
    let thumnailImageURL = MutableProperty<URL?>(.none)
    
    // MARK: - Init
    override init() {
        super.init()
        setupBinding()
    }
    
    // MARK: - Setup
    private func setupBinding() {
        title <~ character.signal.skipNil().map { $0.name ?? .none }.skipRepeats()
        thumnailImageURL <~ character.signal.map { $0?.thumbnail?.url ?? .none }.skipRepeats()
    }
}
