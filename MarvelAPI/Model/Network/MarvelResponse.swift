//
//  MarvelResponse.swift
//  MarvelAPI
//
//  Created by David Alarcon on 26/09/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import Foundation

public struct MarvelResponse<Response: Decodable>: Decodable {
    public let status: String?
    public let message: String?
    public let data: DataContainer<Response>?
}
