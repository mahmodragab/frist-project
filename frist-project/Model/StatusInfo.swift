//
//  StatusInfo.swift
//  frist-project
//
//  Created by abdallah ragab on 21/08/2022.
//

import Foundation

// MARK: - StatusInfo
struct StatusInfo: Codable {
    let data: [Status]?
}

// MARK: - Status
struct Status: Codable {
    let userFullname: String?
    let img: String?

    enum CodingKeys: String, CodingKey {
        case userFullname = "user_fullname"
        case img
    }
}
