//
//  LiveActivityCountdownWidgetExtensionBundle.swift
//  LiveActivityCountdownWidgetExtension
//
//  Created by Erik Slovák on 15/12/2022.
//

import WidgetKit
import SwiftUI
import LiveActivityCountdownView

@main
struct LiveActivityCountdownWidgetExtensionBundle: WidgetBundle {
    var body: some Widget {
      LiveActivityCountdownWidgetExtensionLiveActivity()
    }
}
