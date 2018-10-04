//
//  CharactersListViewModel.swift
//  MarvelAPI
//
//  Created by David Alarcon on 02/10/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import UIKit
import ReactiveSwift

class CharactersListViewModel: NSObject {
    
    var page = 0
    lazy var characters = MutableProperty<[ComicCharacter]>([])
    let shouldReloadCharactersListTable = MutableProperty<Bool>(false)
    
    override init() {
        super.init()
        setupBindings()
        nextCharactersPage()
    }
    
    // Reactive
    private func setupBindings() {
        shouldReloadCharactersListTable <~ characters.producer.map { _ in return true }
    }
    
    // Network
    public func nextCharactersPage() {
        allCharacters(page: page)
        page = page + 1
    }
    
    private func allCharacters(page: Int = 0) {
        MarvelAPI().characters(page: page).observeResult { result in
            switch result {
            case .success(let characters):
                self.characters.value.append(contentsOf: characters)
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
    
}
