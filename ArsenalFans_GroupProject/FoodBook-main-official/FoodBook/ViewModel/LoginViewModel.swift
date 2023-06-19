/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Pham Hoang Thien An, Nguyen Manh Khang, Nguyen Truong Thinh, Nguyen Dang Quang
 ID: s3818286, s3871126, s3777230, s3741190
 Created  date: 1/09/2022
 Last modified: 18/09/2022
 Acknowledgement: Acknowledge the resources that you use here.
 https://www.youtube.com/watch?v=xkxGoNfpLXs
 https://www.youtube.com/watch?v=522NN8cDDpw
 https://peterfriese.dev/posts/swiftui-firebase-fetch-data/
 https://firebase.google.com/docs/database/ios/read-and-write
 https://lottiefiles.com/blog/working-with-lottie/how-to-add-lottie-animation-ios-app-swift/
 */
import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseCore
import FirebaseFirestore

class LoginViewModel: ObservableObject {
    
    let auth = Auth.auth()
    let storage = Storage.storage()
    
    @Published var loggedIn = false
    @Published var loginStatusMessage = ""
    
    var isLoggedIn: Bool {
        return auth.currentUser != nil
    }
    
    func login(email: String, password: String) {
        auth.signIn(withEmail: email,
                    password: password) { [weak self] result, error in
            
            guard result != nil, error == nil else {
                return
            }
            //Success
            DispatchQueue.main.async {
                self?.loggedIn = true
            }
        }
    }
    
    func register(email: String, password: String, image: UIImage) {
        auth.createUser(withEmail: email,
                        password: password) { [weak self] result, error in
            
            guard result != nil, error == nil else {
                self?.loginStatusMessage = "Failed to create user! Email/Password already exist"
                return
            }
            //Success
            DispatchQueue.main.async {
                
                self?.loginStatusMessage = "Successfully Create User!"
                self?.loggedIn = true
                self?.persistImageToStorage(image: image)
                
                
            }
            
        }
    }
    
    func persistImageToStorage(image: UIImage) {
        guard let uid = auth.currentUser?.uid else {return}
        
        let ref = storage.reference(withPath: uid)
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            return
        }
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                self.loginStatusMessage = "Failed to push image to Storage: \(error)"
                return
            }
            
            ref.downloadURL { url, error in
                if let error = error {
                    self.loginStatusMessage = "Failed to retrieve downloadURL: \(error)"
                    return
                }
                self.loginStatusMessage = "Successfully stored image: \(url?.absoluteString ?? "")"
                
                //Store user information to firestore
                guard let url = url else {return}
                self.storeUserInformation(imageProfileUrl: url)
            }
        }
    }
    
    private func storeUserInformation(imageProfileUrl: URL) {
        guard let uid = auth.currentUser?.uid else {return}
        guard let email = auth.currentUser?.email else {return}
        let db = Firestore.firestore()
        
        let userData = ["email": email,"uid" : uid,"profileImageUrl": imageProfileUrl.absoluteString,"recipes": [],"favorites": []] as [String : Any]
        
        db.collection("users").document(uid).setData(userData) { err in
            if let err = err {
                print(err)
                self.loginStatusMessage = "\(err)"
                return
            }
            print("Success")
        }
    }
    
    
    
    func signOut() {
        try? auth.signOut()
        
        self.loggedIn = false
    }
    
}
