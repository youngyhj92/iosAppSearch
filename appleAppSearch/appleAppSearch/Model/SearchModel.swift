//
//  SearchModel.swift
//  appleAppSearch
//
//  Created by hyunjun yang on 09/03/2019.
//  Copyright © 2019 hyunjun yang. All rights reserved.
//

import Foundation

struct SearchResponse :Codable {
    let resultCount : Int
    let results : [AppInformation]?
}

struct AppInformation : Codable {
    let isGameCenterEnabled : Bool
    let screenshotUrls : [String]
    let ipadScreenshotUrls : [String]
    let appletvScreenshotUrls : [String]
    let artworkUrl60 : String
    let artworkUrl512 : String
    let artworkUrl100 : String
    let supportedDevices : [String]
    let kind : String
    let features : [String]
    let advisories : [String]
    let averageUserRatingForCurrentVersion : Double
    let trackCensoredName : String
    let languageCodesISO2A : [String]
    let fileSizeBytes : String
    let sellerUrl : String
    let contentAdvisoryRating : String
    let userRatingCountForCurrentVersion : String
    let trackViewUrl : String
    let trackContentRating : String
    let isVppDeviceBasedLicensingEnabled : Bool
    let sellerName : String
    let genreIds : [String]
    let releaseNotes : String
    let releaseDate : String
    let primaryGenreName : String
    let primaryGenreId : Int
    let formattedPrice : String
    let currency : String
    let wrapperType : String
    let version : String
    let minimumOsVersion : String
    let artistId : Int
    let artistName : String
    let genres : [String]
    let price : Double
    let description : String
    let trackName : String
    let bundleId : String
    let trackId : Int
    let currentVersionReleaseDate : String
}
