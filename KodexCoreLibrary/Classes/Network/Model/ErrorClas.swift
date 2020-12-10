//
//  ErrorClas.swift
//  CLEAQUES
//
//  Created by Namxu Ihseruq on 15/10/2020.
//

import Foundation

struct ErrorHandleDatum : Codable {
    
    let email : [String]?
    let phone : [String]?
    let description: [String]?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case phone = "phone"
        case description = "description"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        email = try values.decodeIfPresent([String].self, forKey: .email)
        phone = try values.decodeIfPresent([String].self, forKey: .phone)
        description = try values.decodeIfPresent([String].self, forKey: .description)
    }
    
}
