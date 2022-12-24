//
//  MainScreen.swift
//  madApp
//
//  Created by Nikolay Truhin on 24/12/22.
//

import SwiftUI

struct MainScreen: View {
    @State var tasks: [TaskModel] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("My Tasks").font(.custom(.boldFont, size: 36))
                Spacer()
                Image("profile")
            }.background(Color.white)
                .padding(.horizontal, 24).padding(.vertical, 8)
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("In Progress").font(.custom(.boldFont, size: 24))
                    ForEach(tasks.filter { $0.status.title != .new }) { task in
                        TaskCell(task: task)
                    }
                }
                .padding(.horizontal, 24).padding(.vertical, 8)
                
                VStack(alignment: .leading) {
                    Text("New").font(.custom(.boldFont, size: 24))
                    ForEach(tasks.filter { $0.status.title == .new }) { task in
                        TaskCell(task: task)
                    }
                }
                .padding(.horizontal, 24).padding(.vertical, 8)
            }
        }
        .task {
            tasks = await NetworkService.shared.getTasks()
        }
    }
    
    
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
