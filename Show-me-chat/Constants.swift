import Foundation
import Firebase
import FirebaseDatabase

struct Constants {
    struct refs {
        static let databaseRoot: DatabaseReference! = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
    }
    
    struct API{
        static let mapApi = "AIzaSyAq2zxCLB4dlQgvK6eqMvs3pjDpZ1Sc-60"
    }
}
 
