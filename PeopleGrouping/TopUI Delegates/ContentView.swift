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
        switch activeTab {
        case 0:
            return "search"
        case 1:
            return "people"
        case 2:
            return "places"
        default:
            return ""
        }
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $activeTab) {
                QuickSearch()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("search")
                }.tag(0)
                PeopleList()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("people")
                }.tag(1)
                PlaceList()
                .tabItem {
                    Image(systemName: "perspective")
                    Text("places")
                }.tag(2)
            }
            .navigationBarTitle(activeTabTitle)
            .navigationBarItems(
                leading:
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
                    PeopleDetail().environmentObject(self.resource)
                }
            )
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
