//
//  PopularityGadgetView.swift
//  StateManagement
//
//  Created by Fišer Jakub on 24.02.2023.
//

import SwiftUI

struct PopularityGadgetView: View {
    let popularity: Double?
    var size: Size = .small

    let lineWidth: Double = 3

    var popularityString: String {
        guard let popularity else { return "N/A" }
        return "\(Int(popularity * 100))%"
    }

    var gadgetStyle: StrokeStyle {
        var style = StrokeStyle()
        style.lineCap = .round
        style.lineWidth = lineWidth + 2
        return style
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.systemBackground.opacity(0.9))

            Group {
                Circle()
                    .stroke(Color.primary.opacity(0.6), lineWidth: lineWidth)

                Circle()
                    .trim(from: 0, to: popularity ?? 0)
                    .stroke(Color.purple, style: gadgetStyle)
                    .rotationEffect(.degrees(-90))

                Text(popularityString)
                    .font(size.font)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
            .padding(4)
        }
        .frame(width: size.rawValue, height: size.rawValue)
    }

    enum Size: Double {
        case small = 44
        case large = 60

        var viewSize: Double {
            rawValue
        }

        var font: SwiftUI.Font {
            switch self {
            case .small: return .caption2
            case .large: return .callout
            }
        }
    }
}

struct PopularityGadgetView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            PopularityGadgetView(popularity: nil)
            PopularityGadgetView(popularity: 0.3)
            PopularityGadgetView(popularity: 0.75)
        }
        .padding()
        .background(Color.systemBackground)
        .injectMockEnvironment()
    }
}
