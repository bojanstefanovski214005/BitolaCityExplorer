import SwiftUI

struct SettingsScreen: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("notificationsEnabled") private var notificationsEnabled = false
    @State private var statusMessage: String?

    var body: some View {
        Form {
            Section("Изглед") {
                Toggle("Темна тема", isOn: $isDarkMode)
            }

            Section("Нотификации") {
                Toggle("Дозволи нотификации", isOn: $notificationsEnabled)
                    .onChange(of: notificationsEnabled) { _, newValue in
                        guard newValue else { return }
                        Task {
                            let granted = await NotificationService.shared.requestPermission()
                            if !granted {
                                notificationsEnabled = false
                                statusMessage = "Дозволата за нотификации не е одобрена."
                            }
                        }
                    }

                Button("Испрати test mock нотификација") {
                    Task {
                        do {
                            try await NotificationService.shared.scheduleMockNotification(placeName: "Широк Сокак")
                            notificationsEnabled = true
                            statusMessage = "Нотификацијата е закажана за околу 5 секунди."
                        } catch {
                            statusMessage = error.localizedDescription
                        }
                    }
                }
            }

            Section("Зачувување") {
                LabeledContent("SwiftData", value: "Омилени места")
                LabeledContent("UserDefaults", value: "Тема и нотификации")
            }

            Section("За апликацијата") {
                LabeledContent("Апликација", value: "Bitola City Explorer")
                LabeledContent("Верзија", value: "1.0")
                Text("Проектна iOS апликација изработена со Swift и SwiftUI.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Поставки")
        .alert("Информација", isPresented: Binding(
            get: { statusMessage != nil },
            set: { if !$0 { statusMessage = nil } }
        )) {
            Button("Во ред", role: .cancel) {}
        } message: {
            Text(statusMessage ?? "")
        }
    }
}
