//
//  EventsTableViewController.swift
//  Upcoming Events
//
//  Created by Alexander Camacho on 7/29/19.
//  Copyright © 2019 Alexander Camacho. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController {

    var timeFormatter: DateFormatter { return DateFormatter.hhMMa }

    var events: [[Event]]
    
    init(api: CalendarAPI) {
        events = api.getGroupedEvents()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Events"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // setup custom style of table view
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: EventTableViewCell.identifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return events.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events[section].count
    }
    

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let dateEvent = events[section].first?.dateComponents, let date = Calendar.current.date(from: dateEvent) else {
            return nil
        }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        headerView.backgroundColor = .white
        
        let label = UILabel()
        label.frame = headerView.frame
        label.font = .preferredFont(forTextStyle: .title3)
        label.text = DateFormatter.mmmmDD.string(from: date)
        label.textAlignment = .center
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath) as? EventTableViewCell else {
            fatalError("Couldn't cast to `EventTableViewCell`")
        }
        
        let event = events[indexPath.section][indexPath.row]
        cell.configure(with: event)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: false)
        }
        
        let event = events[indexPath.section][indexPath.row]
        if event.hasConflict {
            let alertController = UIAlertController(title: "Warning", message: "This event has conflicts with previous event", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
}


