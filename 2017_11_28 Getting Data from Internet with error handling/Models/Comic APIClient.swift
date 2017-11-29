//
//  Comic APIClient.swift
//  2017_11_28 Getting Data from Internet with error handling
//
//  Created by C4Q on 11/28/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import Foundation

struct ComicAPIClient {
    private init() {}
    static let manager = ComicAPIClient()
    func getContacts(from urlStr: String, completionHandler: @escaping (Comic) -> Void, errorHandler: @escaping (AppError) -> Void) {
        guard let url = URL(string: urlStr) else {
            errorHandler(.badURL)
            return
        }
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let myComic = try JSONDecoder().decode(Comic.self, from: data)
                completionHandler(myComic)
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
