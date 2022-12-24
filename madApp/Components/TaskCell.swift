//
//  TaskCell.swift
//  madApp
//
//  Created by Nikolay Truhin on 24/12/22.
//

import SwiftUI

struct TaskCell: View {
    let task: TaskModel
    
    var borderColor: Color {
        switch task.status.title {
        case .new:
            return .init(uiColor: UIColor(red: 1, green: 0.812, blue: 0.525, alpha: 1))
        case .finished:
            return .init(uiColor: UIColor(red: 0.45, green: 0.683, blue: 0.563, alpha: 1))
        case .progress:
            return .init(uiColor: UIColor(red: 0.971, green: 0.291, blue: 0.291, alpha: 1))
        }
    }
    
    var leftText: String {
        task.status.title.rawValue
    }
    
    var body: some View {
        HStack {
            ZStack {
                borderColor.opacity(0.5)
                VStack(spacing: 5) {
                    Text(leftText).padding(.top, 10)
                    
                    borderColor.frame(height: 1)
                }.frame(width: 500).rotationEffect(.degrees(-90))
            }
            .frame(width: 20)
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
                Text(task.title).font(.custom(.boldFont, size: 20))
                HStack(spacing: 16) {
                    VStack(alignment: .leading) {
                        Text("TIME").font(.custom(.plainFont, size: 18))
                        Text("180 min").font(.custom(.plainFont, size: 18))
                    }
                    Color.black.frame(width: 0.5)
                    VStack(alignment: .leading) {
                        Text("DEADLINE").font(.custom(.plainFont, size: 18))
                        Text("14:00 01.10.2022").font(.custom(.plainFont, size: 18))
                    }
                    Spacer()
                }
                Text("Not completed yet").font(.custom(.plainFont, size: 18))
            }.frame(maxWidth: .infinity, maxHeight: .infinity).padding(16).background(Color.white)
        }
        .cornerRadius(4)
        .background {
            RoundedRectangle(cornerRadius: 4).stroke(borderColor, lineWidth: 2)
        }
        .frame(height: 150)
    }
}

//struct TaskCell_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskCell(task: .init(id: 123, title: "title", description_url: .applicationDirectory, deadline: .now, status: .init(title: .new))).frame(width: 300)
//    }
//}
