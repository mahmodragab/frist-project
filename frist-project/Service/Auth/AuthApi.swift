//
//  AuthApi.swift
//  frist-project
//
//  Created by abdallah ragab on 29/09/2022.
//

import Moya

enum AuthApi  {
    case login(model: LoginUserModel)
    case Register(model: CreateUserModel)

}


extension AuthApi : TargetType {
    var baseURL: URL {
         return URL(string: "https://85ffc431-51c7-4d44-a4d8-8edd2cd3398f.mock.pstmn.io")!
    }
    
    var path: String {
        switch self {
        case .login:
            return  "/login"
        case .Register:
            return "/register"
        }
    }
    
    var method: Method {
        switch self  {
        case .login:
            return .post
        case .Register:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .login(let model):
            return  .requestJSONEncodable(model)
        case .Register(let model):
//            return  .requestJSONEncodable(model)
            return .requestParameters(parameters: model.dictionary ?? [:], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return  [:]
    }
    
    
}


