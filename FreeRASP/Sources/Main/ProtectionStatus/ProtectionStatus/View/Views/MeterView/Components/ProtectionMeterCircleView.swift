//
//  ProtectionMeterCircleView.swift
//  FreeRASP Demo
//
//  Created by TalsecApp on 22/06/2021.
//

import SwiftUI
import Combine

struct ProtectionMeterCircleView: View {

    @ObservedObject var viewModel: ProtectionStatusViewModel

    @State private var startOpacity = 1.0
    @State private var timers = [Timer]()
    @State private var animationDegrees = -90.0

    var body: some View {
        ZStack { 
            Circle()
                .fill(Color(C.blueBlack.name))
                .frame(width: 110, height: 110, alignment: .center)

            Circle()
                .trim(from: 0, to: 0.8)
                .rotation(.degrees(125))
                .stroke(
                    AngularGradient(gradient: viewModel.meterGradient,
                                    center: .center,
                                    startAngle: .degrees(-170),
                                    endAngle: .degrees(60)),
                    style: .init(lineWidth: 20, lineCap: .butt, lineJoin: .round, miterLimit: 0, dash: [], dashPhase: 0)
                )
                .padding(10)
                .scaledToFit()

            ProtectionMeterArrowView()
                .rotationEffect(Angle(degrees: viewModel.meterArrowDegrees))

            Text(viewModel.meterState.title)
                .opacity(startOpacity)
                .onReceive(viewModel.$loading, perform: { value in
                    withAnimation(.easeOut) {
                        value ?
                            (startOpacity = 0) :
                            (startOpacity = 1)
                    }
                })
                .font(.title.bold())
                .foregroundColor(.white)

            Circle()
                .trim(from: 0.0, to: 0.0001)
                .rotation(Angle(degrees: animationDegrees))
                .stroke(Color.white, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round, miterLimit: 20, dash: [], dashPhase: 0))
                .padding(5)
                .opacity(viewModel.loading ? 1.0 : 0.0)
                .animation(.easeInOut, value: viewModel.loading)
                .padding(30)
                .onReceive(viewModel.$loading, perform: { value in
                    if value {
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                            self.animationDegrees = -90

                            withAnimation(.easeInOut(duration: 0.40)) {
                                animationDegrees = 90
                            }

                            self.timers.append(timer)
                        }
                        .fire()

                        Timer.scheduledTimer(withTimeInterval: 0.50, repeats: false) { _ in
                            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                                withAnimation(.easeInOut(duration: 0.40)) {
                                    animationDegrees = 270.0
                                }

                                self.timers.append(timer)
                            }.fire()
                        }
                    } else {
                        timers.forEach { $0.invalidate() }
                    }
                })
        }
        .frame(width: 175, height: 150, alignment: .center)

    }
}
