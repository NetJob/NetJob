//
//  NetworkClient.swift
//  NetJob
//
//  Copyright (c) 2018 Jason Nam (https://jasonnam.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

/// Network client.
public protocol NetworkClient {

    /// Request adapter. Process request before execute.
    var requestAdapter: ((URLRequest) -> URLRequest)? { get set }
    /// Network interactor executing task.
    var networkInteractor: NetworkInteractor { get set }

    /// Execute network request.
    ///
    /// - Parameters:
    ///   - request: Target request.
    ///   - completionHandler: Completion handler.
    /// - Returns: URLSessionDataTask for request.
    func request(_ request: Request, completionHandler: @escaping (Result) -> ()) -> URLSessionDataTask?
}

// MARK: - Default implementation.
public extension NetworkClient {

    func request(_ request: Request, completionHandler: @escaping (Result) -> ()) -> URLSessionDataTask? {
        // Convert end point to URLComponents.
        guard let endPointURL = URL(string: request.url),
            var endPoint = URLComponents(url: endPointURL, resolvingAgainstBaseURL: false) else {
            completionHandler(.failure(.invalidURL))
            return nil
        }

        // Queries.
        var queryItems: [URLQueryItem] = []
        for query in request.queries ?? [:] {
            queryItems.append(URLQueryItem(name: query.key, value: query.value))
        }
        endPoint.queryItems = queryItems

        // Setup URL request.
        guard let url = endPoint.url else {
            completionHandler(.failure(.invalidURL))
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headerFields
        urlRequest.httpBody = request.body

        // Request adapter.
        if let requestAdapter = requestAdapter {
            urlRequest = requestAdapter(urlRequest)
        }

        return networkInteractor.request(urlRequest) { data, urlResponse, error in
            if let error = error {
                completionHandler(.failure(.error(error)))
                return
            }
            guard let urlResponse = urlResponse as? HTTPURLResponse else {
                completionHandler(.failure(.noResponse))
                return
            }
            let response = Response(statusCode: urlResponse.statusCode,
                                    headerFields: urlResponse.allHeaderFields,
                                    data: data)
            switch response.statusCode {
            case 200..<300:
                completionHandler(.success(response))
            case -999:
                completionHandler(.canceled)
            default:
                completionHandler(.failure(.requestFailed(response)))
            }
        }
    }
}
