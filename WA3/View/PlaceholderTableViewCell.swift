//
//  PlaceholderTableViewCell.swift
//  WA3
//
//  Created by Brett on 10/20/19.
//  Copyright © 2019 Brett. All rights reserved.
//

import UIKit

class PlaceholderTableViewCell: UITableViewCell {
    
    @IBOutlet var thumbnailView: UIImageView!{
        didSet{
            let layer = thumbnailView.layer
            layer.cornerRadius = thumbnailView.frame.width / 10.0
            layer.masksToBounds = true
            layer.borderWidth = 2.0
            layer.borderColor = UIColor.blue.cgColor
        }
    }
    
    @IBOutlet var loadingView: UIActivityIndicatorView!
    
    @IBOutlet var idLabel: UILabel!
    
    @IBOutlet var albumIdLabel: UILabel!
    
    @IBOutlet var titleLabel: UILabel!
    
    
}
