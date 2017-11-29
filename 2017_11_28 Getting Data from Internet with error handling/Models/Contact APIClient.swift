//
//  Contact APIClient.swift
//  2017_11_28 Getting Data from Internet with error handling
//
//  Created by C4Q on 11/28/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation
struct ContactAPIClient {
    private init() {}
    static let manager = ContactAPIClient()
    func getContacts(from urlStr: String, completionHandler: @escaping ([Contact]) -> Void, errorHandler: @escaping (AppError) -> Void) {
        guard let url = URL(string: urlStr) else {
            errorHandler(.badURL)
            return
        }
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let results = try JSONDecoder().decode(Results.self, from: data)
                completionHandler(results.results)
            }
            catch {
                errorHandler(.couldNotParseJSON(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: {print($0)})
    }
}
