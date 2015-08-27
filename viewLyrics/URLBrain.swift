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
    
        let betterString = stringToEncode.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        return betterString!
    }
    
    func getURL(serviceName: String, songTitle: String, artistName: String) -> String {
        
        var newTitle = songTitle
        var i = 0
        
            for index in newTitle.characters.indices {
            //print(songTitle[index])
            //print(index)
                
            if songTitle[index] == "(" {
                
                let range = songTitle.startIndex.advancedBy(i)..<songTitle.endIndex
                newTitle.removeRange(range)
                break
            } else {
                i++
                }
        }
        
            print("this is new title \(newTitle)")
            
            
            
            
            //let index = songTitle.startIndex.advancedBy(3)
            //print(songTitle[index])
        
        
        
        let encodedTitle = encodeString(newTitle)
        let encodedArtist = encodeString(artistName)
        
        if serviceName == "Rap Genius" {
            return "http://google.com/search?btnI=1&q=rap+genius+" + encodedTitle + encodedArtist
        } else if serviceName == "Who Sampled" {
            return "http://www.whosampled.com/search/?q=" + encodedTitle + encodedArtist
        } else {
            return ""
        }
        
    }
}

