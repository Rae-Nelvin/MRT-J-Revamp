# MRT-J-Revamp

This innovative iOS application reimagines the Jakarta MRT experience, offering a sleek and user-friendly interface built with SwiftUI and a robust back-end powered by Laravel. It streamlines the ticketing process, enhances navigation, and provides real-time information for a smooth and stress-free commute. By combining innovative design and cutting-edge technology, this Jakarta MRT app empowers users to navigate the city's public transport system with confidence and ease. It sets a new standard for efficiency and convenience, ensuring a smooth and stress-free commute for all.

## Table of Contents

- [Features](#features)

- [Technical Stack](#technical-stack)

- [Benefits](#benefits)

- [Installation](#installation)

    - [Prerequisites](#prerequisites)

    - [Clone the Repository](#clone-the-repository)

    - [Build and Run](#build-and-run)

- [Contributing](#contributing)

- [Future Enchanements](#future-enhancements)

- [License](#license)

## Features

List the key of features of MRT-J-Revamp:

-   Modern Design (SwiftUI): The app boasts a clean and intuitive interface designed with SwiftUI, making navigation and information access effortless.

-   Seamless Ticketing: Forget physical tickets! Users can purchase tickets directly within the app and generate unique barcodes using CoreImage.

-   Barcode-Based Entry and Exit (CoreLocation): Simply scan the displayed barcode at entry and exit gates. The app leverages CoreLocation to verify user proximity to MRT terminals and ensure ticket validity.

-   One-Time Entry (Current Stage): For now, each barcode is valid for a single entry. Future development plans to address re-entry with dynamic barcode updates.

-   Real-Time Train Schedules: Stay informed with up-to-date train schedules displayed directly within the app.

-   Smart Navigation (CoreLocation): Never miss a stop! CoreLocation pinpoints the user's location and suggests the closest MRT terminal.

## Technical Stack

-   SwiftUI: Creates a visually appealing and user-friendly front-end experience.

-   Laravel: Provides a robust back-end for user authentication, ticket management, barcode generation, and real-time data processing.

-   CoreImage: Generates unique and secure barcodes for ticketing.

-   CoreLocation: Enables location-based services for proximity verification and suggesting nearby terminals.

## Benefits

-   Enhanced Convenience: Effortless ticketing, barcode-based entry/exit, and real-time information streamline the entire MRT journey.

-   Reduced Wait Times: Skip ticket lines and breeze through entry/exit gates using barcodes.

-   Improved Navigation: Locate the nearest MRT terminal with ease using location services.

-   Informed Decisions: Stay on schedule with up-to-date train information.

## Installation

Follow these steps to install and run MRT-J-Revamp on your system.

### Prerequisites

Before you begin, ensure you have the following dependencies and tools installed:

- [XCode](https://developer.apple.com/xcode/)

- [Composer](https://getcomposer.org/)

- [NPM](https://www.npmjs.com/)

- [Laravel](https://laravel.com/)

- [XAMPP](https://www.apachefriends.org/download.html)

### Clone the Repository

1. Open your terminal or command prompt.

2. Use the following command to clone the MRT-J-Revamp repository:

git clone https://github.com/Rae-Nelvin/MRT-J-Revamp.git

3. cd RESTful-API

4. Make the database in the xampp

5. Use the following command to setup the Laravel RESTful-API:

composer install

composer update

cp .env.example .env

insert the database credentials to .env

php artisan key:generate

php artisan migrate

php artisan key:generate

php artisan serve

6. Open the MRT-J-Revamp.xcodeproj

7. Change the Bundle Identifier to match your own Bundle Identifier.

### Build and Run

1. Connect your device or start an emulator.

2. To build and run the project, simply just click play button on the top left of the XCode and let it build to the emulator or your own device.

## Future Enhancements

-   Dynamic Barcodes: Implement dynamic barcodes that can be scanned for both entry and exit, eliminating the need for single-use codes.

-   Multi-Journey Tickets: Introduce options for purchasing multi-journey tickets for frequent riders.

-   Integrated Payment System: Allow seamless in-app wallet top-ups for ticket purchases.

-   Accessibility Features: Integrate features like voice guidance and screen reader compatibility for an inclusive user experience.

## Contributing

Since it's just a prototype project, I don't expect any contributions to MRT-J-Revamp.

Thank you for choosing MRT-J-Revamp! If you encounter any issues or have suggestions for improvements, please don't hesitate to [create an issue](https://github.com/Rae-Nelvin/MRT-J-Revamp/issues). We look forward to your feedback.

## License

MRT-J-Revamp is licensed under the [MIT License](LICENSE).