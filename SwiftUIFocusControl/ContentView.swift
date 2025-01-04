import SwiftUI

struct ContentView : View {
    var body: some View {
        MyScrollView {
            VStack(alignment: .leading) {
                ForEach(1...20, id: \.self) { i in
                    MyOption(num: i)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .frame(width: 400, height: 200)
    }
}

struct MyOption : View {
    let num : Int
    @State var isOn : Bool = true

    // This sweet, innocent view is just trying to show a checkbox option. It
    // doesn't ever want to draw a focus ring around the checkbox, so it has both
    // .focusable(false) and .focusEffectDisabled(true) modifiers. And yet! Run
    // this app and see how the top checkbox has a focus ring drawn around it!
    // Then see what you can to do stop it from happening!
    //
    // Also notice that it doesn't happen in the Xcode preview! It only happens
    // in the actual, running app.
    var body: some View {
        Toggle(isOn: $isOn) {
            Text(num == 1 ?
                 "Why is there a focus ring around this checkbox?!" :
                 "Option \(num)"
            )
        }
        .toggleStyle(.checkbox)
        .focusable(false)
        .focusEffectDisabled(true)
    }
}

// This is a ScrollView that supports home and end keypresses. To do that, it has
// to have the input focus. The initial focus state is controlled by the
// initialFocus parameter. When it does have focus, I don't want to see a "focus
// ring" drawn around the whole ScrollView, so focusEffectDisabled() is called,
// passing the focusEffect boolean which defaults to false.
struct MyScrollView<Content : View>  : View {
    let initialFocus : Bool
    let focusEffect : Bool
    var content : Content

    @FocusState private var isFocused : Bool

    @State private var scrollPosition = ScrollPosition(x: 0, y: 0)

    var body : some View {
        ScrollView {
            content
        }
        .scrollPosition($scrollPosition)
        .focusable()
        .focused($isFocused)
        .focusEffectDisabled(!focusEffect)
        .onAppear {
            isFocused = initialFocus
        }
        .onKeyPress(.home) {
            scrollPosition.scrollTo(edge: .top)
            return .handled
        }
        .onKeyPress(.end) {
            scrollPosition.scrollTo(edge: .bottom)
            return .handled
        }
    }

    init(initialFocus: Bool = true, focusEffect: Bool = false, @ViewBuilder content: () -> Content) {
        self.initialFocus = initialFocus
        self.focusEffect = focusEffect
        self.content = content()
    }
}

#Preview {
    ContentView()
}
