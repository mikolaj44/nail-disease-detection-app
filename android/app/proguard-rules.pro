# android/app/proguard-rules.pro
-keep class org.tensorflow.** { *; }
-keep class com.ultralytics.** { *; }
-dontwarn org.tensorflow.**
-dontwarn java.beans.BeanInfo
-dontwarn java.beans.FeatureDescriptor
-dontwarn java.beans.IntrospectionException
-dontwarn java.beans.Introspector
-dontwarn java.beans.PropertyDescriptor