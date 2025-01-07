# GoogleTakeoutFixes

Scripts to fix issues with media files from Twitter/X and Reddit in Google Takeout. Designed to work with [GooglePhotosTakeoutHelper](https://github.com/TheLastGimbus/GooglePhotosTakeoutHelper).

## Features
- **Fix Twitter/X Images**: Converts `JPG` files downloaded via the Twitter app back to their original `PNG` format if applicable.
- **Fix Reddit Images**: Converts `WEBP` files mislabeled as `JPG` by the Reddit app into proper `JPG` format.

## Requirements
- Bash shell
- [ExifTool](https://exiftool.org/) for metadata handling
- [ImageMagick](https://imagemagick.org/) for image conversion (required for Reddit fixes)

Install dependencies on macOS using:
```bash
brew install exiftool imagemagick
```

## Usage
Clone the repository and run the scripts in the directory containing the files:

### Fix Twitter/X Images
To fix `JPG` files that are actually `PNG`, use:
```bash
./fix_twitter_images.sh
```

### Fix Reddit Images
To fix `WEBP` files mislabeled as `JPG`, use:
```bash
./fix_reddit_images.sh
```
