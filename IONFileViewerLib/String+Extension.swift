import Foundation

extension String {
    func isValidUrl() -> Bool {
        let regex = "http[s]?://(([^/:.[:space:]]+(.[^/:.[:space:]]+)*)|([0-9](.[0-9]{3})))(:[0-9]+)?((/[^?#[:space:]]+)([^#[:space:]]+)?(#.+)?)?"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
}
