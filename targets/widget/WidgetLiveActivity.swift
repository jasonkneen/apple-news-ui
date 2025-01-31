import ActivityKit
import WidgetKit
import SwiftUI

struct WidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var homeScore: Int
        var awayScore: Int
        var timeOrPeriod: String
        var currentEvent: String
        var situation: String
        var homeColor: String
        var awayColor: String
    }
    
    var competition: String
    var homeTeam: String
    var homeTeamNickname: String
    var awayTeam: String
    var awayTeamNickname: String
    var homeLogo: String
    var awayLogo: String
}

struct WidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WidgetAttributes.self) { context in
            ZStack {
                // Background gradient with blur and dark overlay
                ZStack {
                    LinearGradient(
                        colors: [
                            Color(hex: context.state.homeColor) ?? .blue,
                            Color(hex: context.state.awayColor) ?? .red
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .blur(radius: 20)
                    Color.black.opacity(0.3) // Dark overlay
                }
                
                VStack(spacing: 8) {
                    // Top row with competition name
                    Text(context.attributes.competition)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.9))
                    
                    // Main score section
                    HStack(spacing: 12) {
                        // Home team
                        VStack(spacing: 4) {
                            Circle()
                                .fill(Color(hex: context.state.homeColor)?.opacity(0.3) ?? .blue.opacity(0.3))
                                .frame(width: 45, height: 45)
                                .overlay(
                                    Text(context.attributes.homeTeam)
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.white)
                                )
                            
                            Text(context.attributes.homeTeamNickname)
                                .font(.caption)
                                .foregroundColor(.white)
                                .fontWeight(.medium)
                        }
                        
                        Text("\(context.state.homeScore)")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                        
                        // Center section with time/period
                        VStack(spacing: 4) {
                            Text(context.state.timeOrPeriod)
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 10)
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(12)
                        }
                        
                        Text("\(context.state.awayScore)")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                        
                        // Away team
                        VStack(spacing: 4) {
                            Circle()
                                .fill(Color(hex: context.state.awayColor)?.opacity(0.3) ?? .red.opacity(0.3))
                                .frame(width: 45, height: 45)
                                .overlay(
                                    Text(context.attributes.awayTeam)
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.white)
                                )
                            
                            Text(context.attributes.awayTeamNickname)
                                .font(.caption)
                                .foregroundColor(.white)
                                .fontWeight(.medium)
                        }
                    }
                    
                    // Bottom event section
                    if !context.state.currentEvent.isEmpty {
                        HStack(spacing: 8) {
                            Circle()
                                .fill(Color(hex: context.state.homeColor)?.opacity(0.3) ?? .blue.opacity(0.3))
                                .frame(width: 24, height: 24)
                                .overlay(
                                    Text(context.attributes.homeTeam)
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(.white)
                                )
                            
                            Text(context.state.currentEvent)
                                .font(.callout)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top, 4)
                    }
                }
                .padding()
            }
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    ZStack {
                        LinearGradient(
                            colors: [Color(hex: context.state.homeColor) ?? .blue, Color(hex: context.state.homeColor)?.opacity(0.7) ?? .blue.opacity(0.7)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .opacity(0.3)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Circle()
                                .fill(Color(hex: context.state.homeColor)?.opacity(0.3) ?? .blue.opacity(0.3))
                                .frame(width: 24, height: 24)
                                .overlay(
                                    Text(context.attributes.homeTeam)
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(.white)
                                )
                            
                            Text(context.attributes.homeTeam)
                                .font(.caption2)
                                .foregroundColor(.white)
                            Text("\(context.state.homeScore)")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 4)
                    }
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    ZStack {
                        LinearGradient(
                            colors: [Color(hex: context.state.awayColor)?.opacity(0.7) ?? .red.opacity(0.7), Color(hex: context.state.awayColor) ?? .red],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .opacity(0.3)
                        
                        VStack(alignment: .trailing, spacing: 4) {
                            Circle()
                                .fill(Color(hex: context.state.awayColor)?.opacity(0.3) ?? .red.opacity(0.3))
                                .frame(width: 24, height: 24)
                                .overlay(
                                    Text(context.attributes.awayTeam)
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(.white)
                                )
                            
                            Text(context.attributes.awayTeam)
                                .font(.caption2)
                                .foregroundColor(.white)
                            Text("\(context.state.awayScore)")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 4)
                    }
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    VStack(spacing: 8) {
                        Text(context.state.timeOrPeriod)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(12)
                        
                        if !context.state.currentEvent.isEmpty {
                            Text(context.state.currentEvent)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.9))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.vertical, 4)
                }
            } compactLeading: {
                HStack(spacing: 4) {
                    Circle()
                        .fill(Color(hex: context.state.homeColor)?.opacity(0.3) ?? .blue.opacity(0.3))
                        .frame(width: 16, height: 16)
                        .overlay(
                            Text(context.attributes.homeTeam)
                                .font(.system(size: 8, weight: .bold))
                                .foregroundColor(.white)
                        )
                    Text("\(context.state.homeScore)-\(context.state.awayScore)")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            } compactTrailing: {
                Text(context.state.timeOrPeriod)
                    .font(.caption2)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(8)
                    .foregroundColor(.white)
            } minimal: {
                ZStack {
                    Circle()
                        .fill(LinearGradient(
                            colors: [
                                Color(hex: context.state.homeColor) ?? .blue,
                                Color(hex: context.state.awayColor) ?? .red
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                        .frame(width: 24, height: 24)
                    
                    Text("\(context.state.homeScore)-\(context.state.awayScore)")
                        .font(.caption2.bold())
                        .foregroundColor(.white)
                }
            }
            .widgetURL(URL(string: "https://www.apple-news-ui.app/scores"))
            .keylineTint(Color.white)
        }
    }
}

extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }
        
        self.init(
            red: Double((rgb & 0xFF0000) >> 16) / 255.0,
            green: Double((rgb & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgb & 0x0000FF) / 255.0
        )
    }
}

extension WidgetAttributes {
    fileprivate static var preview: WidgetAttributes {
        WidgetAttributes(
            competition: "Premier League",
            homeTeam: "Manchester United",
            homeTeamNickname: "Man Utd",
            awayTeam: "Manchester City",
            awayTeamNickname: "Man City",
            homeLogo: "mun",
            awayLogo: "mci"
        )
    }
}

extension WidgetAttributes.ContentState {
    fileprivate static var firstHalf: WidgetAttributes.ContentState {
        WidgetAttributes.ContentState(
            homeScore: 2,
            awayScore: 1,
            timeOrPeriod: "43'",
            currentEvent: "Fernandes scores! Beautiful finish from the edge of the box",
            situation: "GOAL",
            homeColor: "#DA291C",
            awayColor: "#6CABDD"
        )
    }
    
    fileprivate static var secondHalf: WidgetAttributes.ContentState {
        WidgetAttributes.ContentState(
            homeScore: 2,
            awayScore: 2,
            timeOrPeriod: "78'",
            currentEvent: "Yellow card for Fernandes after a tactical foul",
            situation: "YELLOW_CARD",
            homeColor: "#DA291C",
            awayColor: "#6CABDD"
        )
    }
}

#Preview("Notification", as: .content, using: WidgetAttributes.preview) {
   WidgetLiveActivity()
} contentStates: {
    WidgetAttributes.ContentState.firstHalf
    WidgetAttributes.ContentState.secondHalf
}

