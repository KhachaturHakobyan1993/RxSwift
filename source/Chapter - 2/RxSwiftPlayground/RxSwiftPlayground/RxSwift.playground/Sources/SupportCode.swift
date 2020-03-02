import Foundation

public func example(of description: String, action: () -> Void) {
    print("\n--- Example of:", description, "---")
    action()
    
    let event1: EventRx = .next(23)
    let event2: EventRx = .error(NSError())
    let event3: EventRx = .completed

}


public enum EventRx {
    case next(Any)
    
    case error(Swift.Error)
    
    case completed
}
