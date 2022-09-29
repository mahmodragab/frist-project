//
//  Localizer.swift
//  Tarleem
//
//  Created by Khaled on 5/1/17.
//  Copyright © 2017 khalid. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    class func isRTL() -> Bool{
        return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }
    
    var customuserInterface:UIUserInterfaceLayoutDirection{
        get{
            var direction = UIUserInterfaceLayoutDirection.leftToRight
            if  LanguageManager.currentLanguage() != "en" {
                direction = UIUserInterfaceLayoutDirection.rightToLeft
            }
            return direction
        }
    }
    
}
class Localizer {
    class func DoLangaueExchange(){
        swilizeLocalizedMethod(Bundle.self, originalSelector: #selector(Bundle.localizedString),
                               overrideSelector: #selector(Bundle.customLocalizedStringForKey(_:value:table:)))

    }
}

extension Bundle{
    @objc func customLocalizedStringForKey(_ key:String ,value:String?,table tableName:String)->String{
        let currentLanguage = LanguageManager.currentLanguage()
        var bundel = Bundle()
        if let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj"){
            bundel = Bundle(path: path)!
        }
        else{
            let path  = Bundle.main.path(forResource: "Base", ofType: "lproj")
            bundel = Bundle(path: path!)!
        }

        return bundel.customLocalizedStringForKey(key, value: value, table: tableName)
    }
}

func swilizeLocalizedMethod(_ className:AnyClass,originalSelector:Selector,overrideSelector:Selector){
    let originalMethod:Method =  class_getInstanceMethod(className,originalSelector)!
    let overrideMethod :Method = class_getInstanceMethod(className, overrideSelector)!
    
    if class_addMethod(className, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod)){
        class_replaceMethod(className, overrideSelector,method_getImplementation(originalMethod) , method_getTypeEncoding(originalMethod))
    }
    else{
        method_exchangeImplementations(originalMethod, overrideMethod)
    }

}
