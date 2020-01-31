//
//  ContentView.swift
//  Blacklister - Categorize People
//
//  Created by Kevin Taniguchi on 1/19/20.
//  Copyright © 2020 Kevin Taniguchi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var resource: PeopleResource
    @State private var isShowingSettings: Bool = false
    @State private var isShowingingNewPerson: Bool = false
    @State private var activeTab: Int = 0
    
    private var activeTabTitle: String {
        if activeTab == 0 {
            return "enemies"
        } else if activeTab == 1 {
            return "friends"
        } else {
            return "all"
        }
    }
    
    private var selectedCategory: PersonCategory {
        if activeTab == 0 {
            return .enemy
        } else if activeTab == 1 {
            return .friend
        } else {
            return .all
        }
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $activeTab) {
                PeopleList(category: .enemy)
                .tabItem {
                    Image(systemName: "hand.thumbsdown")
                    Text("enemies")
                }.tag(0)
                PeopleList(category: .friend)
                .tabItem {
                    Image(systemName: "hand.thumbsup")
                    Text("friends")
                }.tag(1)
                PeopleList(category: .all)
                .tabItem {
                    Image(systemName: "smallcircle.fill.circle")
                    Text("all")
                }.tag(2)
            }
            .navigationBarTitle(activeTabTitle)
            .navigationBarItems(leading:
                Button(action: {
                    self.isShowingSettings = true
                }) {
                    Image(systemName: "gear").foregroundColor(Color.blue)
                }.sheet(isPresented: self.$isShowingSettings, onDismiss: {
                    self.isShowingSettings = false
                }) {
                    SettingsView()
                },
                trailing:
                Button(action: {
                    self.isShowingingNewPerson = true
                }) {
                    Image(systemName: "plus.square.fill").resizable().frame(width: 25.0, height: 25.0).foregroundColor(Color.blue)
                }.sheet(isPresented: self.$isShowingingNewPerson, onDismiss: {
                    self.isShowingingNewPerson = false
                }) {
                    PeopleDetail(category: self.selectedCategory).environmentObject(self.resource)
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
