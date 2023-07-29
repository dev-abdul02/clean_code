//
//  NetworkError.swift
//  CleanCode
//
//  Created by abdul karim on 29/07/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}
