//
//  DiscoverViewModel.swift
//  Pollexa
//
//  Created by Umut Yüksel on 7.06.2024.
//

import Foundation

protocol DiscoverViewModelDelegate: AnyObject {
    func didUpdatePost()
}

final class DiscoverViewModel {
    
    // MARK: - Properties
    
    private let postProvider: PostProvider
    weak var delegate: DiscoverViewModelDelegate?
    
    var posts: [Post] = [] {
        didSet {
            delegate?.didUpdatePost()
        }
    }
    
    // MARK: - Initialization
    
    init(postProvider: PostProvider) {
        self.postProvider = postProvider
    }
    
    // MARK: - Methods
    
    func fetchPosts() {
        postProvider.fetchAll { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let fetchedPosts):
                self.posts = fetchedPosts
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func activePollsText() -> String {
        return "\(posts.count) Active Polls"
    }
    
    func voteForOption(pollIndex: Int, optionIndex: Int) {
        guard pollIndex < posts.count else {
            print("Invalid Poll Index")
            return
        }
        
        var poll = posts[pollIndex]
        
        guard optionIndex < poll.options.count else {
            print("Invalid Option Index")
            return
        }
        
        // Update vote count
        if let votedCount = poll.options[optionIndex].voted {
            poll.options[optionIndex].voted = votedCount + 1
        } else {
            poll.options[optionIndex].voted = 1
        }
        
        // Update total vote count
        if poll.totalVote != nil {
            poll.totalVote! += 1
        } else {
            poll.totalVote = 1
        }
        
        // Update last vote time
        poll.lastVoteAt = Date()
        
        posts[pollIndex] = poll
        
        delegate?.didUpdatePost()
    }
}
