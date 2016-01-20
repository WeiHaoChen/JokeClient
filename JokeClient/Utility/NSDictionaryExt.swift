//
//  NSDictionaryExt.swift
//  JokeClient
//
//  Created by 陈伟浩 on 16/1/15.
//  Copyright © 2016年 陈伟浩. All rights reserved.
//

import UIKit
import Foundation
extension NSDictionary {
    
    
    func stringAttributeForKey(key:String)->String
    {
        //println(self[key])
        
        let obj:AnyObject?  = self[key]
        //if obj as! NSObject == NSNull()
        if let _ = obj as? NSObject
        {
            //return ""
        } else {
            return ""
        }
        if obj!.isKindOfClass(NSNumber)
        {
            let num = obj as! NSNumber
            return num.stringValue
        }
        if let _ = obj as? String
        {
            return obj as! String
        }
        return ""
    }
    
}
