//
//  NetJob.swift
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

/// NetJob network client.
open class NetJob: NetworkClient {

    /// Network interactor executing task.
    public var networkInteractor: NetworkInteractor
    /// Request adapter. Process request before execute.
    public var requestAdapter: ((URLRequest) -> URLRequest)?

    /// Shared instance.
    public static let shared = NetJob()

    /// Initialize NetJob.
    ///
    /// - Parameter networkInteractor: Network interactor executing task.
    public init(networkInteractor: NetworkInteractor = URLSessionNetworkInteractor()) {
        self.networkInteractor = networkInteractor
    }

    /// Execute GET request.
    ///
    /// - Parameters:
    ///   - url: URL.
    ///   - headerFields: Header fields.
    ///   - queries: URL queries.
    ///   - completionHandler: Completion handler.
    /// - Returns: URLSessionDataTask for request.
    public func get(_ url: String,
                    headerFields: [String: String]? = nil,
                    queries: [String: String]? = nil,
                    completionHandler: @escaping (Result) -> ()) -> URLSessionDataTask? {
        return request(Get(url: url, headerFields: headerFields, queries: queries),
                       completionHandler: completionHandler)
    }

    /// Execute POST request.
    ///
    /// - Parameters:
    ///   - url: URL.
    ///   - headerFields: Header fields.
    ///   - queries: URL queries.
    ///   - body: Request body.
    ///   - completionHandler: Completion handler.
    /// - Returns: URLSessionDataTask for request.
    public func post(_ url: String,
                     headerFields: [String: String]? = nil,
                     queries: [String: String]? = nil,
                     body: Data? = nil,
                     completionHandler: @escaping (Result) -> ()) -> URLSessionDataTask? {
        return request(Post(url: url, headerFields: headerFields, queries: queries, body: body),
                       completionHandler: completionHandler)
    }

    /// Execute DELETE request.
    ///
    /// - Parameters:
    ///   - url: URL.
    ///   - headerFields: Header fields.
    ///   - queries: URL queries.
    ///   - body: Request body.
    ///   - completionHandler: Completion handler.
    /// - Returns: URLSessionDataTask for request.
    public func delete(_ url: String,
                       headerFields: [String: String]? = nil,
                       queries: [String: String]? = nil,
                       body: Data? = nil,
                       completionHandler: @escaping (Result) -> ()) -> URLSessionDataTask? {
        return request(Delete(url: url, headerFields: headerFields, queries: queries, body: body),
                       completionHandler: completionHandler)
    }

    /// Execute GET request.
    ///
    /// - Parameters:
    ///   - url: URL.
    ///   - headerFields: Header fields.
    ///   - queries: URL queries.
    ///   - completionHandler: Completion handler.
    /// - Returns: URLSessionDataTask for request.
    public static func get(_ url: String,
                           headerFields: [String: String]? = nil,
                           queries: [String: String]? = nil,
                           completionHandler: @escaping (Result) -> ()) -> URLSessionDataTask? {
        return shared.request(Get(url: url, headerFields: headerFields, queries: queries),
                              completionHandler: completionHandler)
    }

    /// Execute POST request.
    ///
    /// - Parameters:
    ///   - url: URL.
    ///   - headerFields: Header fields.
    ///   - queries: URL queries.
    ///   - body: Request body.
    ///   - completionHandler: Completion handler.
    /// - Returns: URLSessionDataTask for request.
    public static func post(_ url: String,
                            headerFields: [String: String]? = nil,
                            queries: [String: String]? = nil,
                            body: Data? = nil,
                            completionHandler: @escaping (Result) -> ()) -> URLSessionDataTask? {
        return shared.request(Post(url: url, headerFields: headerFields, queries: queries, body: body),
                              completionHandler: completionHandler)
    }

    /// Execute DELETE request.
    ///
    /// - Parameters:
    ///   - url: URL.
    ///   - headerFields: Header fields.
    ///   - queries: URL queries.
    ///   - body: Request body.
    ///   - completionHandler: Completion handler.
    /// - Returns: URLSessionDataTask for request.
    public static func delete(_ url: String,
                              headerFields: [String: String]? = nil,
                              queries: [String: String]? = nil,
                              body: Data? = nil,
                              completionHandler: @escaping (Result) -> ()) -> URLSessionDataTask? {
        return shared.request(Delete(url: url, headerFields: headerFields, queries: queries, body: body),
                              completionHandler: completionHandler)
    }
}
