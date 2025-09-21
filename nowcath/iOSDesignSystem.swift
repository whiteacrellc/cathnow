import SwiftUI

// MARK: - iOS Design System Colors
extension Color {
    // MARK: - iOS System Colors (Light Mode)
    static let iosSystemBlue = Color(red: 0.0, green: 0.478, blue: 1.0)           // #007AFF
    static let iosSystemGreen = Color(red: 0.204, green: 0.780, blue: 0.349)      // #34C759
    static let iosSystemIndigo = Color(red: 0.345, green: 0.337, blue: 0.839)     // #5856D6
    static let iosSystemOrange = Color(red: 1.0, green: 0.584, blue: 0.0)         // #FF9500
    static let iosSystemPink = Color(red: 1.0, green: 0.176, blue: 0.333)         // #FF2D55
    static let iosSystemPurple = Color(red: 0.686, green: 0.322, blue: 0.871)     // #AF52DE
    static let iosSystemRed = Color(red: 1.0, green: 0.231, blue: 0.188)          // #FF3B30
    static let iosSystemTeal = Color(red: 0.188, green: 0.690, blue: 0.780)       // #30B0C7
    static let iosSystemYellow = Color(red: 1.0, green: 0.800, blue: 0.0)         // #FFCC00

    // MARK: - iOS Gray Colors
    static let iosSystemGray = Color(red: 0.557, green: 0.557, blue: 0.576)       // #8E8E93
    static let iosSystemGray2 = Color(red: 0.682, green: 0.682, blue: 0.698)      // #AEAEB2
    static let iosSystemGray3 = Color(red: 0.780, green: 0.780, blue: 0.800)      // #C7C7CC
    static let iosSystemGray4 = Color(red: 0.820, green: 0.820, blue: 0.839)      // #D1D1D6
    static let iosSystemGray5 = Color(red: 0.898, green: 0.898, blue: 0.918)      // #E5E5EA
    static let iosSystemGray6 = Color(red: 0.949, green: 0.949, blue: 0.969)      // #F2F2F7

    // MARK: - iOS Background Colors
    static let iosSystemBackground = Color(red: 1.0, green: 1.0, blue: 1.0)       // #FFFFFF
    static let iosSecondarySystemBackground = Color(red: 0.949, green: 0.949, blue: 0.969) // #F2F2F7
    static let iosTertiarySystemBackground = Color(red: 1.0, green: 1.0, blue: 1.0) // #FFFFFF

    // MARK: - iOS Grouped Background Colors
    static let iosSystemGroupedBackground = Color(red: 0.949, green: 0.949, blue: 0.969) // #F2F2F7
    static let iosSecondarySystemGroupedBackground = Color(red: 1.0, green: 1.0, blue: 1.0) // #FFFFFF
    static let iosTertiarySystemGroupedBackground = Color(red: 0.949, green: 0.949, blue: 0.969) // #F2F2F7

    // MARK: - iOS Label Colors
    static let iosLabel = Color(red: 0.0, green: 0.0, blue: 0.0)                  // #000000
    static let iosSecondaryLabel = Color(red: 0.235, green: 0.235, blue: 0.263)   // #3C3C43 (60% opacity)
    static let iosTertiaryLabel = Color(red: 0.235, green: 0.235, blue: 0.263)    // #3C3C43 (30% opacity)
    static let iosQuaternaryLabel = Color(red: 0.235, green: 0.235, blue: 0.263)  // #3C3C43 (18% opacity)

    // MARK: - iOS Fill Colors
    static let iosSystemFill = Color(red: 0.471, green: 0.471, blue: 0.502)       // #78788A (20% opacity)
    static let iosSecondarySystemFill = Color(red: 0.471, green: 0.471, blue: 0.502) // #78788A (16% opacity)
    static let iosTertiarySystemFill = Color(red: 0.463, green: 0.463, blue: 0.502)  // #767680 (12% opacity)
    static let iosQuaternarySystemFill = Color(red: 0.463, green: 0.463, blue: 0.502) // #767680 (8% opacity)

    // MARK: - iOS Separator Colors
    static let iosSeparator = Color(red: 0.235, green: 0.235, blue: 0.263)        // #3C3C43 (29% opacity)
    static let iosOpaqueSeparator = Color(red: 0.780, green: 0.780, blue: 0.784)  // #C6C6C8

    // MARK: - Medical App Specific Colors (iOS-style)
    static let iosMedicalPrimary = Color.iosSystemBlue
    static let iosMedicalSecondary = Color.iosSystemTeal
    static let iosMedicalSuccess = Color.iosSystemGreen
    static let iosMedicalWarning = Color.iosSystemOrange
    static let iosMedicalError = Color.iosSystemRed
    static let iosMedicalInfo = Color.iosSystemIndigo

