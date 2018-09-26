//
//  ComicsAPIRequest.swift
//  MarvelAPI
//
//  Created by David Alarcon on 26/09/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import Foundation

public struct ComicsAPIRequest: APIRequest {
    public enum ComicFormat: String, Encodable {
        case comic
        case digital = "digital comic"
        case hardcover
    }
    
    public typealias Response = [Comic]
    
    public var path: String {
        return "comics"
    }
    
    public let title: String?
    public let titleStartsWith: String?
    public let format: ComicFormat?
    public let limit: Int?
    public let offset: Int?
    
    
    init(title: String? = .none, titleStartsWith: String? = .none, format: ComicFormat? = .none, limit: Int? = .none, offset: Int? = .none) {
        self.title = title
        self.titleStartsWith = titleStartsWith
        self.format = format
        self.limit = limit
        self.offset = offset
    }
    
}
