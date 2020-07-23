# Social Timeline App

This is an app where the user can register and add posts to a collaborative timeline. Besides posting and viewing posts from other users, it's possible to remove your own posts.
The posts timeline automatically updates when there's new posts or posts are removed, so there's no need to pull to refresh, for example. This app was created as the code challenge for Nanameue.

## Getting Started

This project uses CocoaPods to manage the third party libraries. These are the libraries that were used:
* RxSwift and RxCocoa
* Firebase
* RSwift
* MBProgressHUD

To make it easier to run the project the pods were committed, so just clone the repository and open the Timeline.xcworkspace file. The XCode version used was 11.2.1 and the app supports iOS 12 and iOS 13.

## How to use the app
###### Creating an Account
To create an account, there's no need to use a real email since there's no email validation. For the password, it needs to be at least 6 characters long.
There's already one account that can be used with the email test@test.com and password is test123456

###### Creating New Post
After signing in you'll be on the Timeline screen, so just tap on New Post and type your message. When you're done, just tap Post and you'll be returned to the previous screen. Please note that the Post button will be disabled if there's no text to be posted.

###### Deleting Posts
You can only delete your own posts. To do that, the app uses the default delete action from tables, so just swipe left on a message. If it's your own message, a Delete button will appear so you can just click on it.

### Improvements
The apps use the MVVM architecture, which moves all the business logic to the view models, making it easier to write unit tests. One possible improvement is to move from MVVM to MVVM-C. That would remove the navigation code from the View Controllers and move it to the Coordinators, so it would be easy to implement new features like, if the user is already logged in, go directly to the Timeline screen.





