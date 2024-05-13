//
//  DevicesView.swift
//  PagingLayoutSamples
//
//  Created by Amir Khorsandi on 30/01/2021.
//  Copyright © 2021 Amir Khorsandi. All rights reserved.
//

// Design by Cuberto https://dribbble.com/shots/12580831-Principle-Tutorial-Onboarding-Flow-Animation

import SwiftUI
import CollectionViewPagingLayout

struct Device: Identifiable {
    let name: String
    let iconName: String
    let color: Color

    var id: String {
        name
    }
}

struct DevicesView: View {

    private let devices: [Device] = [
        Device(name: "iPad", iconName: "ipad", color: .yellow),
        Device(name: "Apple Watch", iconName: "applewatch", color: .green),
        Device(name: "iPhone", iconName: "iphone", color: .orange),
        Device(name: "AirPods Pro", iconName: "airpodspro", color: .blue),
        Device(name: "Mac Pro", iconName: "macpro.gen3", color: .red),
        Device(name: "HomePod", iconName: "homepod", color: .purple)
    ]

    private let scaleFactor: CGFloat = 130
    private let circleSize: CGFloat = 80

    @State private var currentDeviceName: String?

    var body: some View {
        TransformPageView(devices, selection: $currentDeviceName) { device, progress in
            ZStack {
                roundedRectangle(device: device, progress: progress)
                deviceView(device: device, progress: progress)
                HStack {
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.white)
                .font(.system(size: 30))
                .transformEffect(.init(translationX: -300 * (progress - 1), y: 0))
                .padding(.top, 400)
                .opacity(1 - Double(abs(progress - 1)))
            }
        }
        .animator(DefaultViewAnimator(0.7, curve: .parametric))
        .scrollToSelectedPage(false)
        .onTapPage { name in
            currentDeviceName = currentDeviceName == devices.last?.name ? devices.first?.name : name
        }
        .zPosition(zPosition)
        .collectionView(\.showsHorizontalScrollIndicator, false)
        .ignoresSafeArea()
    }

    private func deviceView(device: Device, progress: CGFloat) -> some View {
        VStack {
            Image(systemName: device.iconName)
                .font(.system(size: 160))
            Text(device.name)
                .font(.system(size: 40))
                .padding(.top, 10)
            Spacer()
                .frame(maxHeight: 200)
        }
        .frame(maxHeight: .infinity)
        .foregroundColor(.white)
        .transformEffect(.init(translationX: 400 * progress, y: 0))
    }

    private func roundedRectangle(device: Device, progress: CGFloat) -> some View {
        let scale = getScale(progress)
        return RoundedRectangle(cornerRadius: circleSize * ((0.2 * scaleFactor) / scale))
            .fill()
            .frame(width: circleSize, height: circleSize)
            .scaleEffect(scale, anchor: scaleAnchor(progress))
            .transformEffect(.init(translationX: translationX(progress), y: 0))
            .padding(.top, 400)
            .foregroundColor(device.color)
            .opacity((1.25 - max(1, abs(Double(progress)))) / 0.25)
    }

    private func translationX(_ progress: CGFloat) -> CGFloat {
        guard progress >= 1 || progress < -0.5 else { return 0 }
        return -2 * (progress + (progress > 0 ? -1 : 1)) * circleSize
    }

    private func zPosition(_ progress: CGFloat) -> Int {
        if progress < -1 { return 3 }
        if progress < 0 { return 2 }
        if progress < 0.5 { return 1 }
        if progress <= 1 { return 4 }
        if progress < 1.5 { return 2 }
        return -1
    }

    private func getScale(_ progress: CGFloat) -> CGFloat {
        var scale: CGFloat = progress > 1 ? progress - 1 : 1 - progress
        if progress <= -1 {
            scale = -progress - 1
        } else if progress < -0.5 {
            scale = progress + 1
        } else if progress <= 0.5 {
            scale = scaleFactor
        }
        return 1 + scale * scaleFactor
    }

    private func scaleAnchor(_ progress: CGFloat) -> UnitPoint {
        if progress <= -1 { return .leading }
        if progress <= -0.5 { return .trailing }
        if progress < 0.5 { return .center }
        if progress < 1 { return .leading }
        return .trailing
    }
}


struct DevicesView_Previews: PreviewProvider {
    static var previews: some View {
        DevicesView()
            .ignoresSafeArea()
    }
}
