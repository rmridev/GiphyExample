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
    var width: Int { get }
    var height: Int { get }
    var url: URL { get }
}

// MARK: -

class GifCell: UITableViewCell {
    
    @IBOutlet var gifView: UIImageView!
    @IBOutlet var widthConstraint: NSLayoutConstraint!
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
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
        
        guard let viewModel = viewModel else {
            indicatorView.stopAnimating()
            gifView.sd_setImage(with: nil, completed: nil)
            return
        }
        
        widthConstraint.constant = CGFloat(viewModel.width)
        heightConstraint.constant = CGFloat(viewModel.height)
        
        indicatorView.startAnimating()
        gifView.sd_setImage(with: viewModel.url, completed: { [weak self] (image, error, _, completedUrl) in
            self?.indicatorView.stopAnimating()
        })
    }
}
