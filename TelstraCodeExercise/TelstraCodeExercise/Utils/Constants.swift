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

enum Height {
    static let infoTableCellEstimated: CGFloat = 100
    static let infoTableCellMinimum: CGFloat = 100
}

//MARK:- Response: Success or Failure
enum Result<T> {
    case success(T)
    case failure(String)
}
