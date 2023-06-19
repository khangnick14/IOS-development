/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Nguyen Manh Khang
 ID: s3864131
 Created  date: 29/07/2022
 Last modified: 07/08/2022
 Acknowledgement:
 https://developer.apple.com/documentation/swiftui/
 https://www.hackingwithswift.com/articles/216/complete-guide-to-navigationview-in-swiftui
 https://www.hackingwithswift.com/quick-start/swiftui/how-to-start-an-animation-immediately-after-a-view-appears
 https://betterprogramming.pub/swiftui-tutorial-basic-animations-edb78c97eb01
 */

import SwiftUI

struct TabBarView: View {
    //variables to keep track of current selected tab
    @State var selectedTab: Tab = .home //default is home tab
    @State var color: Color = primaryColor //default color
    
    var body: some View {
        ZStack(alignment: .bottom) {
            //Group of tab elements, selected tab will lead to corresponding view
            Group {
                switch selectedTab {
                case .home:
                    //Home is the List of Player View
                    PlayerListView()
                case .addNew:
                    //Add new player view
                    AddNewView()
                case .setting:
                    //Settings View
                    SettingView()
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            Spacer()
            HStack {
                Spacer()
                ForEach(tabElements) {element in
                    Button {
                        //animation to bounce the tab element when selected
                        withAnimation(.spring(response: 0.3, dampingFraction: 1)) {
                            selectedTab = element.tab
                            color = element.color
                        }
                    } label: {
                        //Assign the color and icon to each tab element
                        VStack{
                            Image(systemName: element.icon)
                                .symbolVariant(.fill)
                                .font(.title2.bold())
                                .frame(width: 45, height: 30)
                            Text(element.caption)
                                .font(.caption)
                                .lineLimit(1)
                        }
                    }
                    //assign different colors for selected tab
                    .foregroundStyle(selectedTab == element.tab ? color : secondaryColor)
                    Spacer()
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 75, alignment: .center)
            .background(.ultraThickMaterial)
            //add the small rectangle moving with the selected tab
            .overlay(
                HStack{
                    if selectedTab == .setting {
                        Spacer()
                    }
                    Rectangle()
                        .fill(color)
                        .frame(width: 50, height: 7)
                        .cornerRadius(3)
                        .frame(width: 140)
                        .frame(maxHeight: .infinity, alignment: .top)
                    if selectedTab == .home {
                        Spacer()}
                }
                    .padding(.horizontal, 15))
            
        }
        .ignoresSafeArea()
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
