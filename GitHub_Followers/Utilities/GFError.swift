//
//  GFError.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 05.05.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this user. Please try again"
    case alreadyInFavotires = "You`ve already favorites this user. You must really like them."
}
