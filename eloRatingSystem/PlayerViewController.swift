//
//  PlayerViewController.swift
//  eloRatingSystem
//
//  Created by Christopher Stromberg on 5/9/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import UIKit

class PlayersViewController: UITableViewController {
    var playerStore: PlayerStore!
    
    
    
    @IBAction func addNewPlayer(sender: AnyObject) {
//        // Make a new index path for the 0th section, last row
//        let lastRow = tableView.numberOfRowsInSection(0)
//        let indexPath = NSIndexPath(forRow: lastRow, inSection: 0)
        
        // Create new player and add it to the store
        let newPlayer = playerStore.createPlayer()
        
        // Figure out where this player is in array
        if let index = playerStore.allPlayers.indexOf(newPlayer) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
        
        // Insert this new row into the table
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    @IBAction func toggleEditingMode(sender: AnyObject) {
        // If you are currently in editing mode....
        if editing {
            // Change text of button to inform user of state
            sender.setTitle("Edit", forState: .Normal)
            
            // Turn off editing mode
            setEditing(false, animated: true)
            
        } else {
            // Change test of button to inform user of state
            sender.setTitle("Done", forState: .Normal)
            
            // Enter editing mode
            setEditing(true, animated: true)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the height of the status bar
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerStore.allPlayers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Create an instance of UITableviewCell, with default appearance
        //let cell = UITableViewCell(style: .Value1, reuseIdentifier: "PlayerUITableViewCell")
        
        // Get a new or recylced cell
        let cell = tableView.dequeueReusableCellWithIdentifier("PlayerUITableViewCell", forIndexPath: indexPath)
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        
        let player = playerStore.allPlayers[indexPath.row]
        
        cell.textLabel?.text = player.name
        cell.detailTextLabel?.text = "Elo Rating \(player.eloRating)"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // If the table view is asking to commit a delete command....
        if editingStyle == .Delete {
            let player = playerStore.allPlayers[indexPath.row]
            // Remove the item from the store
            playerStore.removePlayer(player)
            
            // Also remove that row from the table view with an animation
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        // Update the model
        playerStore.movePlayerAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
}
