# Order Tracking Notification

This Flutter application simulates an order tracking system in a simple way using Firebase Cloud Messaging (FCM).


It includes two main user roles:
- **User**: Can place an order and track its delivery status step by step.
- **Admin**: Can update the order's status and send real-time push notifications to the user.

---

## 🧭 Application Workflow

### 👤 User Screen (`Userscreen`)
1. When the app opens, it checks `SharedPreferences` to see if the user has already placed an order.
2. If **no order was placed**, the user sees a product card with an **"Order Now"** button.
3. When the **user presses "Order Now"**:
    - The order status is saved locally.
    - The user is subscribed to the FCM topic `order_1090`.
4. After ordering, the user is taken to a **tracking screen**, which shows a timeline of the delivery stages:
    - Pending
    - Confirmed
    - Shipped
    - Delivered
5. The timeline updates automatically when the admin changes the order status.

### 🛠️ Admin Screen (`Adminscreen`)
1. The admin sees a card representing the current order.
2. Each time the admin presses the main action button:
    - The order status progresses (Pending → Confirmed → Shipped → Delivered).
    - A push notification is sent to the `order_1090` topic with the updated status.
    - The updated status is saved locally.
3. When the status reaches **Delivered**, the button turns red and becomes a **"Reset"** button, allowing the admin to restart the process.

---

## 🔔 Push Notifications

- Firebase Cloud Messaging (FCM) is used to notify users of their order status.
- The notification body is parsed on the user side to extract the current step.
- When a notification is received, the user’s local `statusIndex` is updated and the timeline is refreshed.

---

## 📦 State Management

- Order state (`hasOrdered`, `statusIndex`) is saved using `SharedPreferences` to maintain continuity between app sessions.
- Admin status (`progressIndex`) is also stored similarly to ensure persistence.

---

## ⚠️ Important Note About Notifications

> ✅ To send FCM messages from the **Admin screen**, a valid Firebase **Service Account Key** is required.  
> Make sure to place your JSON file at this path:

```
assets/FCM_auth/serviceAccountKey.json
```

Then add it to `pubspec.yaml` under `flutter > assets` like this:

```yaml
flutter:
  assets:
    - assets/FCM_auth/serviceAccountKey.json
```

Otherwise, the app will fail to send notifications with this error:
> `"Unable to load asset: assets/FCM_auth/serviceAccountKey.json"`

---

## 🛠 Technologies Used

- Flutter
- Firebase Cloud Messaging
- Google APIs (for sending server-side notifications)
- SharedPreferences
- timeline_tile package
- sizer package

---

## 📌 To Do / Future Enhancements

- Support for multiple concurrent orders
- User authentication and login
- Backend integration for real-time updates without relying on FCM message parsing

---
