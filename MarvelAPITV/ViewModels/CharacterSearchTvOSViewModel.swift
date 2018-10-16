//
//  CharacterSearchTvOSViewModel.swift
//  MarvelAPITV
//
//  Created by David Alarcon on 05/10/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import UIKit
import ReactiveSwift

class CharacterSearchTvOSViewModel: NSObject {
    
    public enum SearchTextType: String {
        case exact
        case startsWith
    }
    
    // MARK: - Variables
    let searchButtonSignal = MutableProperty<String?>(.none)
    let searchTextType = MutableProperty<SearchTextType>(.exact)
    
    // MARK: - Init
    override init() {
        super.init()
        setupBindings()
    }
    
    // MARK: - Setup
    func setupBindings() {
        searchButtonSignal.signal.observeValues { [weak self] searchText in
            
            switch self?.searchTextType.value {
            case .exact?:
                MarvelAPI().characters(name: searchText).observeResult { result in
                    switch result {
                    case .success(let characters):
                        print("Characters: \(characters)")
                    case .failure(let error):
                        print("ERROR: \(error)")
                    }
                }
            case .startsWith?:
                MarvelAPI().characters(startsWith: searchText).observeResult { result in
                    switch result {
                    case .success(let characters):
                        print("Characters: \(characters)")
                    case .failure(let error):
                        print("ERROR: \(error)")
                    }
                }
            case .none: break
            }
            
            
//            MarvelAPI().characters(name: searchText).observeResult { result in
//                switch result {
//                case .success(let characters):
//                    print("Characters: \(characters)")
//                case .failure(let error):
//                    print("ERROR: \(error)")
//                }
//            }
        }
        
        
    }
}
