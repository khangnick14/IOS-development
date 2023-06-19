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
import SDWebImageSwiftUI
import Firebase

struct MessagesView: View {
    
    @State var shouldShowLogOutOptions = false
    @State var showMessageScreen = false
    @State var navigateToChatView = false
    @State var chatUser: ChatUser?
    
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    @ObservedObject var vm = MessagesViewModel()
    @Binding var isOpen: Bool
    
    var body: some View {
        ZStack{
            Color(.white).ignoresSafeArea()
            
            NavigationView {
                VStack(alignment: .leading){
                    customNavBar
                    
                    messageList
                    
                    NavigationLink("", isActive: $navigateToChatView) {
                        ChatView(chatUser: self.chatUser)
                    }
                    
                    newMessageButton
                }//VStack
                
            }//NavigationView
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .padding(.bottom, 30)
            
        }//ZStack
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .rotation3DEffect(.degrees(isOpen ? 30: 0), axis: (x: 0, y: -1, z: 0))
        .offset(x: isOpen ? 265 : 0)
        .scaleEffect(isOpen ? 0.9 : 1)
        .ignoresSafeArea()
        
    }
    
    //New message button
    private var newMessageButton: some View {
        Button {
            showMessageScreen.toggle()
        } label: {
            HStack {
                Spacer()
                Text("+ New Message")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.vertical)
            .background(Color.blue)
            .cornerRadius(32)
            .padding(.horizontal)
            .shadow(radius: 15)
        }
        //show the view when button is presses
        .fullScreenCover(isPresented: $showMessageScreen) {
            AddMessageView(selectChatUser: { user in
                print(user.email)
                self.navigateToChatView.toggle()
                self.chatUser = user
            })
        }
    }
    
    //list of message fetch from firebase
    private var messageList: some View {
        
        ScrollView {
            ForEach(vm.recentMessages) { recentMessage in
                VStack{
                    Button {
                        showMessageScreen.toggle()
                    } label: {
                        HStack(spacing: 16){
                            //show avatar of user
                            WebImage(url: URL(string: recentMessage.profileImageUrl))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipped()
                                .cornerRadius(50)
                                .overlay(RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color.black, lineWidth: 1))
                                .shadow(radius: 5)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(recentMessage.email)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color(.label))
                                Text(recentMessage.text)
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(.lightGray))
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                            
                        }//HStack
                        Divider().padding(.vertical, 8)
                    }
                    
                }//VStack
                .padding(.horizontal)
            }
        }.padding(.bottom, 50)
    }
    
    //custom the nav bar contain user's avatar, email and signout button
    private var customNavBar: some View {
        HStack(spacing: 16) {
            
            WebImage(url: URL(string: vm.user?.profileImageUrl ?? ""))
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipped()
                .cornerRadius(50)
                .overlay(RoundedRectangle(cornerRadius: 44)
                    .stroke(Color(.label), lineWidth: 1))
            
            
            
            VStack(alignment: .leading, spacing: 4) {
                let userName = vm.user?.email.replacingOccurrences(of: "@gmail.com", with: "") ?? ""
                
                Text(userName)
                    .font(.system(size: 24, weight: .bold))
                
                HStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 14, height: 14)
                    Text("online")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.lightGray))
                }
                
            }
            
            Spacer()
            Button {
                shouldShowLogOutOptions.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(.label))
            }
        }
        .padding()
        .actionSheet(isPresented: $shouldShowLogOutOptions) {
            .init(title: Text("Settings"), message: Text("What do you want to do?"), buttons: [
                .destructive(Text("Sign Out"), action: {
                    loginViewModel.signOut()
                }),
                .cancel()
            ])
        }
    }
}


struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(isOpen: .constant(false))
    }
}
