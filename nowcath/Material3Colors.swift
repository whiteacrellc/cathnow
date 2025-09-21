import SwiftUI

extension Color {
    // MARK: - Material 3 Primary Colors
    static let material3Primary = Color(red: 0.392, green: 0.259, blue: 0.839)           // #6442d6
    static let material3OnPrimary = Color.white                                          // #ffffff
    static let material3PrimaryContainer = Color(red: 0.624, green: 0.525, blue: 1.0)   // #9f86ff
    static let material3OnPrimaryContainer = Color(red: 0.102, green: 0.0, blue: 0.322) // #1a0052

    // MARK: - Material 3 Secondary Colors
    static let material3Secondary = Color(red: 0.365, green: 0.365, blue: 0.455)        // #5d5d74
    static let material3OnSecondary = Color.white                                       // #ffffff
    static let material3SecondaryContainer = Color(red: 0.898, green: 0.898, blue: 0.976) // #e5e1f6
    static let material3OnSecondaryContainer = Color(red: 0.196, green: 0.196, blue: 0.275) // #323246

    // MARK: - Material 3 Tertiary Colors
    static let material3Tertiary = Color(red: 0.541, green: 0.365, blue: 0.553)         // #8a5d8d
    static let material3OnTertiary = Color.white                                        // #ffffff
    static let material3TertiaryContainer = Color(red: 0.945, green: 0.827, blue: 0.976) // #f1d3f9
    static let material3OnTertiaryContainer = Color(red: 0.294, green: 0.137, blue: 0.306) // #4b234e

    // MARK: - Material 3 Error Colors
    static let material3Error = Color(red: 1.0, green: 0.384, blue: 0.251)             // #ff6240
    static let material3OnError = Color.white                                          // #ffffff
    static let material3ErrorContainer = Color(red: 1.0, green: 0.855, blue: 0.847)   // #ffDAD6
    static let material3OnErrorContainer = Color(red: 0.325, green: 0.0, blue: 0.059) // #53000F

    // MARK: - Material 3 Surface Colors
    static let material3Surface = Color(red: 0.996, green: 0.984, blue: 1.0)           // #fefbff
    static let material3OnSurface = Color(red: 0.110, green: 0.106, blue: 0.114)       // #1c1b1d
    static let material3SurfaceVariant = Color(red: 0.914, green: 0.898, blue: 0.929)  // #e9e5ed
    static let material3OnSurfaceVariant = Color(red: 0.302, green: 0.259, blue: 0.337) // #4d4256
    static let material3SurfaceContainer = Color(red: 0.969, green: 0.945, blue: 0.965) // #f8f1f6
    static let material3SurfaceContainerHigh = Color(red: 0.949, green: 0.925, blue: 0.933) // #f2ecee

    // MARK: - Material 3 Background Colors
    static let material3Background = Color(red: 0.996, green: 0.984, blue: 1.0)        // #fefbff
    static let material3OnBackground = Color(red: 0.110, green: 0.106, blue: 0.114)    // #1c1b1d

    // MARK: - Material 3 Outline Colors
    static let material3Outline = Color(red: 0.490, green: 0.463, blue: 0.514)         // #7d7686
    static let material3OutlineVariant = Color(red: 0.804, green: 0.769, blue: 0.824)  // #cdc4d2

    // MARK: - Material 3 Special Colors (for medical/caution contexts)
    static let material3Success = Color(red: 0.204, green: 0.745, blue: 0.302)         // #34be4d
    static let material3OnSuccess = Color.white                                        // #ffffff
    static let material3SuccessContainer = Color(red: 0.686, green: 0.976, blue: 0.753) // #aff9c0

    static let material3Warning = Color(red: 1.0, green: 0.808, blue: 0.133)           // #ffce22
    static let material3OnWarning = Color(red: 0.196, green: 0.153, blue: 0.0)         // #322700
    static let material3WarningContainer = Color(red: 1.0, green: 0.918, blue: 0.667)  // #ffea9d

    // MARK: - Material 3 Gradient Combinations
    static let material3PrimaryGradient = LinearGradient(
        colors: [material3Primary, material3PrimaryContainer],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let material3SurfaceGradient = LinearGradient(
        colors: [material3Surface, material3SurfaceContainer],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let material3SecondaryGradient = LinearGradient(
        colors: [material3Secondary, material3SecondaryContainer],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let material3SuccessGradient = LinearGradient(
        colors: [material3Success, material3SuccessContainer],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let material3ErrorGradient = LinearGradient(
        colors: [material3Error, material3ErrorContainer],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

// MARK: - Material 3 Component Styles
struct Material3GroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            configuration.label
                .font(.headline)
                .foregroundStyle(Color.material3Primary)
                .padding(.horizontal, 4)

            configuration.content
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.material3Surface)
                .shadow(color: Color.material3OnSurface.opacity(0.08), radius: 8, x: 0, y: 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.material3Outline.opacity(0.2), lineWidth: 1)
                )
        }
    }
}

// MARK: - Material 3 Button Style
struct Material3ButtonStyle: ButtonStyle {
    let variant: Material3ButtonVariant

    enum Material3ButtonVariant {
        case filled
        case outlined
        case text
        case success
        case error
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(foregroundColor)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: variant == .outlined ? 1 : 0)
            )
            .shadow(color: shadowColor, radius: shadowRadius, x: 0, y: 2)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }

    private var foregroundColor: Color {
        switch variant {
        case .filled:
            return Color.material3OnPrimary
        case .outlined:
            return Color.material3Primary
        case .text:
            return Color.material3Primary
        case .success:
            return Color.material3OnSuccess
        case .error:
            return Color.material3OnError
        }
    }

    private var backgroundColor: some View {
        Group {
            switch variant {
            case .filled:
                Color.material3PrimaryGradient
            case .outlined:
                Color.material3Surface
            case .text:
                Color.clear
            case .success:
                Color.material3SuccessGradient
            case .error:
                Color.material3ErrorGradient
            }
        }
    }

    private var borderColor: Color {
        switch variant {
        case .outlined:
            return Color.material3Outline
        default:
            return Color.clear
        }
    }

    private var shadowColor: Color {
        switch variant {
        case .filled, .success, .error:
            return Color.material3OnSurface.opacity(0.2)
        default:
            return Color.clear
        }
    }

    private var shadowRadius: CGFloat {
        switch variant {
        case .filled, .success, .error:
            return 4
        default:
            return 0
        }
    }
}