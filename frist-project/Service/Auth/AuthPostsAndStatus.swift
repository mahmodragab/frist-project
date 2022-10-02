//
//  AuthPostsAnd.swift
//  frist-project
//
//  Created by abdallah ragab on 01/10/2022.
//

import Moya

enum AuthPostsAndStatus  {
    case posts
    case status

}


extension AuthPostsAndStatus : TargetType {
    var baseURL: URL {
        return URL(string: "https://85ffc431-51c7-4d44-a4d8-8edd2cd3398f.mock.pstmn.io")!
    }
    
    var path: String {
        switch self {
        case .posts:
            return  "/posts"
        case .status:
            return "/status"
        }
    }
    
    var method: Method {
        switch self  {
        case .posts:
            return .get
        case .status:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .posts:
            return  .requestPlain
        case .status:
            return  .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .posts:
            return  ["x-mock-response-code": "200"]
        case .status:
            return  ["x-mock-response-code1": "200"]
        }
        
    }
    
    
}
