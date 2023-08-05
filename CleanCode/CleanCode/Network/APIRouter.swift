//
//  Router.swift
//  CleanCode
//
//  Created by abdul karim on 29/07/23.
//

import Foundation

enum APIRouter {
    case fetchPost
}

extension APIRouter  {
    var path : String {
        switch self {
        case .fetchPost:
            return "/posts"
        }
    }
    
    var method:String {
        switch self {
        case .fetchPost:
            return "GET"
        }
    }
    
    var headers:[String : String]? {
        return nil
    }
    
    var parameters:[String: Any]? {
        return nil
    }
    
    func body() throws -> Data? {
        return nil
    }
}
