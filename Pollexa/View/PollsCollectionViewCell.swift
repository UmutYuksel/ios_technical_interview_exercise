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
    
    func configure(with post: Post) {
        
        // Tarih bilgileri
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        createdDateLabel.text = "\(dateFormatter.string(from: post.createdAt)) days ago"
        // Kullanıcı bilgileri
        userImageView.image = post.user?.image
        userNameLabel.text = post.user?.username
        pollDescriptionLabel.text = post.content
        optionOneImageView.image = post.options[0].image
        optionTwoImageView.image = post.options[1].image
        totalVoteCountLabel.text = String("\(post.totalVote)")
        
        if let lastVotedAt = post.lastVoteAt {
            let timeInterval = Date().timeIntervalSince(lastVotedAt)
            
            let minuteInterval = Int(timeInterval / 60)
                if minuteInterval < 60 {
                    lastVoteLabel.text = "Last voted \(minuteInterval) minutes ago"
                } else {
                    let hourInterval = Int(timeInterval / 3600)
        
                    if hourInterval < 24 {
                    lastVoteLabel.text = "Last voted \(hourInterval) hours ago"
                    } else {
                        let dayInterval = Int(timeInterval / (3600 * 24))
                        lastVoteLabel.text = "Last voted \(dayInterval) days ago"
                    }
                }} else {
                    lastVoteLabel.text = "No votes yet"
        }
        
    }
}
