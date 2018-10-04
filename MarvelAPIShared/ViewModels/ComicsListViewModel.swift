//
//  ComicsListViewModel.swift
//  MarvelAPITV
//
//  Created by David Alarcon on 04/10/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import UIKit
import ReactiveSwift

class ComicsListViewModel: NSObject {

    var page = 0
    lazy var comics = MutableProperty<[Comic]>([])
    let shouldReloadComicsListTable = MutableProperty<Bool>(false)
    
    override init() {
        super.init()
        setupBindings()
        nextComicsPage()
    }
    
    // Reactive
    private func setupBindings() {
        shouldReloadComicsListTable <~ comics.signal.map { _ in return true }
    }
    
    // Network
    public func nextComicsPage() {
        allCharacters(page: page)
        page = page + 1
    }
    
    private func allCharacters(page: Int = 0) {
        MarvelAPI().comics(page: page).observeResult { result in
            switch result {
            case .success(let comics):
                self.comics.value.append(contentsOf: comics)
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
    
}
