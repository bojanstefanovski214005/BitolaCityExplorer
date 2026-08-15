import Foundation
import LocalAuthentication

@MainActor
final class AuthService: ObservableObject {
    @Published private(set) var isAuthenticated = false
    @Published private(set) var isAuthenticating = false
    @Published private(set) var errorMessage: String?

    func authenticateWithFaceID() async {
        guard !isAuthenticating else { return }
        isAuthenticating = true
        errorMessage = nil
        defer { isAuthenticating = false }

        let context = LAContext()
        context.localizedCancelTitle = "Откажи"

        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            errorMessage = error?.localizedDescription ?? "Биометриска автентикација не е достапна."
            return
        }

        guard context.biometryType == .faceID else {
            errorMessage = "На овој уред FaceID не е достапен."
            return
        }

        do {
            let success = try await context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: "Отклучи ги омилените места со FaceID."
            )
            isAuthenticated = success
            if !success {
                errorMessage = "FaceID автентикацијата не успеа."
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func lock() {
        isAuthenticated = false
    }
}
