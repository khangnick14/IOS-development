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

struct FavoritesView: View {
    @Binding var isOpen: Bool
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var homePageModel: HomePageViewModel
    
    @ObservedObject var foods = FoodViewModel()
    
    @State var selectedFood = Food(id: "", name: "", type: "", region: "", description: "", recipe: "", isLike: false, urlPath: "")
    @State var isLinkActive = false
    @State var searchingWord = ""
    
    //results of filterd food based on searching key word
    var results: [Food] {
        //empty, show entire list
        if searchingWord.isEmpty {
            return foods.foodList
        } else {
            //filter
            return foods.foodList.filter{$0.name.contains(searchingWord)}
        }
    }
    
    //init the model view to fetch data
    init(isOpen: Binding<Bool>) {
        _isOpen = isOpen
        foods.getFavoriteFood()
    }
    var body: some View {
        ZStack{
            Color(.black).opacity(0.2).ignoresSafeArea()
            NavigationView{
                ScrollView{
                    VStack {
                        Text("Your FoodBook")
                            .font(.system(.largeTitle, design: .rounded))
                            .bold()
                            .foregroundColor(colorScheme == .light ? .blue : .white)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 5, y: 5)
                        FilterGroup().padding(.horizontal, 10)
                        ForEach(foods.foodList){
                            food in
                            HStack {
                                CardView(food: food)
                                //button to navigate to detail view
                                Button {
                                    selectedFood = food
                                    isLinkActive = true
                                } label: {
                                    Image(systemName: "arrow.forward")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                }
                                .background {
                                    Circle().fill(.black
                                        .opacity(0.15))
                                    .frame(width: 30, height: 30)
                                }
                            }
                            .padding(.vertical, 10)
                            .padding(.trailing, 4)
                            
                        }
                        .background(
                            NavigationLink(
                                destination: RecipeDetailView(food: selectedFood), isActive: $isLinkActive) {
                                    EmptyView()
                                })
                        
                    }
                }
                .searchable(text: $searchingWord, placement: .navigationBarDrawer(displayMode: .always))
                
            }//NavigationView
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            
        }//ZStack
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .rotation3DEffect(.degrees(isOpen ? 30: 0), axis: (x: 0, y: -1, z: 0))
        .offset(x: isOpen ? 265 : 0)
        .scaleEffect(isOpen ? 0.9 : 1)
        .ignoresSafeArea()
        
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(isOpen: .constant(false))
    }
}
