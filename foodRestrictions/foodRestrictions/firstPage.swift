//
//  firstPage.swift
//  foodRestrictions
//
//  Created by Megan Wiser on 5/13/23.
//

import SwiftUI

struct firstPage: View {
    var body: some View {
        NavigationLink(destination: ContentView()) {
            Text("Start Scan")
        }
    }
}

struct firstPage_Previews: PreviewProvider {
    static var previews: some View {
        firstPage()
    }
}
