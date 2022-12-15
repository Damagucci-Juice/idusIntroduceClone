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
    let languageCodesISO2A: [LanguageCode]
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

extension ResultDTO {
    func toDomain() -> AppIntroduction {
        let fileSizeMB = String(((Double(fileSizeBytes) ?? 0) / 1024000).roundUnder1()) + " MB"
        let copyright = "© \(String(sellerName.split(separator: " ")[0]))"
        
        return .init(id: trackID,
                     appName: trackName,
                     sellerName: copyright,
                     isGameCenterEnabled: isGameCenterEnabled,
                     screenshotURLs: screenshotUrls.compactMap { URL(string: $0) },
                     artworkULR60: URL(string: artworkUrl60)!,
                     artworkULR512: URL(string: artworkUrl512)!,
                     artworkULR100: URL(string: artworkUrl100)!,
                     releaseNotes: releaseNotes,
                     artistID: artistID,
                     artistName: artistName,
                     genres: genres,
                     price: price,
                     introduction: resultDescription,
                     primaryGenreName: primaryGenreName,
                     primaryGenreID: primaryGenreID,
                     currentVersionReleaseDate: currentVersionReleaseDate,
                     contentAdvisoryRating: contentAdvisoryRating,
                     trackContentRating: trackContentRating,
                     minimumOSVersion: Double(minimumOSVersion) ?? 0.0,
                     languageCodes: languageCodesISO2A.map { $0.capitalized },
                     fileSizeBytes: fileSizeMB,
                     sellerURL: URL(string: sellerURL)!,
                     formattedPrice: formattedPrice,
                     averagedUserRating: averageUserRating,
                     userRatingCount: userRatingCount,
                     version: version,
                     trackViewURL: URL(string: trackViewURL)!
        )
    }
}
