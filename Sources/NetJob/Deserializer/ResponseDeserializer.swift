//
//  ResponseDeserializer.swift
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

/// Response deserializer.
public protocol ResponseDeserializer {

    associatedtype T: Decodable
    associatedtype E: Decodable

    /// Deserialize success data.
    ///
    /// - Parameter data: Success data.
    /// - Returns: Decoded data object.
    /// - Throws: Deserialization error.
    func deserializeSuccessData(_ data: Data) throws -> T
    /// Deserialize failure data.
    ///
    /// - Parameter data: Failure data.
    /// - Returns: Decoded data object.
    /// - Throws: Deserialization error.
    func deserializeFailureData(_ data: Data) throws -> E

    /// Deserialize result data.
    ///
    /// - Parameter result: Result to be deserialized.
    /// - Returns: Deserialized result.
    func deserialize(_ result: Result) -> DeserializedResult<T, E>
}

public extension ResponseDeserializer {

    public func deserialize(_ result: Result) -> DeserializedResult<T, E> {
        switch result {
        case .success(let response):
            if let data = response.data {
                do {
                    return .success(try deserializeSuccessData(data))
                } catch {
                    return .failure(.error(error))
                }
            } else {
                return .success(nil)
            }
        case .canceled:
            return .canceled
        case .failure(let errorResponse):
            switch errorResponse {
            case .invalidURL:
                return .failure(.invalidURL)
            case .error(let error):
                return .failure(.error(error))
            case .noResponse:
                return .failure(.noResponse)
            case .requestFailed(let errorResponse):
                if let data = errorResponse.data {
                    do {
                        return .failure(.requestFailed(DeserializedResponse<E>(
                            statusCode: errorResponse.statusCode,
                            headerFields: errorResponse.headerFields,
                            data: try deserializeFailureData(data)))
                        )
                    } catch {
                        return .failure(.error(error))
                    }
                } else {
                    return .failure(.requestFailed(DeserializedResponse<E>(
                        statusCode: errorResponse.statusCode,
                        headerFields: errorResponse.headerFields,
                        data: nil))
                    )
                }
            }
        }
    }
}
