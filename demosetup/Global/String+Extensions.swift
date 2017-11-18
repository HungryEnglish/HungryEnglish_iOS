//
//  String+Extensions.swift
//
//  Created by : Manoj Maurya
//  Created Date : 05/04/16
//

import Foundation
import UIKit

extension String {
    
    var first: String {
        return String(characters.prefix(1))
    }
    var last: String {
        return String(characters.suffix(1))
    }
    
    var uppercaseFirst: String {
        return first.uppercased() + String(characters.dropFirst())
    }
    
    /**
     :name:	trim
     */
    public func trim() -> String {
        
        return trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    func sizeForWidth(width: CGFloat, font: UIFont) -> CGSize {
        let attr = [NSFontAttributeName: font]
        let height = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options:.usesLineFragmentOrigin, attributes: attr, context: nil).height
        return CGSize(width: width, height: ceil(height))
    }
    
    var lastPathComponent: String {
        
        get
        {
            return (self as NSString).lastPathComponent
        }
        
        
    }
    
    var pathExtension: String
        {
        
        get
        {
            
            return (self as NSString).pathExtension
        }
    }
    
    var stringByDeletingLastPathComponent: String {
        
        get
        {
            
            return (self as NSString).deletingLastPathComponent
        }
    }
    
    var stringByDeletingPathExtension: String {
        
        get
        {
            
            return (self as NSString).deletingPathExtension
        }
    }
    
    var pathComponents: [String] {
        get
        {
            return (self as NSString).pathComponents
        }
    }
    
    func stringByAppendingPathComponent(path: String) -> String
    {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
    
    func stringByAppendingPathExtension(ext: String) -> String?
    {
        let nsSt = self as NSString
        return nsSt.appendingPathExtension(ext)
    }
}

extension UIScrollView {
    var currentPage: Int {
        return Int((self.contentOffset.x + (0.5*self.frame.size.width))/self.frame.width)+1
    }
}
