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


struct CRUDView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var showCRUDview = false
    @ObservedObject var foods = FoodViewModel()
    @State var list = [Food]()
    @State var recipeFieldText: String = ""
    @State var urlPathFieldText: String = "https://png.pngtree.com/element_our/20190604/ourlarge/pngtree-ramen-poached-egg-food-simple-and-delicious-japanese-food-image_1483315.jpg"
    @State var nameFieldText: String = ""
    @State var descriptionFieldText: String = ""
    @State var typeOfFoodSelection = "Soups"
    let type = ["Soup", "Salad", "Main Dish", "Breakfast", "Desserts", "Others"]
    @State var regionOfFoodSelection = "Vietnamese"
    let region = ["Vietnamese", "Korean", "Indian", "Chinese", "Italian", "American",  "Mexican", "Others"]
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
                    Text("ADD YOUR OWN FOOD RECIPE!")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    Spacer(minLength: 100)
                    
                    Group{
                        TextField("Food name: ", text: $nameFieldText)
                            .padding()
                            .background(Color.gray.opacity(0.2).cornerRadius(10))
                            .foregroundColor(.blue)
                    
                        HStack{
                        
                            Text("Type of food: ")
                            Picker("Select the type of the food: ", selection: $typeOfFoodSelection){
                                ForEach(type, id: \.self){
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                        
                            Text("Nation: ")
                            Picker("Select the region of the food: ", selection: $regionOfFoodSelection){
                                ForEach(region, id: \.self){
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                        TextField("Food description: ", text: $descriptionFieldText)
                            .padding()
                            .background(Color.gray.opacity(0.2).cornerRadius(16))
                            .foregroundColor(.blue)
                            
                        
                        TextField("Food recipe: ", text: $recipeFieldText)
                            .padding()
                            .background(Color.gray.opacity(0.2).cornerRadius(16))
                            .foregroundColor(.blue)
                        
                        TextField("Path to the picture: ", text: $urlPathFieldText)
                            .padding()
                            .background(Color.gray.opacity(0.2).cornerRadius(16))
                            .foregroundColor(.blue)
                    }
                    .padding(10)
                    Spacer()
                    Button(action:{
                        foods.addFood(name: nameFieldText, type: typeOfFoodSelection, region: regionOfFoodSelection, description: descriptionFieldText, recipe: recipeFieldText, urlPath: urlPathFieldText)
                        presentationMode.wrappedValue.dismiss()
                    }){
                        Text("Add food")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.all, 20)
                            .background(.blue)
                            .cornerRadius(20)
                    }
                }
            }
        }
    }
}