    // MARK: - iOS Gradients
    static let iosPrimaryGradient = LinearGradient(
        colors: [Color.iosSystemBlue, Color.iosSystemBlue.opacity(0.8)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let iosBackgroundGradient = LinearGradient(
        colors: [Color.iosSystemBackground, Color.iosSecondarySystemBackground],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let iosSuccessGradient = LinearGradient(
        colors: [Color.iosSystemGreen, Color.iosSystemGreen.opacity(0.8)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let iosErrorGradient = LinearGradient(
        colors: [Color.iosSystemRed, Color.iosSystemRed.opacity(0.8)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

// MARK: - iOS Typography System
extension Font {
    // MARK: - iOS Large Title
    static let iosLargeTitle = Font.system(size: 34, weight: .regular, design: .default)
    static let iosLargeTitleEmphasized = Font.system(size: 34, weight: .bold, design: .default)

    // MARK: - iOS Title Styles
    static let iosTitle1 = Font.system(size: 28, weight: .regular, design: .default)
    static let iosTitle1Emphasized = Font.system(size: 28, weight: .bold, design: .default)
    static let iosTitle2 = Font.system(size: 22, weight: .regular, design: .default)
    static let iosTitle2Emphasized = Font.system(size: 22, weight: .bold, design: .default)
    static let iosTitle3 = Font.system(size: 20, weight: .regular, design: .default)
    static let iosTitle3Emphasized = Font.system(size: 20, weight: .semibold, design: .default)

    // MARK: - iOS Headline and Body
    static let iosHeadline = Font.system(size: 17, weight: .semibold, design: .default)
    static let iosBody = Font.system(size: 17, weight: .regular, design: .default)
    static let iosBodyEmphasized = Font.system(size: 17, weight: .semibold, design: .default)
    static let iosCallout = Font.system(size: 16, weight: .regular, design: .default)
    static let iosCalloutEmphasized = Font.system(size: 16, weight: .semibold, design: .default)

    // MARK: - iOS Small Text
    static let iosSubheadline = Font.system(size: 15, weight: .regular, design: .default)
    static let iosSubheadlineEmphasized = Font.system(size: 15, weight: .semibold, design: .default)
    static let iosFootnote = Font.system(size: 13, weight: .regular, design: .default)
    static let iosFootnoteEmphasized = Font.system(size: 13, weight: .semibold, design: .default)
    static let iosCaption1 = Font.system(size: 12, weight: .regular, design: .default)
    static let iosCaption1Emphasized = Font.system(size: 12, weight: .medium, design: .default)
    static let iosCaption2 = Font.system(size: 11, weight: .regular, design: .default)
    static let iosCaption2Emphasized = Font.system(size: 11, weight: .medium, design: .default)
}

// MARK: - iOS Spacing System
struct iOSSpacing {
    static let xxs: CGFloat = 2
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 20
    static let xxl: CGFloat = 24
    static let xxxl: CGFloat = 32
    static let huge: CGFloat = 48
}

// MARK: - iOS Component Styles
struct iOSGroupBoxStyle: GroupBoxStyle {
    @EnvironmentObject var themeManager: ThemeManager

    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: iOSSpacing.md) {
            configuration.label
                .font(.iosHeadline)
                .foregroundStyle(Color.adaptivePrimary(themeManager))
                .padding(.horizontal, iOSSpacing.xs)

            configuration.content
        }
        .padding(iOSSpacing.lg)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.adaptiveSurface(themeManager))
                .shadow(color: Color.adaptiveOnSurface(themeManager).opacity(0.1), radius: 4, x: 0, y: 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(Color.adaptiveOutline(themeManager).opacity(0.2), lineWidth: 0.5)
                )
        }
    }
}

// MARK: - iOS Button Styles
struct iOSButtonStyle: ButtonStyle {
    let variant: iOSButtonVariant
    let isDestructive: Bool

    enum iOSButtonVariant {
        case filled
        case tinted
        case plain
        case bordered
    }

    init(variant: iOSButtonVariant, isDestructive: Bool = false) {
        self.variant = variant
        self.isDestructive = isDestructive
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.iosBody)
            .foregroundStyle(foregroundColor(isPressed: configuration.isPressed))
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(backgroundColor(isPressed: configuration.isPressed))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(borderColor, lineWidth: variant == .bordered ? 1 : 0)
            )
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }

    private func foregroundColor(isPressed: Bool) -> Color {
        let baseColor: Color
        switch variant {
        case .filled:
            baseColor = .white
        case .tinted:
            baseColor = isDestructive ? .iosSystemRed : .iosMedicalPrimary
        case .plain:
            baseColor = isDestructive ? .iosSystemRed : .iosMedicalPrimary
        case .bordered:
            baseColor = isDestructive ? .iosSystemRed : .iosMedicalPrimary
        }
        return isPressed ? baseColor.opacity(0.6) : baseColor
    }

    private func backgroundColor(isPressed: Bool) -> some View {
        Group {
            switch variant {
            case .filled:
                let color = isDestructive ? Color.iosSystemRed : Color.iosMedicalPrimary
                (isPressed ? color.opacity(0.8) : color)
            case .tinted:
                let color = isDestructive ? Color.iosSystemRed : Color.iosMedicalPrimary
                (isPressed ? color.opacity(0.2) : color.opacity(0.15))
            case .plain:
                (isPressed ? Color.iosSystemFill.opacity(0.2) : Color.clear)
            case .bordered:
                (isPressed ? Color.iosSystemFill.opacity(0.1) : Color.clear)
            }
        }
    }

    private var borderColor: Color {
        switch variant {
        case .bordered:
            return isDestructive ? .iosSystemRed : .iosMedicalPrimary
        default:
            return .clear
        }
    }
}

// MARK: - iOS Card Style
struct iOSCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.iosSecondarySystemGroupedBackground)
                    .shadow(color: Color.iosSystemFill.opacity(0.08), radius: 8, x: 0, y: 4)
            }
    }
}

extension View {
    func iOSCardStyle() -> some View {
        modifier(iOSCardModifier())
    }
}

// MARK: - iOS Input Field Style
struct iOSTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.iosBody)
            .padding(iOSSpacing.md)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.iosTertiarySystemFill)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(Color.iosSeparator.opacity(0.3), lineWidth: 1)
                    )
            }
    }
}

// MARK: - iOS List Row Style
struct iOSListRowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowBackground(Color.iosSecondarySystemGroupedBackground)
            .listRowSeparator(.hidden)
    }
}

extension View {
    func iOSListRowStyle() -> some View {
        modifier(iOSListRowModifier())
    }
}