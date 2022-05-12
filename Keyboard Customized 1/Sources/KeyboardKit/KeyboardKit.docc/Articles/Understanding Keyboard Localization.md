# Understanding Keyboard Localization

This article describes the KeyboardKit localization model and how to use it. 


## Keyboard locale

KeyboardKit has a ``KeyboardLocale`` enum that defines all available keyboard locales.

Keyboard locales have more information than raw locales and can also have a set of related services. For instance, when a KeyboardKit Pro license is registered, it will unlock new properties for resolving a ``CalloutActionProvider`` and an ``InputSetProvider`` for each keyboard locale.

Each keyboard locale also has localized content that can be accessed with the ``KKL10n`` enum.


## Localized content

Localized strings for each locale are kept under `Resources`.


## How to change the current locale 

You can change the locale of a keyboard extension using the ``KeyboardContext/locale`` property, which will cause parts of the keyboard that needs it to automatically update.

Note that the context locale is a regular `Locale` and not a ``KeyboardLocale``. This makes it possible to use regular locales without having to create new ``KeyboardLocale``s.

You can change the available locales of keyboard extensions using the ``KeyboardContext/locales`` property, which makes it possible to loop through the available locales using the ``KeyboardContext/selectNextLocale()`` function.


## How to create a new locale

Adding a new locale to KeyboardKit involves the following:

* Define the new `KeyboardLocale` case.
* Define its properties, like `flag`, `isLeftToRight` etc.
* Provide a `Resources/<id>.lproj` folder with localized strings.
* Make sure that the unit tests pass.

You must also create new features in KeyboardKit Pro:

* Implement a new `CalloutActionProvider`.
* Implement a new `InputSetProvider`.

If the locale generates a keyboard that looks off, you can either implement a new ``KeyboardLayoutProvider`` or adjust the ``iPhoneKeyboardLayoutProvider`` and ``iPadKeyboardLayoutProvider`` to handle the new layout.

New locales must ensure that the keyboard layout is correct for:

* iPhone portrait
* iPhone landscape
* iPad portrait
* iPad landscape  

This involves specifying margins, system actions etc. to make the keyboard behave correctly for all these cases.
