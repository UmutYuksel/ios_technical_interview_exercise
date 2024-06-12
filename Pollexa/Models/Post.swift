//
//  Post.swift
//  Pollexa
//
//  Created by Emirhan Erdogan on 13/05/2024.
//

import UIKit

public struct Post: Decodable {
    
    
    // MARK: - Types
    public enum CodingKeys: String, CodingKey {
        case id
        case createdAt
        case content
        case options
        case user
        case lastVoteAt
        case votedBy
        case totalVote
    }
    
    // MARK: - Properties
    public let id: String
    public let createdAt: Date
    public let content: String
    public var options: [Option]
    public let user : User?
    public var lastVoteAt: Date?
    public var votedBy : [VotedBy]?
    public var totalVote : Int?
    
    
    // MARK: - Life Cycle
    public init(id: String, createdAt: Date, content: String, options: [Option], user: User?, lastVoteAt: Date? = nil, votedBy: [VotedBy]? = nil,totalVote: Int? = nil) {
        self.id = id
        self.createdAt = createdAt
        self.content = content
        self.options = options
        self.user = user
        self.lastVoteAt = lastVoteAt
        self.votedBy = votedBy
        self.totalVote = totalVote
    }
}

extension Post {
    var optionPercentage: [Double] {
        guard let totalVoteCount = totalVote, totalVoteCount > 0 else {
            return []
        }
        
        return options.map { option in
            guard let votedCount = option.voted else {
                return 0
            }
            return Double(votedCount) / Double(totalVoteCount) * 100.0
        }
    }
}




