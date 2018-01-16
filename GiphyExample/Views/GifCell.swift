//
//  GifCell.swift
//  GiphyExample
//
//  Created by Daniel Langh on 2018. 01. 16..
//  Copyright © 2018. rumori. All rights reserved.
//

import UIKit
import SDWebImage

protocol GifCellViewModelType: class {
    var url: URL { get }
}

// MARK: -

class GifCell: UITableViewCell {
    
    @IBOutlet var gifView: UIImageView!
    
    var viewModel: GifCellViewModelType? {
        didSet {
            update()
        }
    }
    
    // MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    private func update() {
        gifView.sd_setImage(with: viewModel?.url, completed: nil)
    }
}
