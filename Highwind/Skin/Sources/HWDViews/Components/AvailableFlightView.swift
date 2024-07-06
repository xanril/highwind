//
//  AvailableFlightView.swift
//
//
//  Created by Kristian Mitra on 4/30/24.
//

import SwiftUI

struct AvailableFlightView: View {
    var body: some View {
        VStack {
            HStack {
                Text("SLC")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text("DEN")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity)
            .background(.green)
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    AvailableFlightView()
}
