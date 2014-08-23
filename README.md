# PXAlertView

PXAlertView is a block-based, customizable, stylable UIAlertView replacement. It fits harmoniously into the iOS 7/8 look-and-feel. Alerts can also be enhanced with any custom UIView. [PXAlertView](https://github.com/alexanderjarvis/PXAlertView) has been expanded to include a cancellable pie-style or spinner-style activity indicator. 

## Preview
![Demo Animation](animation.gif)

## Features

* Simple block syntax instead of delegates
* Animations that match iOS 7/8-style UIAlertView
* Fully customisable
* Add your own UIView as a contentView

## Installation

To use in your own projects, just drag the files in the [PXAlertView+ActivityIndicator folder] (PXAlertView+ActivityIndicator/) into your own project and import [PXAlertView.h](Classes/PXAlertView.h) or, for additional customization, [PXAlertView+Customization.h](Classes/PXAlertView+Customization.h).

## Usage

See [PXAlertView.h](Classes/PXAlertView.h) for the complete API. 

### Examples

```Objective-C
[PXAlertView showAlertWithTitle:@"The Matrix"
                        message:@"Pick the Red pill, or the blue pill"
                    cancelTitle:@"Blue"
                     otherTitle:@"Red"
                     completion:^(BOOL cancelled, NSInteger buttonIndex) {
                         if (cancelled) {
                             NSLog(@"Cancel (Blue) button pressed");
                         } else {
                             NSLog(@"Other (Red) button pressed");
                         }
                     }];
```

```Objective-C
    PXAlertView *anAlert = [PXAlertView showActivityWithTitle:@"Downloading assets" message:@"Loading" cancelTitle:@"Cancel" activityIndicatorType:PHISpinActivityIndicator completion:^(BOOL cancelled, NSInteger buttonIndex) {
        if (cancelled) {
            NSLog(@"Was cancelled");
        }
    }];
    [anAlert setCancelButtonBackgroundColor:[UIColor redColor]];
```

## License

PXAlertView is available under the MIT license. See the [LICENSE](LICENSE) file for more info.