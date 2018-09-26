//
//  APIRequest.swift
//  MarvelAPI
//
//  Created by David Alarcon on 26/09/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import Foundation

protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    var path: String { get }
}
