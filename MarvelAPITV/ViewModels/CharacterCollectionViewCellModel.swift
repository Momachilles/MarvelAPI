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
        title <~ character.signal.map { $0?.name ?? .none }.skipRepeats()
        thumnailImageURL <~ character.signal.map { $0?.thumbnail?.url ?? .none }.skipRepeats()
        
        /*
        thumnailImage <~ character.signal.map { comicCharacter in
            DispatchQueue.global(qos: DispatchQoS.default.qosClass).async {
                if let url = comicCharacter.thumbnail?.url {
                    do {
                        let data = try Data(contentsOf: url)
                        DispatchQueue.main.async {
                            let img = UIImage(data: data)
                            return  img
                        }
                    } catch {
                        print("ERROR: \(error)")
                    }
                }
            }
        }*/
    }
}
