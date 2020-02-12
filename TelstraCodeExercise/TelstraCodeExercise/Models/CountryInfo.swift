//
//  CountryInfo.swift
//  TelstraCodeExercise
//
//  Created by Prasad More on 12/02/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import Foundation

//Service response object
struct CountryInfo: Codable {
    
    var title: String?
    var rows: [Rows]?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case rows = "rows"
    }
    
    init(title: String, rows: [Rows]) {
        self.title = title
        self.rows = rows
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        rows = try values.decodeIfPresent([Rows].self, forKey: .rows)
    }
}

//Individual Array objects
struct Rows: Codable {
    
    var title: String?
    var description: String?
    var imageUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case title, description
        case imageUrl = "imageHref"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
    }
}
