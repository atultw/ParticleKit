# Particles

Simple and extensible particle emitter!

Useful for confetti, feedback to user actions etc

![Demo](https://i.ibb.co/pwBsXNV/Screen-Recording-2022-01-10-at-8-01-51-PM.gif)

## Features

* Supports both SwiftUI and UIKit
* Built-in particles like `Emoji`
* Public `Particle` protocol to easily make your own
* Clean and configurable API: Customize as much as you want
* Safe: no optional unwraps!

## Usage

See `Examples/Example.swift` for an example SwiftUI implementation.

Built-in `Emoji` particle for common use cases like confetti


## Contributing

If you want to add a feature or help out, check out the Issues tab to get started.

## Philosophy

This is based on the emitter I used in my app, Stride. It's meant to be simple. If you have a complex use case like multiple particles from different points or custom backgrounds, most of it can be done using SwiftUI modifiers + overlay or UIKit properties. If there is an addition that's globally useful please open an issue/PR.


## FAQ

* My tap gestures aren't working! -> if you overlayed this on another view make sure to use `allowsHitTesting(false)`
