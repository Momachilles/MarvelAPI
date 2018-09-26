//
//  MarvelError.swift
//  MarvelAPI
//
//  Created by David Alarcon on 26/09/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import Foundation

public enum MarvelError: Error {
    case encoding
    case decoding
    case url
    case noData
    case server(message: String)
}
