//
//  URLBrain.swift
//  viewLyrics
//
//  Created by Ryan Rudzitis on 2015-08-26.
//  Copyright (c) 2015 Ryan Rudzitis. All rights reserved.
//

import Foundation

class URLBrain {
    func encodeTitle(title: String) -> String {
    
        let betterString = title.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        return betterString!
    }
}
