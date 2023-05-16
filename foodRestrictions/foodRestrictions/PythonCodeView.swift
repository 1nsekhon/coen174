//
//  PythonCodeView.swift
//  foodRestrictions
//
//  Created by Megan Wiser on 5/10/23.
//

import SwiftUI
import TabularData

struct PythonCodeView: View {
    @StateObject var apiHappenings = OpenAiInteraction()
    
    @State private var menuText: String = ""
    @State private var menuDF: DataFrame?
    
    var body: some View {
        VStack {
            Text("Menu Text:")
            TextField("Enter menu text", text: $menuText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            NavigationLink(destination: doneView()){
                Text("call api")
            }.simultaneousGesture(TapGesture().onEnded {
                apiHappenings.createMenuDataFrame()
            })
            
            /*Button(action: {
                apiHappenings.createMenuDataFrame()
            }, label: {
                Text("call api")
            })*/
            
            if let df = menuDF {
                Text(df.description)
            }
        }
        .padding()
    }
}

struct doneView: View {
    var body: some View {
        Text("api call is done")
    }
}



/*struct PythonCodeView_Previews: PreviewProvider {
    static var previews: some View {
        PythonCodeView()
    }
}*/
