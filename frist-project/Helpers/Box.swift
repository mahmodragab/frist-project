//
//  Box.swift
//  notes
//
//  Created by Khaled on 9/28/17.
//  Copyright © 2017 codex. All rights reserved.
//

import Foundation

class Box<T> {
    
    typealias Listener = (T) -> Void
    var Listener:Listener?
    
    var value:T {
        didSet{
            self.Listener?(value)
        }
    }
    
    init(value:T) {
        self.value = value
    }
    
    func bind(listener:Listener?) {
        self.Listener = listener
    }
    
    func bindAndFire(listener:Listener?) {
        self.Listener = listener
        self.Listener!(value)
    }
    
}
