//
//  AuthServiceManager.swift
//  frist-project
//
//  Created by abdallah ragab on 29/09/2022.
//

import Foundation
import Moya

class AuthServiceManager: NSObject {
    static let shared = AuthServiceManager()
    private let provider = MoyaProvider<AuthApi>(plugins: [NetworkLoggerPlugin()])

    func login(model: LoginUserModel, completion: @escaping (UserInfo?) -> Void) {
        provider.request(.login(model: model)) { result in
            switch result {
            case .success(let response):
                //MARK: can save user info here
                do {
                    let result = try JSONDecoder().decode(UserInfo.self, from: response.data)
                    completion(result)
                } catch let err {
                    print(err)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func Register(model: CreateUserModel, completion: @escaping (String) -> Void) {
        provider.request(.Register(model: model)) { result in
            switch result {
            case .success(let response):
                do {
                    let result = try JSONDecoder().decode(CreateAccountResponse.self, from: response.data)
                    completion(result.message)
                } catch let err {
                    print(err)
                }
            case .failure(let error):
                print(error)
            }
        }

    }
}
