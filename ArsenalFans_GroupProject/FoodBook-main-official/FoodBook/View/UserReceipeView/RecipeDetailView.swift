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
import Foundation
import Firebase
import FirebaseStorage
import FirebaseCore
import FirebaseFirestore
import Kingfisher

struct RecipeDetailView: View {
    var food: Food
    
    var body: some View {
        ZStack {
            ScrollView{
                VStack {
                    KFImage(URL(string: food.urlPath)!)
                        .resizable()
                        .frame(width: 400, height: 350, alignment: .center)
                        .cornerRadius(20)
                    Spacer()
                    VStack {
                    Text(food.name)
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                        .foregroundColor(.blue)
                        .shadow(color: .white.opacity(0.2), radius: 5, x: 5, y: 5)
                        .font(.title)
                    
                    Group{
                        Text(food.type)
                            .font(.system(.title3, design: .rounded))

                            .fontWeight(.semibold)
                        
                        Image(food.region)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 40, alignment: .center)
                    }
                    
                    
                        VStack(alignment: .leading, spacing: 2){
                        Text("DESCRIPTION:")
                            .bold()
                            .padding(.horizontal, 10)
                            .padding(.vertical, 15)
                            .background(.black)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                        Text(food.description)
                            .padding(20)
                        Text("RECIPE:")
                                .bold()
                                .padding(.horizontal, 10)
                                .padding(.vertical, 15)
                                .background(.black)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        Text(food.recipe)
                            .padding(20)
                            
                        }
                        .padding()
                    }.background(
                        RoundedRectangle(cornerRadius: 20).fill(.black.opacity(0.05)))
                        
                }
            }
        }
        .ignoresSafeArea(.all)

        

    }
}

