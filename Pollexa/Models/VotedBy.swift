//
//  VotedBy.swift
//  Pollexa
//
//  Created by Umut Yüksel on 9.06.2024.
//

import Foundation

public struct VotedBy : Decodable {
    
    // MARK: - Properties
    public var user : User
    public var postID : String?
    public var selectedOption : Post.Option
    
    // MARK: - Life Cycle
    public init(user: User, postID: String? = nil, selectedOption: Post.Option) {
        self.user = user
        self.postID = postID
        self.selectedOption = selectedOption
    }
}
