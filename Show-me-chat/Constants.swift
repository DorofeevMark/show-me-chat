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
    
    struct ScreenParameters {
        static let height = UIScreen.main.bounds.height
        static let width = UIScreen.main.bounds.width
    }
    
}
 
