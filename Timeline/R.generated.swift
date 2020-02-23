//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map(Locale.init)
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.segue` struct is generated, and contains static references to 1 view controllers.
  struct segue {
    /// This struct is generated for `SignInViewController`, and contains static references to 1 segues.
    struct signInViewController {
      /// Segue identifier `toCreateAccount`.
      static let toCreateAccount: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, SignInViewController, CreateAccountViewController> = Rswift.StoryboardSegueIdentifier(identifier: "toCreateAccount")

      #if os(iOS) || os(tvOS)
      /// Optionally returns a typed version of segue `toCreateAccount`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func toCreateAccount(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, SignInViewController, CreateAccountViewController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.signInViewController.toCreateAccount, segue: segue)
      }
      #endif

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 3 storyboards.
  struct storyboard {
    /// Storyboard `Account`.
    static let account = _R.storyboard.account()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Timeline`.
    static let timeline = _R.storyboard.timeline()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Account", bundle: ...)`
    static func account(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.account)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Timeline", bundle: ...)`
    static func timeline(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.timeline)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.file` struct is generated, and contains static references to 1 files.
  struct file {
    /// Resource file `GoogleService-Info.plist`.
    static let googleServiceInfoPlist = Rswift.FileResource(bundle: R.hostingBundle, name: "GoogleService-Info", pathExtension: "plist")

    /// `bundle.url(forResource: "GoogleService-Info", withExtension: "plist")`
    static func googleServiceInfoPlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.googleServiceInfoPlist
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 1 nibs.
  struct nib {
    /// Nib `TimelineTableViewCell`.
    static let timelineTableViewCell = _R.nib._TimelineTableViewCell()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "TimelineTableViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.timelineTableViewCell) instead")
    static func timelineTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.timelineTableViewCell)
    }
    #endif

    static func timelineTableViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> TimelineTableViewCell? {
      return R.nib.timelineTableViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? TimelineTableViewCell
    }

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 16 localization keys.
    struct localizable {
      /// Value: Authentication Error
      static let authError = Rswift.StringResource(key: "authError", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Confirm Password
      static let confirmPassword = Rswift.StringResource(key: "confirmPassword", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Create Account
      static let createAccount = Rswift.StringResource(key: "createAccount", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Email
      static let email = Rswift.StringResource(key: "email", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Error
      static let genericError = Rswift.StringResource(key: "genericError", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Login
      static let login = Rswift.StringResource(key: "login", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Logout
      static let logout = Rswift.StringResource(key: "logout", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Missing email/password
      static let missingEmailPassword = Rswift.StringResource(key: "missingEmailPassword", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: New Post
      static let newPost = Rswift.StringResource(key: "newPost", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: OK
      static let ok = Rswift.StringResource(key: "ok", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Password
      static let password = Rswift.StringResource(key: "password", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Password and Confirm Password mismatch
      static let passwordMismatch = Rswift.StringResource(key: "passwordMismatch", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Please wait...
      static let loading = Rswift.StringResource(key: "loading", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Timeline
      static let title = Rswift.StringResource(key: "title", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Timeline Error
      static let timelineError = Rswift.StringResource(key: "timelineError", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Welcome to Social Timeline
      static let welcome = Rswift.StringResource(key: "welcome", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)

      /// Value: Authentication Error
      static func authError(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("authError", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "authError"
        }

        return NSLocalizedString("authError", bundle: bundle, comment: "")
      }

      /// Value: Confirm Password
      static func confirmPassword(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("confirmPassword", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "confirmPassword"
        }

        return NSLocalizedString("confirmPassword", bundle: bundle, comment: "")
      }

      /// Value: Create Account
      static func createAccount(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("createAccount", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "createAccount"
        }

        return NSLocalizedString("createAccount", bundle: bundle, comment: "")
      }

      /// Value: Email
      static func email(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("email", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "email"
        }

        return NSLocalizedString("email", bundle: bundle, comment: "")
      }

      /// Value: Error
      static func genericError(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("genericError", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "genericError"
        }

        return NSLocalizedString("genericError", bundle: bundle, comment: "")
      }

      /// Value: Login
      static func login(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("login", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "login"
        }

        return NSLocalizedString("login", bundle: bundle, comment: "")
      }

      /// Value: Logout
      static func logout(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("logout", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "logout"
        }

        return NSLocalizedString("logout", bundle: bundle, comment: "")
      }

      /// Value: Missing email/password
      static func missingEmailPassword(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("missingEmailPassword", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "missingEmailPassword"
        }

        return NSLocalizedString("missingEmailPassword", bundle: bundle, comment: "")
      }

      /// Value: New Post
      static func newPost(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("newPost", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "newPost"
        }

        return NSLocalizedString("newPost", bundle: bundle, comment: "")
      }

      /// Value: OK
      static func ok(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("ok", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "ok"
        }

        return NSLocalizedString("ok", bundle: bundle, comment: "")
      }

      /// Value: Password
      static func password(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("password", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "password"
        }

        return NSLocalizedString("password", bundle: bundle, comment: "")
      }

      /// Value: Password and Confirm Password mismatch
      static func passwordMismatch(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("passwordMismatch", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "passwordMismatch"
        }

        return NSLocalizedString("passwordMismatch", bundle: bundle, comment: "")
      }

      /// Value: Please wait...
      static func loading(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("loading", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "loading"
        }

        return NSLocalizedString("loading", bundle: bundle, comment: "")
      }

      /// Value: Timeline
      static func title(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("title", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "title"
        }

        return NSLocalizedString("title", bundle: bundle, comment: "")
      }

      /// Value: Timeline Error
      static func timelineError(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("timelineError", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "timelineError"
        }

        return NSLocalizedString("timelineError", bundle: bundle, comment: "")
      }

      /// Value: Welcome to Social Timeline
      static func welcome(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("welcome", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "welcome"
        }

        return NSLocalizedString("welcome", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib {
    struct _TimelineTableViewCell: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "TimelineTableViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> TimelineTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? TimelineTableViewCell
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try account.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try timeline.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct account: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController

      let bundle = R.hostingBundle
      let createAccountViewController = StoryboardViewControllerResource<CreateAccountViewController>(identifier: "CreateAccountViewController")
      let name = "Account"
      let signInViewController = StoryboardViewControllerResource<SignInViewController>(identifier: "SignInViewController")

      func createAccountViewController(_: Void = ()) -> CreateAccountViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: createAccountViewController)
      }

      func signInViewController(_: Void = ()) -> SignInViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: signInViewController)
      }

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.account().createAccountViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'createAccountViewController' could not be loaded from storyboard 'Account' as 'CreateAccountViewController'.") }
        if _R.storyboard.account().signInViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'signInViewController' could not be loaded from storyboard 'Account' as 'SignInViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct timeline: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "Timeline"
      let newPostViewController = StoryboardViewControllerResource<NewPostViewController>(identifier: "NewPostViewController")
      let timelineViewController = StoryboardViewControllerResource<TimelineViewController>(identifier: "TimelineViewController")

      func newPostViewController(_: Void = ()) -> NewPostViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: newPostViewController)
      }

      func timelineViewController(_: Void = ()) -> TimelineViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: timelineViewController)
      }

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.timeline().newPostViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'newPostViewController' could not be loaded from storyboard 'Timeline' as 'NewPostViewController'.") }
        if _R.storyboard.timeline().timelineViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'timelineViewController' could not be loaded from storyboard 'Timeline' as 'TimelineViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
