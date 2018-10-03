//
//  Result.swift
//  MarvelAPI
//
//  Created by David Alarcon on 26/09/2018.
//  Copyright © 2018 David Alarcon. All rights reserved.
//

import Foundation
import Result

public enum Result<Value, MarvelError> {
    case success(Value)
    case failure(MarvelError)
 }

public typealias ResultCallback<Value, MarvelError> = (Result<Value, MarvelError>) -> Void
