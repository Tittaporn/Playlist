//
//  PlayListController.swift
//  Playlist
//
//  Created by Lee McCormick on 1/12/21.
//

import Foundation

class PlaylistController {
    // MARK: - Shared Instance
    static var shared = PlaylistController()
    
    // MARK: - Source Of Truth
    var playlists: [Playlist] = []
    
    // MARK: - CRUD
    // Create
    func createPlaylistWith(title: String)  {
        let newPlaylist = Playlist(title: title)
        playlists.append(newPlaylist)
        saveToPersistenceStore()
    }
    
    // Delete
    func deletePlaylist(playlistToDelete: Playlist)  {
        guard let index = playlists.firstIndex(of: playlistToDelete) else {return}
        playlists.remove(at: index)
        saveToPersistenceStore()
    }
    
    // MARK: - Save and Load From Persistance Store
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
            let data = try JSONEncoder().encode(playlists)
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
            // always put .self >> [Playlist].self
            let foundPlaylist = try JSONDecoder().decode([Playlist].self, from: data)
            playlists = foundPlaylist
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
