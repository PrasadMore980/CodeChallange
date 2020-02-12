//
//  CellIdentifier.swift
//  TelstraCodeExercise
//
//  Created by Prasad More on 12/02/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import Foundation
import UIKit

protocol Identifier { }
// to avoide using of hardcoded tableCell name
extension Identifier where Self: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
extension UITableViewCell: Identifier {}
