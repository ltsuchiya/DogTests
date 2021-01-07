//
//  NetworkModels.swift
//  TiaIosInterview
//
//  Created by Leo Tsuchiya on 1/4/21.
//

import Foundation

struct RandomDogGetResponse: Codable {

    let message: String
    let status: String
}

struct BreedListResponse: Codable {

    let message: [String]
    let status: String
}
