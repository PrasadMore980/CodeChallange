//
//  Constants.swift
//  TelstraCodeExercise
//
//  Created by Prasad More on 12/02/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import Foundation
import UIKit


enum Url {
    static let baseUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
}
//TableView cell heights
enum Height {
    static let infoTableCellEstimated: CGFloat = 100
    static let infoTableCellMinimum: CGFloat = 100
}

enum ImageSize {
    static let width = 70.0
    static let height = 70.0
}
enum Paddings {
    static let LeadTop: CGFloat = 10
    static let TrailBottom: CGFloat = -20
}

//MARK:- NetworkError Messages
enum NetworkErrors: Error {
    static let network = "No Internet connection."
    static let fetch = "An error occurred while fetching data."
}

//MARK:- Response: Success or Failure
enum Result<T> {
    case success(T)
    case failure(String)
}
