//
//  SummaryInterfaceController.swift
//  Just Do It
//
//  Created by Pavel Shadrin on 20/06/2017.
//  Copyright © 2017 Pavel Shadrin. All rights reserved.
//

import WatchKit

class SummaryInterfaceController: WKInterfaceController {
    
    var results: WorkoutResults?

    @IBOutlet var summaryLabel: WKInterfaceLabel!
    @IBOutlet var timer: WKInterfaceTimer!
    @IBOutlet var caloriesLabel: WKInterfaceLabel!
    @IBOutlet var averageHeartRateLabel: WKInterfaceLabel!
    @IBOutlet var maxHeartRateLabel: WKInterfaceLabel!
    
    var summaryText: String?
    
    let positiveEmoji = ["👍🏻", "👏🏻", "🥇", "🤘🏻", "✌🏻", "🏅", "🏆", "💪🏻", "😍", "😎"]
    
    
    // MARK: - Life Cycle
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if let r = context as? WorkoutResults {
            results = r
        }

        generateSummaryText()
    }
    
    override func willActivate() {
        super.willActivate()
        
        updateLabels()
    }
    
    override func didAppear() {
        super.didAppear()
        
        self.setTitle(results?.config.title)
    }
    
    
    // MARK: - Actions
    
    @IBAction func close() {
        WKInterfaceController.reloadRootControllers(withNames: ["SetupInterfaceController"], contexts: [])
    }
    
    
    // MARK: - Private
    
    private func generateSummaryText() {
        summaryText = positiveEmoji.randomElement()
    }
    
    private func updateLabels() {
        summaryLabel.setText(summaryText)
        
        if let d = results?.duration {
            timer.setDate(Date(timeIntervalSinceNow: d))
        }
        
        if let c = results?.calories {
            caloriesLabel.setText(c > 0 ? "\(c)" : "--")
        }
        
        if let a = results?.averageHeartRate {
            averageHeartRateLabel.setText(a > 0 ? "\(a)" : "--")
        }
        
        if let m = results?.maxHeartRate {
            maxHeartRateLabel.setText(m > 0 ? "\(m)" : "--")
        }
    }
}
