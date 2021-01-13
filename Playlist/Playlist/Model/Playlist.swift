//
//  Playlist.swift
//  Playlist
//
//  Created by Lee McCormick on 1/12/21.
//

import Foundation

class Playlist: Codable {

    let title: String
    var songs: [Song] //From the type of Song that we created `class Song in Model` >> we are going to modify the song, so we use variable
    // let uuid >> can use to identify if each Playlist is different
    
    init(title: String, songs: [Song] = []) { //[Song] = [] we init by [] because if song start with 0 song. We don't need to input the song, only need title of Playlist
        self.title = title
        self.songs = songs
    }
}

extension Playlist: Equatable { //Equatable to help us use the firstOfIndex() to delete the playlist
    static func == (lhs: Playlist, rhs: Playlist) -> Bool {
        // I think if we created the timestamp with Date() default on Playlist properties to compare lhs and rhs. We can use uuid >> the id of each value of Playlist
        return lhs.title == rhs.title && lhs.songs == rhs.songs
    }
    
    
}
