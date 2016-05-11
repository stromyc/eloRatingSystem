//
//  EloRatingCalculator.swift
//  eloRatingSystem
//
//  Created by Christopher Stromberg on 5/4/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import Foundation

class EloRatingCalculator {
	
	var ratingPlayerOne : Float = 0.0
	var ratingPlayerTwo : Float = 0.0
	
	enum KFactor {
		case twenty
		case thirty
		case forty
		
		var currentKFactor : Float {
			switch self {
			case .twenty: return 20.0
			case .thirty: return 30.0
			case .forty: return 40.0
			}
		}
	}
	
	enum Outcome {
		case win
		case lost
		case draw
		
		var score : Float {
			switch self {
			case win : return 1.0
			case lost : return 0.0
			case draw : return 0.5
			}
		}
		
		var stringRawValue : String {
			switch self {
			case win : return "Win"
			case lost : return "Lost"
			case draw : return "Draw"
			}
		}
		
	}
	
	
	// EloRating expected rating formula where:
	// rB = rating for player 2
	// rA = rating for player 1
	// Ea = expected rating
	
	// Ea =  1/ {1 + (10 ^ (rB - rA)/400)}
	
	
	// EloRating new rating formula where:
	// rA = rating for player 1
	// K = KFactor 20,30,40
	// Sa = Score 1 = win, 0 = loss, .5 = draw
	// EaNew = rA + K(Sa - Ea)
	
	func newEloRating(ratingA: Float, ratingB: Float, playerOneScore: Outcome, kFactor: KFactor) -> (playerOneElo: Float, playerTwoElo: Float) {
		
		// Determines expected rating.
		func eRating(ratingA: Float, ratingB: Float) -> Float {
			let exponent = (ratingB - ratingA)/400
			let raised = pow(10, exponent)
			return 1 / (raised + 1)
		}
		
		
		// Calculate the expected rating for each player.
		var aExpectedScore = eRating(ratingA, ratingB: ratingB)
		var bExpectedScore = eRating(ratingB, ratingB: ratingA)
		
		// Score for match 1 = win, 0 = lost, .5 = draw
		var aScore = playerOneScore.score
		var bScore: Float {
			
			switch aScore {
			case 1.0 : return 0.0
			case 0.5 : return 0.5
			case 0.0 : return 1.0
			default : return 9999.0
			}
			
			
		}
		
		let aNewElo = (kFactor.currentKFactor * (aScore - aExpectedScore)) + ratingA
		
		ratingPlayerOne = aNewElo
		
		let bNewElo = (kFactor.currentKFactor * (bScore - bExpectedScore)) + ratingB
		
		ratingPlayerTwo = bNewElo
		
		return (round(aNewElo), round(bNewElo))
		
	}
}