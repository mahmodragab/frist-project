//
//  AuthManagerForPosts.swift
//  frist-project
//
//  Created by abdallah ragab on 01/10/2022.
//

import Foundation
import Moya

class AuthManagerForPosts: NSObject {
    static let shared = AuthManagerForPosts()
    private let provider = MoyaProvider<AuthPostsAndStatus>(plugins: [NetworkLoggerPlugin()])

    func Posts(completion: @escaping ([Info]?) -> Void) {
        provider.request(.posts) { response in
            switch response {
            case .success(let response):
                do {
                    let result = try JSONDecoder().decode(PostInfo.self, from: response.data)
                    completion(result.data)
                } catch let err {
                    print(err)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func status(completion: @escaping ([Status]?) -> Void) {
        provider.request(.status) { response in
            switch response {
            case .success(let response):
                do {
                    let result = try JSONDecoder().decode(StatusInfo.self, from: response.data)
                    completion(result.data)
                } catch let err {
                    print(err)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}
