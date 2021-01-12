//
//  SongController.swift
//  Playlist
//
//  Created by Lee McCormick on 1/11/21.
//

// This class SongController is going to controller class Song.

import Foundation

class SongController {
    
    // To save memory at the same place
    // Shared Instance
    static let shared = SongController() //100
    
    // Source of Truth (S.O.T)
    var songs: [Song] = []
    
    
    // CRUD Methods
    //Create a song and add to songs
    func createSong(newSongtitle: String, newSongartist: String) {
        
        // create a song
        let newSong = Song(title: newSongtitle, artist: newSongartist)
        
        // add it to songs array
        //SongController.shared.songs.append(newSong) >> Why not this ???
        songs.append(newSong)
        
        // save
        saveToPersistenceStore()
        
        
    }
    
    
    //Read >> Go to the network and find data and turn it to the song.
    
    // TODO: - Update
    
    //Delete
    func deleteSong(songToDelete: Song) {
        // First index in the index set or NSNotFound when the index set is empty. Using firstIndex(of: ), Using this has to conform to Equatable
        
        // remove a song from songs array
        
        // firstIndexOf is iterate to array and find the index that match, but if never found the index, return nil
        // using guard to handle if index is nil
        
        guard let index = songs.firstIndex(of: songToDelete) else { return } //if it is nil, it will return and not doing anything from here.
        
        
        songs.remove(at: index)
        
        // save
        
        saveToPersistenceStore()
    }
    
    
        // file URL
        func fileURL() -> URL {
            let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let fileURL = urls[0].appendingPathComponent("Playlist.json")
            return fileURL
        }
        
        // save
        func saveToPersistenceStore() {
            do {
            // need to add Encodable on Song class
            let data = try JSONEncoder().encode(songs)
                try data.write(to: fileURL())
            } catch { //automatic catch error
                print(error)
                print(error.localizedDescription)
            }
        }
        
        // load
        
        func loadFromPersistanceStore() {
            do {
                let data = try Data(contentsOf: fileURL())
                // always put .self 
                let songs = try JSONDecoder().decode([Song].self, from: data)
                //songs = foundSongs
            } catch {
                print(error)
                print(error.localizedDescription)
            }
        }
        
        
        // mark persistance
    }
    
    


/*
 // This song1 and song2 are not the same, not saving the same place on the memory
 
 let song1 = SongController()
 song1.songs.append(Song(title: "Fix You", artist: "Coldplay"))
 
 let song2 = SongController()
 
 
 
 How to use "Shared" Instance
 // shared instance and singaton are not the same. Shared instant are part of singaton
 
 // This is the shared instance creating the place in the memory and save in the same place and put out the same shared data or file.
 
 
 let song1 = SongController.shared
 song1.songs.append(Song(title: "Fix You", artist: "Coldplay"))
 
 let song2 = SongController.shared
 
 
 
 */
