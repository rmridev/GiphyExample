//
//  Models.swift
//  GiphyExample
//
//  Created by Daniel Langh on 2018. 01. 16..
//  Copyright © 2018. rumori. All rights reserved.
//

import UIKit
import Argo
import Runes
import Curry

// MARK: -

struct GiphyItem {
    var type: String
    var images: GiphyImages
}

struct GiphyImages {
    var fixedWidth: GiphyImage
    var fixedHeight: GiphyImage
}

struct GiphyImage {
    var url: URL
    var width: String
    var height: String
}

struct GiphyResults {
    var data: [GiphyItem]
}


// MARK: - Argo extensions

extension GiphyResults: Argo.Decodable {
    
    static func decode(_ json: JSON) -> Decoded<GiphyResults> {
        return curry(GiphyResults.init)
            <^> json <|| "data"
    }
}

extension GiphyItem: Argo.Decodable {
    
    static func decode(_ json: JSON) -> Decoded<GiphyItem> {
        return curry(GiphyItem.init)
            <^> json <| "type"
            <*> json <| "images"
    }
}

extension GiphyImages: Argo.Decodable {
    static func decode(_ json: JSON) -> Decoded<GiphyImages> {
        return curry(GiphyImages.init)
            <^> json <| "fixed_width"
            <*> json <| "fixed_height"
    }
}

extension GiphyImage: Argo.Decodable {
    
    static func decode(_ json: JSON) -> Decoded<GiphyImage> {
        return curry(GiphyImage.init)
            <^> json <| "url"
            <*> json <| "width"
            <*> json <| "height"
    }
}

extension URL: Argo.Decodable {
    public static func decode(_ json: JSON) -> Decoded<URL> {
        switch json {
        case let .string(s):
            let str = s.trimmingCharacters(in: CharacterSet.whitespaces)
            if let url = URL(string: str) {
                return pure(url)
            } else {
                return .typeMismatch(expected:"Non empty valid URL string", actual:"\(s)")
            }
        default: return .typeMismatch(expected:"String type for URL conversion", actual:"\(json)")
        }
    }
}
