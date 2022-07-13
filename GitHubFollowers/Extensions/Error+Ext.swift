//
//  Error+Ext.swift
//  GitHubFollowers
//
//  Created by Roberto Evangelista on 12/07/22.
//

import Foundation

enum GFError: String, Error {
    case invalidRequest = "This username created an invalid request. PLease try again."
    case internetConnection = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. please try again."
    case invalidData = "The data received from the server was invalid. PLease try again."
}
