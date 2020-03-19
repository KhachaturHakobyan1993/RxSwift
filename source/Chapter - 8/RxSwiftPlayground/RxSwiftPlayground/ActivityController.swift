//
//  ActivityController.swift
//  RxSwiftPlayground
//
//  Created by Khachatur Hakobyan on 2/27/20.
//  Copyright © 2020 Khachatur Hakobyan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ActivityController: UITableViewController {
    private let repo = "ReactiveX/RxSwift"
    private let events = Variable<[Event]>([])
    private var disposeBag = DisposeBag()
    
    private enum FileType: String {
        case modified = "modified.txt"
        case events = "events.plist"
        
        var url: URL {
            return FileManager.default
                .urls(for: .cachesDirectory, in: .allDomainsMask)
                .first!
                .appendingPathComponent(self.rawValue)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refresh()
    }
    
    
    private func refresh() {
        DispatchQueue.global(qos: .background).async {
            self.fetchEvents(repo: self.repo)
        }
    }
    
    private func fetchEvents(repo: String) {
        let response = Observable.from([repo])
        
        response
            .map({
                URL(string: "https://api.github.com/repos/\($0)/events")!
            })
            .map({
                URLRequest(url: $0)
            })
            .flatMap({
                URLSession.shared.rx.response(request: $0)
            })
            .filter({
                200..<300 ~= ($0.response.statusCode)
            })
            .map({ response -> Array<Dictionary<String, Any>> in
                
                print(try! JSONSerialization.jsonObject(with: response.data, options: []))
                
                guard let jsonObject = try? JSONSerialization.jsonObject(with: response.data, options: []),
                    let result = jsonObject as? Array<Dictionary<String, Any>> else { return [] }
                
                return result
            })
            .filter({
                !$0.isEmpty
            })
            .map({ objects in
                objects.compactMap(Event.init)
            })
            .subscribe(onNext: { [weak self] (events) in
                self?.processEvents(events)
            })
            .disposed(by: self.disposeBag)
    }
    
    func processEvents(_ newEvents: [Event]) {
        var updatedEvents = newEvents + self.events.value
        
        if updatedEvents.count > 50 {
            updatedEvents = Array<Event>(updatedEvents.prefix(upTo: 50))
        }
        
        self.events.value = updatedEvents
        
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
        
        let eventsArray = updatedEvents.map { $0.dictionary } as NSArray
        eventsArray.write(to: FileType.events.url, atomically: true)
    }
    
    
    // MARK: - Table Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = events.value[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = event.name
        cell.detailTextLabel?.text = event.repo + ", " + event.action.replacingOccurrences(of: "Event", with: "").lowercased()
        cell.imageView?.image = UIImage(data: try! Data(contentsOf: event.imageUrl))
        //cell.imageView?.kf.setImage(with: event.imageUrl, placeholder: UIImage(named: "blank-avatar"))
        return cell
    }
}

