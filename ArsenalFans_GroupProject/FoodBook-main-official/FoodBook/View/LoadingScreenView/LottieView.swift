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
import Lottie

struct LottieView: UIViewRepresentable {
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    var name: String
    func makeUIView(context: Context) -> some UIView {
        let view = AnimationView(name: name, bundle: Bundle.main)
        //loop animation
        view.loopMode = .loop
        //play
        view.play()
        return view
    }
}

