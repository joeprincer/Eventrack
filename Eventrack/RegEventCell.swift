//
//  RegEventCell.swift
//  Eventrack
//
//  Created by Jiazhou Liu on 7/5/17.
//  Copyright © 2017 Jiazhou Liu. All rights reserved.
//

import UIKit

class RegEventCell: UITableViewCell {
    
    // IBOutlets
    @IBOutlet weak var eventContainerView: UIView!
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventStatus: UILabel!
    @IBOutlet weak var eventTag: UILabel!
    @IBOutlet weak var eventViewNumber: UILabel!
    @IBOutlet weak var viewImg: UIImageView!

    // cell initilizor
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // corner radius
        eventContainerView.layer.cornerRadius = 5
        
        // border
        eventContainerView.layer.borderWidth = 0.0
        eventContainerView.layer.borderColor = UIColor.black.cgColor
        
        // shadow
        eventContainerView.layer.shadowColor = UIColor.black.cgColor
        eventContainerView.layer.shadowOffset = CGSize(width: 2, height: 2)
        eventContainerView.layer.shadowOpacity = 0.5
        eventContainerView.layer.shadowRadius = 4.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
