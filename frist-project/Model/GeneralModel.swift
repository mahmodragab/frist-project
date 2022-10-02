//
//  GeneralModel.swift
//  frist-project
//
//  Created by abdallah ragab on 28/08/2022.
//

import Foundation
import UIKit

enum MultiPartItemType: String {
    case image, file
}

//------------------

struct MultiPartItem {
    var data: Data?
    var url: URL?
    var type: MultiPartItemType
    var keyName: String
    var fileName, mimeType: String?
    
    init(data: Data, fileName: String, mimeType: String, keyName: String, type: MultiPartItemType = .image) {
        self.data = data
        self.fileName = fileName
        self.mimeType = mimeType
        self.keyName = keyName
        self.type = type
    }
    
    init(url: URL, keyName: String, type: MultiPartItemType = .file) {
        self.url = url
        self.type = type
        self.keyName = keyName
    }
}
