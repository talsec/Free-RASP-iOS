//
//  ProtectionMeterView.swift
//  FreeRASP Demo
//
//  Created by TalsecApp on 21/06/2021.
//

import SwiftUI
import Combine

struct ProtectionMeterView: View {

    @State private var markedRisk: ProtectionMeterRiskType?
    @ObservedObject var viewModel: ProtectionStatusViewModel

    var body: some View {
        VStack {
            Text(L.protectionStatusMeterRiskMedium())
                .foregroundColor(markedRisk == .medium ? Color(C.riskColorMedium.name) : .white)
                .font(markedRisk == .medium ? .body.bold() : .body)
            Button(action: {
                viewModel.tapOnStart()
            }) {
                ProtectionMeterCircleView(viewModel: viewModel)
            }
            HStack {
                Text(L.protectionStatusMeterRiskHigh())
                    .foregroundColor(markedRisk == .high ? Color(C.riskColorHigh.name) : .white)
                    .font(markedRisk == .high ? .body.bold() : .body)
                Spacer()
                Text(L.protectionStatusMeterRiskLow())
                    .foregroundColor(markedRisk == .low ? Color(C.riskColorLow.name) : .white)
                    .font(markedRisk == .low ? .body.bold() : .body)
            }
        }
        .padding()
        .background(
            LinearGradient(gradient: viewModel.backgroundGradient,
                           startPoint: .leading,
                           endPoint: .trailing)
        )
        .cornerRadius(12)
        .onReceive(viewModel.$meterState, perform: { value in
            switch value {
            case .none:
                markedRisk = nil
            case .score(let riskType, _):
                markedRisk = riskType
            }
        })
    }
}
