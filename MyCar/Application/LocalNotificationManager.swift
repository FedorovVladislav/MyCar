import UserNotifications
import UIKit

class LocalNotificationManager: NSObject {
    
    static let share = LocalNotificationManager()
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    // запрос разрешения на работу уведомлений
    func requestAutorisation(){
        
        notificationCenter.delegate = self
        
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            print("granded: \(granted)")
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    // выполнить уведомление
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
            print (error?.localizedDescription)
        })
    }
    //очиищаем все уведомления
    func deleteBagetCount(){
        // очищаем все уведомления
        UIApplication.shared.applicationIconBadgeNumber = 0
        notificationCenter.removeAllPendingNotificationRequests()
        notificationCenter.removeAllDeliveredNotifications()
    }
    
    private func getNotificationSettings(){
        notificationCenter.getNotificationSettings(completionHandler: { settings  in
            print ("State settings:\(settings)")
        })
    }
}
    
extension LocalNotificationManager: UNUserNotificationCenterDelegate {
    // делагат, чтобы уведомления могли приходть на открытом приложени
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.banner, .sound])
    }
}
