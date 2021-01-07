//
//  NetworkProvider.swift
//  TiaIosInterview
//
//  Created by Leo Tsuchiya on 1/4/21.
//

import Foundation

/// Utility class to provide network requests
/// https://dog.ceo/dog-api/documentation/
class NetworkProvider {

    static func getRandomDogUrl(breed: String?, completion: ((URL) -> Void)?) {

        let url: URL
        if let breed = breed {
            url = URL(string: "https://dog.ceo/api/breed/\(breed)/images/random")!
        } else {
            url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        }

        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data,
                  let getResponse = try? JSONDecoder().decode(RandomDogGetResponse.self, from: data),
                  let url = URL(string: getResponse.message) else {
                return
            }

            completion?(url)
        }).resume()
    }

    static func getBreedList(completion: (([String]) -> Void)?) {

        guard let url = URL(string: "https://dog.ceo/api/breeds/list/all") else {
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data,
                  let getResponse = try? JSONDecoder().decode(BreedListResponse.self, from: data) else {
                return
            }

            // Simulate bad network, don't remove this code
            if Bool.random() {
                completion?(getResponse.message)
            }
        }).resume()
    }
}
