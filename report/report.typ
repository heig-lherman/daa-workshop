#import "template.typ": *
#show: project.with(
  title: "DAA - Projet Widget",
  authors: (
    "Émilie Bressoud",
    "Sacha Butty",
    "Loïc Herman"
  ),
  date: "January 10, 2025",
)

= Introduction
TODO
== Conception
=== Architecture
L'architecture du widget se compose de plusieurs éléments essentiels:
- Le fichier de configuration XML
- La classe d'implémentation du widget
- Le layout du widget


= Mise en place d'un widget Android
== Configuration du widget
La configuration d'un widget se fait principalement via un fichier XML qui définit:
- Les dimensions du widget
- Les options de configuration
- Les options de redimensionnement

```xml	
<!-- app/src/main/res/xml/my_app_widget_info.xml -->
<?xml version="1.0" encoding="utf-8"?>
<appwidget-provider xmlns:android="http://schemas.android.com/apk/res/android"
        android:initialLayout="@layout/glance_default_loading_layout"
        android:widgetFeatures="configuration_optional|reconfigurable"
        android:targetCellWidth="3"
        android:targetCellHeight="1"
        android:minResizeHeight="50dp"
        android:minResizeWidth="50dp"
        android:minHeight="50dp"
        android:minWidth="50dp"
        android:resizeMode="horizontal|vertical"
        android:description="@string/widget_picker_description">
</appwidget-provider>
```
- tagetCellWidth et targetCellHeight: Taille du widget en nombre de cellules. Elle permet de définir la taille du widget par défaut en fonction de la grille de l'écran d'accueil.
- minHeight et minWidth: Taille minimale du widget.
- minResizeHeight et minResizeWidth: Taille minimale du widget après redimensionnement.
- resizeMode: Mode de redimensionnement du widget. Il faut le définir pour permettre à l'utilisateur de redimensionner le widget.
- description: Description du widget affichée dans le sélecteur de widgets.

// TODO crop
@widget-example The following shows the defined widget with a target size of 3x1 cells and its description.
#figure(
  image("widget-example.png", width: 20%),
  caption: [
    Example of a widget configuration
  ]
) <widget-example>

#figure(
  image("widget-small.png", width: 20%),
  caption: [
    Example of a small widget
  ]
) <widget-small>  

#figure(
  image("widget-large.png", width: 20%),
  caption: [
    Example of a large widget (resized)
  ]
) <widget-large>
=== Manifest
Comme pour une activité, il est nécessaire de déclarer le widget dans le fichier `AndroidManifest.xml`:
```xml
<!-- app/src/main/AndroidManifest.xml -->
<receiver
      android:name=".MyAppWidgetReceiver"
      android:icon="@mipmap/ic_launcher"
      android:exported="true"
      android:permission="android.permission.BIND_APPWIDGET">
  <intent-filter>
      <action android:name="android.appwidget.action.APPWIDGET_UPDATE" />
  </intent-filter>
  <meta-data
          android:name="android.appwidget.provider"
          android:resource="@xml/my_app_widget_info" />
</receiver>
```
- android:name: Nom de la classe qui gère le widget

== Utilisation avec Jetpack Compose et Jetpack Glance
Il est possible d'utiliser Jetpack Compose et Jetpack Glance pour créer des widgets. Pour cela, il faut ajouter différentes dépendances pour utiliser Android Glance.



=== Classe principale du widget
L'implémentation du widget nécessite une classe héritant de `GlanceAppWidgetReceiver` qui permet de gérer les événements du widget et de `GlanceAppWidget` qui permet de définir le layout du widget.


= Conclusion
TODO