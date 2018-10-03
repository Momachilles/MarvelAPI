//
//  Comic.swift
//  MarvelAPI
//
//  Created by David Alarcon on 26/09/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import Foundation

public struct Comic: Decodable {
    public let id: Int
    public let title: String?
    public let issueNumber: Double?
    public let description: String?
    public let pageCount: Int?
    public let thumbnail: Image?
}
