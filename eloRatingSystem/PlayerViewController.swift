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
    
//Mark : Add Remove Edit Player entries
    
    @IBAction func addNewPlayer(sender: AnyObject) {
        // Make a new index path for the 0th section, last row
		// let lastRow = tableView.numberOfRowsInSection(0)
		// let indexPath = NSIndexPath(forRow: lastRow, inSection: 0)
        
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
        
        // Get the height of the status bar to keep the tableview display below.
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
		
		// Needed to add this to get row height correct
		//tableView.rowHeight = UITableViewAutomaticDimension
		tableView.rowHeight = 65
		
		
		    }
    
    
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		// Update table view with return made in Nav controller
		tableView.reloadData()
	}
//Mark : TableView Data Source and Delegate
	
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerStore.allPlayers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Create an instance of UITableviewCell, with default appearance
        //let cell = UITableViewCell(style: .Value1, reuseIdentifier: "PlayerUITableViewCell")
        
        // Get a new or recylced cell
		// let cell = tableView.dequeueReusableCellWithIdentifier("PlayerUITableViewCell", forIndexPath: indexPath)
		
		let cell = tableView.dequeueReusableCellWithIdentifier("PlayerUITableViewCell", forIndexPath: indexPath) as! PlayerCell
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        
        let player = playerStore.allPlayers[indexPath.row]
		
		// No longer used because we are using custom PlayerCell class to display cells.
		// cell.textLabel?.text = player.name
		// cell.detailTextLabel?.text = "Elo Rating \(player.eloRating)"
		
		// Configure the cell to worth with custom playercell class
		cell.playerEloRatingLabel.text = "\(player.eloRating)"
		cell.playerNameLabel.text = player.name
		cell.playerRankLabel.text = "Current rank \(player.rank)"
		
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // If the table view is asking to commit a delete command....
        if editingStyle == .Delete {
            let player = playerStore.allPlayers[indexPath.row]
			
			// Display User Alert before deleting player entry.
			let title = "Delete \(player.name)?"
			let message = "Are you sure you want to delete this Player?"
			
			let ac = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
			
			let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
			ac.addAction(cancelAction)
			
			let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: {
				(action) -> Void in
				
				// Remove the item from the store
				self.playerStore.removePlayer(player)
				
				// Also remove that row from the table view with an animation
				self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
			})
			ac.addAction(deleteAction)
			
			// Present the alert view controller!!!
			presentViewController(ac, animated: true, completion: nil)
			
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        // Update the model
        playerStore.movePlayerAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
	
	
	
	//Mark: Segue for player detail view
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		//If the triggered segue is the "ShowPlayerDetail" segue
		
		if segue.identifier == "ShowPlayerDetail" {
			
			// Figure out which row was just tapped
			if let row = tableView.indexPathForSelectedRow?.row {
				
				// Get the player associated with this row and pass it along
				let player = playerStore.allPlayers[row]
				let playerDetailViewController = segue.destinationViewController as! PlayerDetailViewController
				playerDetailViewController.player = player
				}
			}
		}
	
	
}
