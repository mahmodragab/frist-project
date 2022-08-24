//
//  CreateAccountResponse.swift
//  frist-project
//
//  Created by abdallah ragab on 14/08/2022.
//

import UIKit

struct CreateAccountResponse: Codable {
    let message: String
    let statusCode: Int

    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case statusCode = "StatusCode"
    }
}
