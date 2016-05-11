//
//  PlayerStore.swift
//  eloRatingSystem
//
//  Created by Christopher Stromberg on 5/7/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import UIKit

class PlayerStore {
    var allPlayers = [Player]()
    
    func createPlayer() -> Player {
        let newPlayer = Player(name: "New Player")
        
        allPlayers.append(newPlayer)
        
        return newPlayer
    }
	
	func rankOrder(players: [Player]) {
		for playerEloRating in players {
			print(playerEloRating.eloRating)
		}
	}
    
    // Method to remove a specific player from index using tableview deletion
    func removePlayer(player: Player) {
        if let index = allPlayers.indexOf(player) {
            allPlayers.removeAtIndex(index)
        }
    }
    
    // Method to move rows within a tableview
    func movePlayerAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // Get reference to object being moved so you can reinsert it
        let movedPlayer = allPlayers[fromIndex]
        
        // Remove player from array
        allPlayers.removeAtIndex(fromIndex)
        
        // Insert player in array at new location
        allPlayers.insert(movedPlayer, atIndex: toIndex)
    }
    
    
    
    
//    init() {
//        for _ in 0..<6 {
//            createPlayer()
//        }
//    }
    
    
    
}
