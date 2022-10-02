//
//  MainViewModel.swift
//  frist-project
//
//  Created by abdallah ragab on 29/08/2022.
//

import Foundation

class MainViewModel {

    var postsResponse = Box<[Info]?>(value: nil)
    var statusResponse = Box<[Status]?>(value: nil)

    func convertDateFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: date) else {
            return ""
        }
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        let timeStamp = dateFormatter.string(from: date)

        return timeStamp
    }

    func posts() {
        AuthManagerForPosts.shared.Posts { info in
            self.postsResponse.value = info
        }
    }
    
    func status() {
        AuthManagerForPosts.shared.status { status in
            self.statusResponse.value = status
        }
    }
}
