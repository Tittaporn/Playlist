//
//  PlaylistViewController.swift
//  Playlist
//
//  Created by Lee McCormick on 1/12/21.
//

import UIKit

class PlaylistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    @IBOutlet weak var playlistTitleTextField: UITextField!
    @IBOutlet weak var playlistTableView: UITableView!
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        playlistTableView.delegate = self
        playlistTableView.dataSource = self
        PlaylistController.shared.loadFromPersistanceStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playlistTableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func createPlaylistButtonTapped(_ sender: Any) {
        guard let title = playlistTitleTextField.text, !title.isEmpty else {return}
        
        //create and save new playlist
        PlaylistController.shared.createPlaylistWith(title: title)
        
        //load data on the table and empty the textfield
        playlistTableView.reloadData()
        playlistTitleTextField.text = ""
    }
    
    // MARK: - UITableViewDataSource >> It comes with UITableViewDataSource protocol.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaylistController.shared.playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playlistTableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)
        
        // set the data of each playlist and configurate cell...
        let playlist = PlaylistController.shared.playlists[indexPath.row]
        cell.textLabel?.text = playlist.title
        // using string interporation to interporate the Int value ("\()")
        cell.detailTextLabel?.text = ("\(playlist.songs.count) songs.")
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // delete the playlist, first compare if we are deleting or inserting
        if editingStyle == .delete {
            
            // find the playlist from indexPath.row
            let playlistToDelete = PlaylistController.shared.playlists[indexPath.row]
            
            // using the fuction on PlaylistController to deletePlaylist
            PlaylistController.shared.deletePlaylist(playlistToDelete: playlistToDelete )
            tableView.deleteRows(at: [indexPath], with: .left)
        }
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // IIDOO
        if segue.identifier == "toSongList" {
            guard let indexPath = playlistTableView.indexPathForSelectedRow else {return}
            guard let destination = segue.destination as? SongListTableViewController else {return}
            let playlistToSend = PlaylistController.shared.playlists[indexPath.row]
            destination.playlist = playlistToSend
        }
    }
    
}

