//
//  PostInfo.swift
//  frist-project
//
//  Created by abdallah ragab on 19/08/2022.
//

import Foundation

// MARK: - PostInfo
struct PostInfo: Codable {
    let data: [Info]?
}

// MARK: - Datum
struct Info: Codable {
    let fullAddress, date, userFullname: String?
    let img: String?

    enum CodingKeys: String, CodingKey {
        case fullAddress = "full_address"
        case date
        case userFullname = "user_fullname"
        case img
    }
}
