//
//  ResponseDTO.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/06.
//

import Foundation

struct ResponseDTO: Codable {
    let resultCount: Int
    let results: [ResultDTO]
}

struct ResultDTO: Codable {
    let isGameCenterEnabled: Bool
    let supportedDevices: [String]
    let screenshotUrls: [String]
    let artworkUrl60, artworkUrl512, artworkUrl100: String
    let artistViewURL: String
    let kind, releaseNotes: String
    let artistID: Int
    let artistName: String
    let genres: [String]
    let price: Double
    let resultDescription: String
    let releaseDate: Date
        let bundleID, currency: String
        let trackID: Int
        let trackName, primaryGenreName: String
        let primaryGenreID: Int
        let isVppDeviceBasedLicensingEnabled: Bool
        let sellerName: String
        let genreIDS: [String]
        let currentVersionReleaseDate: Date
        let contentAdvisoryRating, minimumOSVersion, trackCensoredName: String
        let languageCodesISO2A: [String]
        let fileSizeBytes: String
        let sellerURL: String
        let formattedPrice: String
        let averageUserRatingForCurrentVersion: Double
        let userRatingCountForCurrentVersion: Int
        let averageUserRating: Double
        let trackViewURL: String
        let trackContentRating, version, wrapperType: String
        let userRatingCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case isGameCenterEnabled, supportedDevices,  screenshotUrls, artworkUrl60, artworkUrl512, artworkUrl100
        case artistViewURL = "artistViewUrl"
        case kind, releaseNotes
        case artistID = "artistId"
        case artistName, genres, price
        case resultDescription = "description"
        case releaseDate
                case bundleID = "bundleId"
                case currency
                case trackID = "trackId"
                case trackName, primaryGenreName
                case primaryGenreID = "primaryGenreId"
                case isVppDeviceBasedLicensingEnabled, sellerName
                case genreIDS = "genreIds"
                case currentVersionReleaseDate
                case contentAdvisoryRating
                case minimumOSVersion = "minimumOsVersion"
                case trackCensoredName, languageCodesISO2A, fileSizeBytes
                case sellerURL = "sellerUrl"
                case formattedPrice, averageUserRatingForCurrentVersion, userRatingCountForCurrentVersion, averageUserRating
                case trackViewURL = "trackViewUrl"
                case trackContentRating, version, wrapperType, userRatingCount
    }
}
