//
//  eloRatingFunction.swift
//  eloRatingSystem
//
//  Created by Chris Stromberg on 5/4/16.
//  Copyright © 2016 Chris Stromberg. All rights reserved.
//

import Foundation

var rA : Float = 1613.0
var rB : Float = 1609.0

// Ea =  1/ {1 + (10 ^ (rB - rA)/400)}



func eRating(ratingA: Float, ratingB: Float) -> Float {
	let exponent = (ratingB - ratingA)/400
	let raised = pow(10, exponent)
	return 1 / (raised + 1)
}

//eRating(rA, ratingB: rB)

//eRating(rB, ratingB: rA)


// EaNew = rA + K(Sa - Ea)

func newEloRating(ratingA: Float, ratingB: Float, playerOneScore: Float, kFactor: Float) -> (playerOneElo: Float, playerTwoElo: Float) {
	
	var aExpectedScore = eRating(ratingA, ratingB: ratingB)
	var bExpectedScore = eRating(ratingB, ratingB: ratingA)
	
	var aScore = playerOneScore
	var bScore: Float {
		if aScore == 1.0 {
			return 0.0
		} else if aScore == 0 {
			return 1.0
		} else {
			return 0.5
		}
	}
	
	let aNewElo = (kFactor * (aScore - aExpectedScore)) + ratingA
	
	let bNewElo = (kFactor * (bScore - bExpectedScore)) + ratingB
	
	return (round(aNewElo), round(bNewElo))
}
