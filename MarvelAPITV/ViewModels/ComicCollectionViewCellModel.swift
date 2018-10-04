//
//  ComicCollectionViewCellModel.swift
//  MarvelAPITV
//
//  Created by David Alarcon on 04/10/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import UIKit
import ReactiveSwift

class ComicCollectionViewCellModel: NSObject {
    let comic = MutableProperty<Comic?>(.none)
    let title = MutableProperty<String?>(.none)
    let thumbnailImageURL = MutableProperty<URL?>(.none)
    
    // MARK: - Init
    override init() {
        super.init()
        setupBinding()
    }
    
    // MARK: - Setup
    private func setupBinding() {
        title <~ comic.signal.skipNil().map { $0.title ?? .none }.skipRepeats()
        thumbnailImageURL <~ comic.signal.map { $0?.thumbnail?.url ?? .none }.skipRepeats()
    }
}
