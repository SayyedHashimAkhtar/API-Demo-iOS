//
//  Globals.swift
//  PostCodeLookUp
//
//  Created by Hashim Akhtar on 06/07/2022.
//

import UIKit

class Globals {
    
    static func getAppDatabase() -> SqliteDatabase {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.sqliteDatabase!
    }
    
    static func getRootViewController() -> UIViewController {
        let rootViewController = UIApplication.shared.windows.last!.rootViewController
        return rootViewController!
    }
    
}
