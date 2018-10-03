//
//  ComicAPIRequest.swift
//  MarvelAPI
//
//  Created by David Alarcon on 26/09/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import Foundation

public struct ComicAPIRequest: APIRequest {
    public typealias Response = [Comic]
    public var path: String {
        return "comics/\(comicId)"
    }
    
    private let comicId: Int
    
    public init(comicId: Int) {
        self.comicId = comicId
    }
}
