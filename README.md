# Marvelizer
Class to consume Marvel API (https://developer.marvel.com)

### In order to create new instance please do:

```
require './marvelizer'
client = Marvelizer.new(
          :public_key => 'YOUR_PUBLIC_KEY',
          :private_key => 'YOUR_PRIVATE_KEY'
        )
```

### Get all the characters:

```
client.characters
```

### Grab character by id:

```
client.character(ID)
```
