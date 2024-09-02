//
//  TVContentResponceModel.swift
//  TVContentsList_SwiftUI
//
//  Created by Irakli Chkhitunidze on 9/2/24.
//

import Foundation

// MARK: - TVContentViewServices
struct TVContentResponceModel: Codable {
    var genre: [String]?
    var language: [String]?
    var year: [String]?
    var country: [String]?
    var root: [RootContent]?
}

// MARK: - Root
struct RootContent: Codable, Identifiable {
    var id: Int?
    var name: String?
    var numChildren, numVideos: Int?
    var videos: [VideoModel]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case numChildren = "num_children"
        case numVideos = "num_videos"
        case videos
    }
}

// MARK: - Video
struct VideoModel: Codable, Identifiable {
    var type: VideoType?
    var id, videoID, poster: Int?
    var title, altTitle: String?
    var genres: [String]?
    var audios: [String]?
    var countries: [String]?
    var year: Int?
    var description, cast: String?
    var age, imdb: Int?

    enum CodingKeys: String, CodingKey {
        case type, id
        case videoID = "video_id"
        case poster, title
        case altTitle = "alt_title"
        case genres, audios, countries, year, description, cast, age, imdb
    }
}

enum VideoType: String, Codable {
    case video = "video"
}
