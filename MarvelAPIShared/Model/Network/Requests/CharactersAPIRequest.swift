//
//  CharactersAPIRequest.swift
//  MarvelAPI
//
//  Created by David Alarcon on 26/09/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import Foundation

public struct CharactersAPIRequest: APIRequest {
    public typealias Response = [ComicCharacter]
    public var path: String {
        return "characters"
    }
    
    public let name: String?
    public let nameStartsWith: String?
    public let limit: Int?
    public let offset: Int?
    
    public init(name: String? = .none, nameStartsWith: String? = .none, limit: Int? = .none, offset: Int? = .none)  {
        self.name = name
        self.nameStartsWith = nameStartsWith
        self.limit = limit
        self.offset = offset
    }
}
