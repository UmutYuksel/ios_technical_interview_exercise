//
//  PollsCollectionViewCell.swift
//  Pollexa
//
//  Created by Umut Yüksel on 7.06.2024.
//

import UIKit

class PollsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var lastVoteLabel: UILabel!
    @IBOutlet weak var pollDescriptionLabel: UILabel!
    @IBOutlet weak var optionOneImageView: UIImageView!
    @IBOutlet weak var optionTwoImageView: UIImageView!
    @IBOutlet weak var totalVoteCountLabel: UILabel!
}
