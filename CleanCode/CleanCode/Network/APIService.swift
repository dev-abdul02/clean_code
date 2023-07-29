//
//  APIService.swift
//  CleanCode
//
//  Created by abdul karim on 29/07/23.
//

import Foundation

class APIService {
    
     class func request<T: Decodable>(router: APIRouter) async throws -> T {
        guard let url = URL(string: APIConstants.baseURL + router.path) else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = router.method
        request.allHTTPHeaderFields = router.headers

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw error
        }
    }
    
}
