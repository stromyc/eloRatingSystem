//
//  PlayerDetailViewController.swift
//  eloRatingSystem
//
//  Created by Chris Stromberg on 5/11/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import UIKit

class PlayerDetailViewController: UIViewController {
	
	
	
	@IBOutlet var playerNameField: UITextField!
	@IBOutlet var playerEloRatingField: UITextField!
	@IBOutlet var playerRankField: UITextField!
	@IBOutlet var playerWinsField: UITextField!
	@IBOutlet var playerLossesField: UITextField!
	@IBOutlet var playerDrawsField: UITextField!
	@IBOutlet var playerIncompleteField: UITextField!
	
	
	var player: Player!
	
	// Need to format text fields with numbers into strings
	
	enum numberFormat {
		case decimalTwoPlace
		case decimalOnePlace
		case wholeInteger
		
		var numbersFormatter : NSNumberFormatter {
			switch self {
			case .decimalOnePlace : self.numbersFormatter.numberStyle = .DecimalStyle
			self.numbersFormatter.minimumFractionDigits = 1
				self.numbersFormatter.maximumFractionDigits = 1
				return self.numbersFormatter
			}
		}
			
			
		
	}
	
	let numberFormatter: NSNumberFormatter = {
		let formatter = NSNumberFormatter()
		formatter.numberStyle = .DecimalStyle
		formatter.minimumFractionDigits = 2
		formatter.maximumFractionDigits = 2
		return formatter
	}()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		
		
		playerNameField.text = player.name
		//playerEloRatingField.text = "\(player.eloRating)"
		playerEloRatingField.text = numberFormatter.stringFromNumber(player.eloRating)
		//playerRankField.text = "\(player.rank)"
		playerRankField.text = numberFormatter.stringFromNumber(player.rank)
		//playerWinsField.text = "\(player.wins)"
		playerWinsField.text = numberFormatter.stringFromNumber(player.wins)
		//playerLossesField.text = "\(player.losses)"
		playerLossesField.text = numberFormatter.stringFromNumber(player.losses)
		//playerDrawsField.text = "\(player.draws)"
		playerDrawsField.text = numberFormatter.stringFromNumber(player.draws)
		//playerIncompleteField.text = "\(player.incompletes)"
		playerIncompleteField.text = numberFormatter.stringFromNumber(player.incompletes)
		
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
		
		// "Save" changes to player
		player.name = playerNameField.text ?? ""
		
		if let rankText = playerRankField.text, rank = numberFormatter.numberFromString(rankText) {
			player.rank = rank.integerValue
		} else {
			player.rank = 0
		}
		
		if let eloText = playerEloRatingField.text, elo = numberFormatter.numberFromString(eloText) {
			player.eloRating = elo.floatValue
		} else {
			player.eloRating = 1500.0
		}
		
		
		if let winText = playerWinsField.text, win = numberFormatter.numberFromString(winText) {
			player.wins = win.integerValue
		} else {
			player.wins = 0
		}
		
		if let lossesText = playerLossesField.text, loss = numberFormatter.numberFromString(lossesText) {
			player.losses = loss.integerValue
		} else {
			player.losses = 0
		}
		
		
		if let drawText = playerDrawsField.text, draw = numberFormatter.numberFromString(drawText) {
			player.draws = draw.integerValue
		} else {
			player.draws = 0
		}
	}
	
	
	
	
	
	
	
}
