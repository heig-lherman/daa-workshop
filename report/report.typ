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
Les widgets sont des composants essentiels de l'écosystème Android, permettant aux utilisateurs d'accéder rapidement à des informations ou des fonctionnalités sans ouvrir l'application complète. Ce projet explore la création d'un widget Android moderne en utilisant les dernières technologies recommandées par Google, notamment Jetpack Compose et Jetpack Glance.

L'objectif est de créer un widget responsive et interactif, en suivant les bonnes pratiques de développement Android. Nous verrons comment configurer, implémenter et personnaliser un widget pour offrir une expérience utilisateur optimale.

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
@widget-example
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

=== Layout du widget
Il est possible d'afficher ou non certains éléments selon la taille du widget, si l'on décide de rendre le widget "responsive". Par exemple, on peut afficher un seul bouton si le widget est petit et plusieurs boutons si le widget est plus grand.

On définit des tailles possibles du widget dans la classe principale du widget:
```kotlin
 companion object {
        private val SMALL_SQUARE = DpSize(100.dp, 100.dp)
        private val HORIZONTAL_RECTANGLE = DpSize(150.dp, 100.dp)
        private val BIG_SQUARE = DpSize(250.dp, 250.dp)
    }

    override val sizeMode = SizeMode.Responsive(
        setOf(
            SMALL_SQUARE, HORIZONTAL_RECTANGLE, BIG_SQUARE
        )
    )
```

Ensuite, on peut décidé d'afficher ou non certains éléments en fonction de la taille du widget:
```kotlin
@Composable
    override fun Content() {
        Column {
            if (size == SMALL_SQUARE) {
                Text("Small widget")
            } else {
                Text("Big widget")
            }
        }
    }
```
= Conclusion
Ce projet nous a permis d'explorer en profondeur le développement de widgets Android modernes. L'utilisation de Jetpack Glance, combinée à Jetpack Compose, offre une approche déclarative et intuitive pour créer des widgets interactifs et responsives.

Les principaux apprentissages incluent:
- La configuration et la déclaration correcte d'un widget dans le système Android
- L'utilisation des nouvelles APIs de Jetpack Glance pour une approche moderne du développement
- La gestion du responsive design pour s'adapter aux différentes tailles d'affichage
- L'implémentation d'interactions utilisateur fluides et efficaces

Cette expérience démontre l'évolution des outils de développement Android, rendant la création de widgets plus accessible tout en maintenant un haut niveau de personnalisation et de performance.