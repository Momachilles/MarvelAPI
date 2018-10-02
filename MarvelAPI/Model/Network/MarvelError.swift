//
//  MarvelError.swift
//  MarvelAPI
//
//  Created by David Alarcon on 26/09/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import Foundation
import Result

public enum MarvelError: Error {
    
    case encoding
    case decoding
    case url
    case noData
    case timeout
    case generic
    case server(message: String)
}
