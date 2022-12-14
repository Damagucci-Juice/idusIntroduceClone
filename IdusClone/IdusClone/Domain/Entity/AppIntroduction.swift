//
//  AppIntroduction.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/06.
//

import Foundation

struct AppIntroduction: Equatable, Identifiable {
    typealias TrackID = Int
    typealias TrackName = String
    
    let id: TrackID
    let appName: TrackName
    let sellerName: String
    let isGameCenterEnabled: Bool
    let screenshotURLs: [URL]
    let artworkULR60: URL
    let artworkULR512: URL
    let artworkULR100: URL
    let releaseNotes: String
    let artistID: Int
    let artistName: String
    let genres: [String]
    let price: Double
    let introduction: String
    let primaryGenreName: String
    let primaryGenreID: Int
    let currentVersionReleaseDate: Date
    let contentAdvisoryRating: String
    let trackContentRating: String
    let minimumOSVersion: Double
    let languageCodes: [String]
    let fileSizeBytes: String
    let sellerURL: URL
    let formattedPrice: String
    let averagedUserRating: Double
    let userRatingCount: Int
    let version: String
    let trackViewURL: URL
    
    var shortIntroduction: String {
        introduction.replacingOccurrences(of: "\n\n", with: "\n")
    }
    
    var userRatingCountString: String {
        switch userRatingCount {
        case 0..<1000:
            return "\(userRatingCount)"
        case 1000..<1_000_000:
            return "\(Double(userRatingCount / 1000).roundUnder1WithoutZero())K"
        default:
            return "\(Double(userRatingCount / 1_000_000).roundUnder1WithoutZero())M"
        }
    }
}


