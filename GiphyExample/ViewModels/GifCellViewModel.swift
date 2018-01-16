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

    private let item: GiphyItem
    
    init(_ item: GiphyItem) {
        self.item = item
        self.url = item.images.fixedHeight.url
    }
    
}
