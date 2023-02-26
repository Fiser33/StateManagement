# StateManagement
Demo project used for live coding session during talk about state management in SwiftUI.

## Installation
Before you first launch the project on your machine, you have to create two local files for secrets and customized project configuration. For that, you'll need following:

- API key for TMDb service, to get one just follow [official instructions](https://developers.themoviedb.org/3/getting-started/introduction).
- Apple ID to at least run the project locally on simulator

### Arkana
To store secrets, I've used [Arkana tool](https://github.com/rogerluan/arkana). You store all secret values in .env local file and generate code to access these.

So first, you create .env file in the root project directory like this:

```
tmdbApiKey = <YOUR_API_KEY>
```

Then you run Arkana to generate source code files using the command below:

```
bundle install
bundle exec arkana
```

### xcconfig
The easiest way to define your Apple account and bundle identifier for the project is to create file StateManagement/base.xcconfig. The file must be at this specific location as it is also linked to the project from there and Xcode will complain when it's missing. Here's the minimal file content:

```
PRODUCT_BUNDLE_IDENTIFIER = <YOUR_BUNDLE_IDENTIFIER>
DEVELOPMENT_TEAM = <YOUR_TEAM_ID>
```

## Branches
There are two key branches.

- **main** - contains final demo code
- **demo** - code without proper state management where the live coding starts from