import Foundation
import UserNotifications

final class NotificationService {
    static let shared = NotificationService()
    private let center = UNUserNotificationCenter.current()

    private init() {}

    func requestPermission() async -> Bool {
        do {
            return try await center.requestAuthorization(options: [.alert, .sound, .badge])
        } catch {
            print("Notification permission error: \(error.localizedDescription)")
            return false
        }
    }

    func scheduleMockNotification(placeName: String) async throws {
        var settings = await center.notificationSettings()

        if settings.authorizationStatus == .notDetermined {
            _ = await requestPermission()
            settings = await center.notificationSettings()
        }

        guard settings.authorizationStatus == .authorized || settings.authorizationStatus == .provisional else {
            throw NotificationError.permissionDenied
        }

        let content = UNMutableNotificationContent()
        content.title = "Bitola City Explorer"
        content.body = "Предлог за посета: \(placeName). Отвори ја апликацијата за повеќе детали."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        try await center.add(request)
    }

    enum NotificationError: LocalizedError {
        case permissionDenied

        var errorDescription: String? {
            "Нотификациите не се дозволени. Вклучи ги во Settings."
        }
    }
}
