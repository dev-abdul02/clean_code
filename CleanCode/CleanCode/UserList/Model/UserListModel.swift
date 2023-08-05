

import Foundation

struct UserList : Codable {
	let userId : Int?
	let id : Int?
	let title : String?
	let body : String?
}


extension UserList: Equatable {
    static func == (lhs: UserList, rhs: UserList) -> Bool {
        return lhs.id == rhs.id
    }
}
