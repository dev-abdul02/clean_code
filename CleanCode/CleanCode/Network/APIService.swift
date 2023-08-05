//
//  APIService.swift
//  CleanCode
//
//  Created by abdul karim on 29/07/23.
//

import Foundation

class APIService {
    // Replace this with your actual API endpoint URL

    // Fetch items from the API using async/await
    func fetchPost(router:APIRouter) async throws -> Data {
        guard let url = URL(string: APIConstants.baseURL + router.path) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = router.method
        request.allHTTPHeaderFields = router.headers
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return data
        }
        catch {
            throw NetworkError.requestFailed(error)
        }
    }
}
