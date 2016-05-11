//
//  Player.swift
//  eloRatingSystem
//
//  Created by Christopher Stromberg on 5/5/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import UIKit
import Foundation


class Player: NSObject {
    
    var name: String = " "
    var eloRating: Float = 1500.0
    var rank: Int = 0
    var wins: Int = 0
    var losses: Int = 0
    var draws: Int = 0
    var incompletes: Int = 0
    var matchRecord : [String] = [" "]
    
    init (name: String) {
        self.name = name
    }
    
    
    
}