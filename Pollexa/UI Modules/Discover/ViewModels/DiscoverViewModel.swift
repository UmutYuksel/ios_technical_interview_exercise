//
//  DiscoverViewModel.swift
//  Pollexa
//
//  Created by Umut Yüksel on 7.06.2024.
//

import Foundation
import UIKit

protocol DiscoverViewModelDelegate: AnyObject {
    func didUpdatePost()
}

final class DiscoverViewModel {
    
    private let postProvider: PostProvider
    
    weak var delegate: DiscoverViewModelDelegate?
    
    var posts: [Post] = [] {
        didSet {
            delegate?.didUpdatePost()
        }
    }
    
    init(postProvider: PostProvider) {
        self.postProvider = postProvider
    }
    
    func fetchPosts() {
        postProvider.fetchAll { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let fetchedPosts):
                self.posts = fetchedPosts
                delegate?.didUpdatePost()
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
            print("Geçersiz Anket İndeksi")
            return
        }
        
        var poll = posts[pollIndex]
        
        guard optionIndex < poll.options.count else {
            print("Geçersiz option indeksi")
            return
        }
            
        // Oy sayısını güncelle
        if let votedCount = poll.options[optionIndex].voted {
            poll.options[optionIndex].voted = votedCount + 1
        } else {
            poll.options[optionIndex].voted = 1
        }
            
        // Toplam oy sayısını güncelle
        if poll.totalVote != nil {
            poll.totalVote! += 1
        } else {
            poll.totalVote = 1
        }
            
        // Son oy zamanını güncelle
        poll.lastVoteAt = Date() // Şu anki zamanı atıyoruz
        
        posts[pollIndex] = poll // Güncellenmiş poll'u tekrar listeye ekle
            
        delegate?.didUpdatePost()
    }
}
