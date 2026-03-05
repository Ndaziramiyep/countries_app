# App Icon Setup

## Instructions

1. **Add your icon image**
   - Place your app icon image (1024x1024 PNG recommended) in this folder
   - Name it: `icon.png`

2. **Generate launcher icons**
   ```bash
   flutter pub get
   flutter pub run flutter_launcher_icons
   ```

3. **Icon will be generated for:**
   - Android (all densities)
   - iOS (all sizes)

## Icon Requirements

- **Format**: PNG
- **Recommended Size**: 1024x1024 pixels
- **Background**: Should work on both light and dark backgrounds
- **No transparency**: For Android adaptive icons, use solid background

## Current Configuration

The `pubspec.yaml` is configured with:
```yaml
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icon/icon.png"
```

## Need a placeholder?

If you don't have an icon yet, you can use a simple globe emoji or download a free icon from:
- https://www.flaticon.com/
- https://icons8.com/
- https://www.iconfinder.com/

---

**Note**: Make sure to add your `icon.png` file here before running the icon generation command.
