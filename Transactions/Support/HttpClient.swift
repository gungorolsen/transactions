//
//  HttpClient.swift
//  Transactions
//
//  Created by Olsen Gungor on 02/12/2022.
//

import Foundation

enum HttpError: Error {
    case invalidResponse
    case failure(code: Int)
    case invalidURL(url: String)
}

protocol HTTPClientType {
    func dataTaskPublisher<T: Decodable>(urlString: String) async throws -> T
}

class HTTPClient: HTTPClientType {
    
    private let urlSessionProvider: URLSessionProviding
    
    init(urlSessionProvider: URLSessionProviding = URLSessionProvider()) {
        self.urlSessionProvider = urlSessionProvider
    }
    
    func dataTaskPublisher<T: Decodable>(urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw HttpError.invalidURL(url: urlString)
        }
    
        let (data, response) = try await urlSessionProvider.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw HttpError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw HttpError.failure(code: httpResponse.statusCode)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}

protocol URLSessionProviding {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

class URLSessionProvider: URLSessionProviding {
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        try await URLSession.shared.data(from: url)
    }
}

class MockURLSessionProvider: URLSessionProviding {
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        try await Task.sleep(seconds: 2)
        guard let mockData = Bundle(for: type(of: self)).jsonData(forResource: "exercise"),
              let mockResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) else {
            throw HttpError.invalidResponse
        }
        return (mockData, mockResponse)
    }
}

private extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}

private extension Bundle {
    func jsonData(forResource resource: String) -> Data? {
        guard let url = url(forResource: resource, withExtension: "json") else {
            return nil
        }
        return try? Data(contentsOf: url)
    }
}
