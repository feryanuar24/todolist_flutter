#!/bin/bash

# Load environment variables from .env file
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
fi

# Run Flutter with dart-define arguments
flutter run \
    --dart-define=WEB_API_KEY="$WEB_API_KEY" \
    --dart-define=WEB_APP_ID="$WEB_APP_ID" \
    --dart-define=ANDROID_API_KEY="$ANDROID_API_KEY" \
    --dart-define=ANDROID_APP_ID="$ANDROID_APP_ID" \
    --dart-define=IOS_API_KEY="$IOS_API_KEY" \
    --dart-define=IOS_APP_ID="$IOS_APP_ID" \
    --dart-define=IOS_BUNDLE_ID="$IOS_BUNDLE_ID" \
    --dart-define=PROJECT_ID="$PROJECT_ID" \
    --dart-define=STORAGE_BUCKET="$STORAGE_BUCKET" \
    --dart-define=AUTH_DOMAIN="$AUTH_DOMAIN" \
    --dart-define=MESSAGING_SENDER_ID="$MESSAGING_SENDER_ID" \
    $@
