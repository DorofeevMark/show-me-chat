import Foundation
import Firebase
import FirebaseDatabase

struct Constants {
    struct refs {
        static let databaseRoot: DatabaseReference! = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
    }
}
 
