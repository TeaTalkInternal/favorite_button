# favorite_button

Language: [English](README.md)

Favorite Button is a flutter library that allows you to create heart and star shaped favorite featured buttons with animation effects too.

![](https://github.com/TeaTalkInternal/github_assets/blob/master/gifs/video-to-gif-converter.gif)

- [favorite_button](#favoritebutton)
  - [How to use it.](#how-to-use-it)
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
| isFavorite or isStarred                | Default state of button                                                                 | This is a optional parameter                                                                                                                                                                            |
                                                                                                                                                               |

[more detail](https://github.com/TeaTalkInternal/favorite_button/tree/master/example/lib)
