//
//  Song.swift
//  Playlist
//
//  Created by Lee McCormick on 1/11/21.
//

import Foundation

class Song: Codable { //== Encodable, Decodable {
    
    let title: String
    let artist: String
    
    
    
    init(title: String, artist: String) {
        self.title = title
        self.artist = artist
    }
}

// We use Equatable because we need songs array have firstIndex(of: )
extension Song: Equatable {
    
    // return the index what ever the same song
    static func == (lhs: Song, rhs: Song) -> Bool {
        
        return lhs.title == rhs.title && lhs.artist == rhs.artist
    }
    
    
    
    //lhs = Left hand side
    //rhs = Right hand side >> Song to Delete
    
    /*
     lhs                rhs
     [song1...10]       song7
     // song1           song7
     */
}


/*
 MVC = Modle View Controller.
 */
