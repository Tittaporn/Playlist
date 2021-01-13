//
//  SongListTableViewController.swift
//  Playlist
//
//  Created by Lee McCormick on 1/11/21.
//

import UIKit

class SongListTableViewController: UITableViewController {
    
    //Mark: - Outlets
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    
    //Mark: - Properties
    //create a landing path from prepare on PlaylistViewController
    var playlist: Playlist?
    
    //Mark: - Liftcycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //Mark: - Actions
    
    
    @IBAction func addSongButtonTapped(_ sender: UIBarButtonItem) {
        
        // SongController.createSong(newSongtitle: <#T##String#>, newSongartist: <#T##String#>) >> This won't work because no static that why we are using shared.
        
        
        // using guard to check if textfileds are not nil with multiple guards
        guard let songTitle = songTitleTextField.text, !songTitle.isEmpty,
              let artistName = artistNameTextField.text, !artistName.isEmpty,
              let playlist = playlist //add playlist to guard
        else { return}
        
        SongController.createSong(newSongtitle: songTitle, newSongArtist: artistName, playlist: playlist)
        
        
        //SongController.createSong(newSongtitle: songTitle, newSongartist: artistName)
        
        //telling our tableView to reload data
        tableView.reloadData()
        songTitleTextField.text = ""
        artistNameTextField.text = ""
        
        // pull the keyborad back out the screen after done with the textField
        songTitleTextField.resignFirstResponder()
        artistNameTextField.resignFirstResponder()
    }
    
    // Mark: - Helper Fuction
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       // return PlaylistController.shared.playlists.songs.count
        return playlist?.songs.count ?? 0 //upwrap with nil coalescing operator
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        
        // This is find index of each song `[indexPath.row]` that is going to display
        //let song = SongController.shared.songs[indexPath.row]
        guard let song = playlist?.songs[indexPath.row] else {return cell}

        // Configure the cell...
        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.artist
        /*
         // Configure the cell... with Mock Data
         cell.textLabel?.text = "Song Title"
         cell.detailTextLabel?.text = "Artist Name"
         */
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let playlist = playlist else {return}
            let songToDelete = playlist.songs[indexPath.row]
            SongController.deleteSong(songToDelete: songToDelete, playlist: playlist)
            tableView.deleteRows(at: [indexPath], with: .fade)
            // No tableView.reloadDate() because automaticlly reloaded.
            
            
           /*
            // Delete the row from the data source
            let songToDelete = SongController.shared.songs[indexPath.row]
            SongController.shared.deleteSong(songToDelete: songToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
            // No tableView.reloadDate() because automaticlly reloaded.
            */
        }
    }
} //End of class >> to remind you not to delete this

/*
 https://www.hackingwithswift.com/example-code/language/what-is-the-nil-coalescing-operator
 
 */
