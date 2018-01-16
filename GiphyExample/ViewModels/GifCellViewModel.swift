//
//  GifCellViewModel.swift
//  GiphyExample
//
//  Created by Daniel Langh on 2018. 01. 16..
//  Copyright © 2018. rumori. All rights reserved.
//

import UIKit

class GifCellViewModel: GifCellViewModelType {

    var url: URL
    var width: Int
    var height: Int

    private let item: GiphyItem
    
    init(_ item: GiphyItem) {
        self.item = item
        
        let image = item.images.fixedHeight
        url = image.url
        width = image.width
        height = image.height
    }
}
