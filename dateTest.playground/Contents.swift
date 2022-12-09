import UIKit

extension Date {
    // mo, y, d, w
    var toRecentDays: String {
        let timeInterval = abs(self.timeIntervalSince(Date.now))
        let minute: TimeInterval = 60
        let hour: TimeInterval = 3600
        let day: TimeInterval = 86_400
        let week: TimeInterval = 604_800
        let month: TimeInterval = 2_678_400
        let year: TimeInterval = 31_536_000
        switch timeInterval {
        case let gap where gap < minute:
            return "\(Int(timeInterval))s ago"
        case let gap where gap < hour:
            return "\(Int(timeInterval / minute))m ago"
        case let gap where gap < day:
            return "\(Int(timeInterval / hour))h ago"
        case let gap where gap < week:
            return "\(Int(timeInterval / day))d ago"
        case let gap where gap < month:
            return "\(Int(timeInterval / week))w ago"
        case let gap where gap < year:
            return "\(Int(timeInterval / month))mo ago"
        default:
            return "\(Int(timeInterval / year))y ago"
        }
    }
}

var dComponent = DateComponents()
dComponent.year = 2022
dComponent.month = 11
dComponent.day = 10
let earlierDate = Calendar.current.date(from: dComponent)!
print(earlierDate.toRecentDays)
