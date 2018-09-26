//
//  ComicCharacter.swift
//  MarvelAPI
//
//  Created by David Alarcon on 26/09/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import Foundation

public struct ComicCharacter: Decodable {
    public let id: Int
    public let name: String?
    public let description: String?
    public let thumbnail: Image?
}
