# Currency Converter

Implementation using Westpac's FX API to do currency conversion

<p align="left">
  <img src="https://github.com/jaysalvador/currency-converter/blob/master/images/img1.png" width="150" alt="accessibility text">

  <img src="https://github.com/jaysalvador/currency-converter/blob/master/images/img2.png" width="150" alt="accessibility text">
</p>

## Currency Library

`Currency` is a static library that handles data retrieval and serialisation of the currency data to the `Currency` model, which is a `Codable` struct.

Implemented `HttpClient` class to handle HTTP requests to the API and decodes the response to any `Decodable` type object.

All API responses will be conforming to this closure, using the `Result` type:
>  `HttpCompletionClosure<T> = ((Result<T, HttpError>) -> Void)`

`T` would need to conform to `Decodable` protocol, and errors will be extended using the `HttpError` enum states

Defined the response type to get an array of currencies to `CurrencyClient.CurrencyResponse` where its attribute contains `currencies` with type `[Currency]`. The decoder has been overridden to go through the inner dictionary `Rates` using `nestedContainer`. `CustomCodingKeys` has been defined to handle the dynamic keys for the currencies.

### Currency Helpers

A few extensions have been overridden for easier conversion of `String`, `Date`, `Double` among others, in relation to a particular `Currency` model.

All componentry in the app is driven by `UICollectionView` instead of `UITableView` for flexibility of cells and UI.

## Client-side App

The app architecture is built using the MVVM pattern and Protocol-oriented programming and Dependency Injection principles.

### Theming

There are two themes to this app, `standard` and `red`, defined in the `Theme` enum. 

The app can be built in two different apps, with `Theme` property defined in the plist file. Each view/viewcontroller will be updated accordingly to these themes. 

### Cocoapods Dependency

[Dwifft](https://github.com/jflinter/Dwifft) library has been used in this project to handle `UICollectionView` reloading and refreshing. `Section` and `Item` types are provided to define the `UICollectionView` sections and items, and must adhere to `Equatable` protocol. These types will be used within the `Dwifft` library to easily compare and reload the collection and its cells.

`JCollectionViewController` is class that extends `UIViewController` and implements `UICollectionView` delegates, and adheres to the `Dwifft` library implementation. The class provides easier access to sections and items of the collectionView by overriding the `UICollectionView` standard delegate functions to provide `Section` and `Item` type objects, abstracting the searching of the binded data using `IndexPath`

## Testing

`ConversionTests`
- contains testing of API retrieval and mock data retrieval
- tests conversion for USD, NZD and PHP

`WestpacUITests`
- `testCurrencyTextFields`
  - testing for tapping the amount text field and entering 1000.0, filling up values and navigating the app to the currency detail view
- `testCurrencySwitch`
  - tests the currency switch button on the top right


#### * Coding Style

My coding style tends to have more indentation and spacing, similar to writing a term paper for easier reading.

For more queries, please feel free to contact me at jay.andrae.salvador@gmail.com
