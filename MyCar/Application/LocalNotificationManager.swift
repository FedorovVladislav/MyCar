import Foundation
import UserNotifications
import UIKit

class LocalNotificationManager{
    
    static let share = LocalNotificationManager()
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestAutorisation(){
        
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            print("granded: \(granted)")
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    private func getNotificationSettings(){
        notificationCenter.getNotificationSettings(completionHandler: { settings  in
            print ("State settings:\(settings)")
        })
    }
    
    func getNotification(state: String){
        
        let content = UNMutableNotificationContent()
        content.title = "State Changed"
        content.sound = .default
        content.badge = (UIApplication.shared.applicationIconBadgeNumber + 1) as NSNumber
        content.body = state
        
        let notificationIdentifier = "ChangeStateCat"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: notificationIdentifier,
                                            content: content,
                                            trigger: trigger)
        
        notificationCenter.add(request, withCompletionHandler: { error in
            print (error)
        })
    }
    
    func deleteBagetCount(){
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
}
    
