//
//  Request.swift
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

/// Network request.
public protocol Request {

    /// Destination URL.
    var url: String { get }
    /// HTTP method.
    var method: HTTPMethod { get }
    /// Header fields.
    var headerFields: [String: String]? { get }
    /// URL queries.
    var queries: [String: String]? { get }
    /// Request body.
    var body: Data? { get }
}

// MARK: - Default value
public extension Request {

    /// Header fields default nil.
    var headerFields: [String: String]? {
        return nil
    }
    /// Queries default nil.
    var queries: [String: String]? {
        return nil
    }
    /// Request body default nil.
    var body: Data? {
        return nil
    }
}
