# TimedCache

## Description

This package is a protcol oriented cache implementation with a centrailized feature of expiration. Expiration is optional by definition of the protocol, but not the original intention. The only included implemenation is DictionaryCache, which is in fact thread safe.

## Example

```swift
  var dictCache = DictionaryCache()
  dictCache.set("My Object", for: "My Key", expiring: 500)

  dictCache["My Key"] // "My Object"
```
