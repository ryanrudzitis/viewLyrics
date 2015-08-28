//
//  URLBrain.swift
//  viewLyrics
//
//  Created by Ryan Rudzitis on 2015-08-26.
//  Copyright (c) 2015 Ryan Rudzitis. All rights reserved.
//

import Foundation

class URLBrain {
    func encodeString(stringToEncode: String) -> String {
    
        let encodedString = stringToEncode.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        return encodedString!
    }
    
    func getURL(serviceName: String, songName: String, artistName: String) -> String {
        
        let cleanedTitle = cleanString(songName)
        
        let encodedTitle = encodeString(cleanedTitle)
        let encodedArtist = encodeString(artistName)
        
        let songInfo = "\(encodedTitle)%20\(encodedArtist)"
        
        switch serviceName {
            case "Rap Genius":
                return "http://google.com/search?btnI=1&q=rap+genius%20\(songInfo)"
            case "Who Sampled":
                return "http://www.whosampled.com/search/?q=\(songInfo)"
            default:
            return ""
        }
    }
    
    func cleanString(stringToClean: String) -> String {
        var newString = stringToClean // just copy string
        var i = 0
        
        for index in stringToClean.characters.indices {
            
            if stringToClean[index] == "(" {
                print("chopping off (")
                //let range = stringToClean.startIndex.advancedBy(i)..<stringToClean.endIndex
                //newString.removeRange(range)
                break
            } else { i++ }
        }
        
        if newString[newString.endIndex.predecessor()] == " " {
            print("chopping off space")
            newString.removeAtIndex(newString.endIndex.predecessor())
        }
        
        print("brand new cleaned title: \(newString)")
        return newString
    }
}

