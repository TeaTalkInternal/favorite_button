# favorite_button


- [favorite_button](#favoritebutton)
  - [How to use it.](#how-to-use-it)
  - [The time to send your request](#the-time-to-send-your-request)
  - [parameters](#parameters)

##  How to use it.

the default effects is Icons.favorite
```dart
  FavoriteButton(
            valueChanged: (_) {
            },
          ),
```

and you can also define custom effects.
```dart
 FavoriteButton(
            valueChanged: (_isFavorite) {
              print('Is Favorite $_isFavorite)');
            },
          )
```


## parameters
| parameter                  | description                                                                           | default                                                                                                                                                                               |
| -------------------------- | ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| iconSize                       | size of button widget                                                                   | 60.0                                                                                                                                                                                  |
| iconColor          | color of button widget                                            | red for heart and yellow for star button respectively                                                                                                                                                    |
| valueChanged                | Function that returns boolean value for current state of button                                                                 | This is a required parameter                                                                                                                                                                            |
                                                                                                                                                               |

[more detail](https://github.com/TeaTalkInternal/favorite_button/tree/master/example/lib)
