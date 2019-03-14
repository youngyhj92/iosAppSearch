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
    let isGameCenterEnabled : Bool = false
    let screenshotUrls : [URL]? = nil
    let ipadScreenshotUrls : [URL]? = nil
    let appletvScreenshotUrls : [URL]? = nil
    let artistViewUrl : URL? = nil
    let artworkUrl60 : URL? = nil
    let artworkUrl512 : URL? = nil
    let artworkUrl100 : URL? = nil
    let supportedDevices : [String]? = nil
    let kind : String? = nil
    let features : [String]? = nil
    let advisories : [String]? = nil
    let averageUserRatingForCurrentVersion : Float? = nil
    let trackCensoredName : String? = nil
    let languageCodesISO2A : [String]? = nil
    let fileSizeBytes : String? = nil
    let sellerUrl : URL? = nil
    let contentAdvisoryRating : String? = nil
    let userRatingCountForCurrentVersion : Int? = nil
    let trackViewUrl : URL? = nil
    let trackContentRating : String? = nil
    let isVppDeviceBasedLicensingEnabled : Bool = false
    let sellerName : String? = nil
    let genreIds : [String]? = nil
    let releaseNotes : String? = nil
    let releaseDate : String? = nil
    let primaryGenreName : String? = nil
    let primaryGenreId : Int? = nil
    let formattedPrice : String? = nil
    let currency : String? = nil
    let wrapperType : String? = nil
    let version : String? = nil
    let minimumOsVersion : String? = nil
    let artistId : Int? = nil
    let artistName : String? = nil
    let genres : [String]? = nil
    let price : Double? = nil
    let description : String? = nil
    let trackName : String? = nil
    let bundleId : String? = nil
    let trackId : Int? = nil
    let currentVersionReleaseDate : String?
}
