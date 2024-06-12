//
//  PostCollectionViewModel.swift
//  Pollexa
//
//  Created by Umut Yüksel on 12.06.2024.
//

import UIKit

struct PostCollectionViewModel {
    
    let post: Post
    
    var user: User? {
        return post.user
    }
    
    var username: String? {
        return user?.username
    }
    
    var userImage: UIImage? {
        return user?.image
    }
    
    var createdAt: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: post.createdAt)
    }
    
    var content: String {
        return post.content
    }
    
    var lastVoteAt: Date? {
        return post.lastVoteAt
    }
    
    var optionOneImage: UIImage {
        return post.options[0].image
    }
    
    var optionTwoImage: UIImage {
        return post.options[1].image
    }
    
    var optionOneVotes: Int {
        return post.options[0].voted ?? 0
    }
    
    var optionTwoVotes: Int {
        return post.options[1].voted ?? 0
    }
    
    var totalVotes: Int {
        return post.totalVote ?? 0
    }
    
    var optionOnePercentage: String {
        guard totalVotes > 0 else {
            return "0%"
        }
        let percentage = (optionOneVotes * 100) / totalVotes
        return "\(percentage)%"
    }
    
    var optionTwoPercentage: String {
        guard totalVotes > 0 else {
            return "0%"
        }
        let percentage = (optionTwoVotes * 100) / totalVotes
        return "\(percentage)%"
    }
    
    init(post: Post) {
        self.post = post
    }
}
