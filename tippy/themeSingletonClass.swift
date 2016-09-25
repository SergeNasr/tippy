//
//  themeSingletonClass.swift
//  tippy
//
//  Created by Serge Nasr on 2016-09-18.
//  Copyright © 2016 Serge Nasr. All rights reserved.
//

import UIKit

private let myTheme = themeSingletonClass(theme: "DARK")
class themeSingletonClass: NSObject {
    var theme = "DARK"
    
    private init(theme : String) {
        self.theme = theme
    }

    class var themeInstance : themeSingletonClass {
        return myTheme
    }
}
