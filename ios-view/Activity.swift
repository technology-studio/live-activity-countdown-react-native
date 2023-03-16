//
//  Activity.swift
//  LiveActivityCountdownView
//
//  Created by Erik Slovák on 15/12/2022.
//

import ActivityKit
import WidgetKit
import SwiftUI

public struct LiveActivityCountdownWidgetExtensionAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        public init() {}
    }

    // Fixed non-changing properties about your activity go here!
    public var title: String
    public var timerTitle: String
    public var imageName: String
    public var timerColor: String?
    public var timer: ClosedRange<Date> = Date(timeIntervalSinceNow: 0)...Date(timeIntervalSinceNow: 0)
    public init(title: String, timerTitle: String, secondsUntilEnd: Double, timerColor: String?, imageName: String?) {
        self.title = title
        self.timerTitle = timerTitle
        self.timer = Date()...Date(timeIntervalSinceNow: secondsUntilEnd)
        self.timerColor = timerColor ?? nil
        self.imageName = imageName ?? "AppIconLiveActivity"
    }
}

public struct LiveActivityCountdownWidgetExtensionLiveActivity: Widget {
    public init() {}
    public var body: some WidgetConfiguration {
        if #available(iOSApplicationExtension 16.1, *) {
            return ActivityConfiguration(for: LiveActivityCountdownWidgetExtensionAttributes.self) { context in
                // Lock screen/banner UI goes here
                VStack {
                    HStack {
                        Image(context.attributes.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                        Spacer()
                        Image(systemName: "timer.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                            .foregroundColor(Color(hex: context.attributes.timerColor))
                    }
                    VStack {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                Text(context.attributes.title)
                                    .lineLimit(2)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("Time to unlock")
                                Text(timerInterval: context.attributes.timer, countsDown: true)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(Color(hex: context.attributes.timerColor))
                            }
                        }
                    }
                }
                .padding()
                
            } dynamicIsland: { context in
                DynamicIsland {
                    // Expanded UI goes here.  Compose the expanded UI through
                    // various regions, like leading/trailing/center/bottom
                    DynamicIslandExpandedRegion(.leading) {
                        Image(context.attributes.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                    }
                    DynamicIslandExpandedRegion(.trailing) {
                        HStack {
                            Image(systemName: "timer.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                                .foregroundColor(Color(hex: context.attributes.timerColor))
                        }
                        .frame(alignment: .center)
                    }
                    DynamicIslandExpandedRegion(.bottom) {
                        VStack {
                            HStack(alignment: .top) {
                                VStack {
                                    Text(context.attributes.title)
                                        .lineLimit(2)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                VStack(alignment: .trailing) {
                                    Text("Time to unlock")
                                    Text(timerInterval: context.attributes.timer, countsDown: true)
                                        .multilineTextAlignment(.trailing)
                                        .foregroundColor(Color(hex: context.attributes.timerColor))
                                }
                            }
                            VStack {
                                Button {
                                    
                                } label: {
                                    Label("Open App", systemImage: "iphone.and.arrow.forward")
                                        .font(.body.bold())
                                }
                                .padding(.vertical, 4)
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color(hex: context.attributes.timerColor) ?? .accentColor)
                                        .opacity(0.3)
                                )
                                .foregroundColor(Color(hex: context.attributes.timerColor))
                            }
                        }
                    }
                } compactLeading: {
                    Image(context.attributes.imageName)
                        .resizable()
                        .scaledToFit()
                } compactTrailing: {
                    Text(timerInterval: context.attributes.timer, countsDown: true)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(Color(hex: context.attributes.timerColor))
                        .frame(maxWidth: 64)
                } minimal: {
                    Image(context.attributes.imageName)
                        .resizable()
                        .scaledToFit()
                }
            }
        } else {
            // Fallback on earlier versions
            return EmptyWidgetConfiguration()
        }
    }
}
