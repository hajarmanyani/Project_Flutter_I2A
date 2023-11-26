# Tp1: Gestion des activités en intégrant de l'IA

<h1>Objectif</h1>
<p>L’objectif de ce second TP consiste à développer une application qui propose des activités à réaliser en
groupe.
Dans le fonctionnement actuel des entreprises, celle-ci définissent le plus souvent, dans le cadre du
développement d’une application, une version MVP (Minimum viable product ➔ Produit minimum viable).
Le MVP est la version d’un produit qui permet d’obtenir un maximum de retours client avec un minimum
d’effort. Nous allons donc appliquer ce système est définir un MVP.
En parallèle, énormément d’entreprises passent aux méthodologies agiles et la rédaction de User Story.
Nous allons donc appliquer ce formalisme pour exprimer les différents besoins. Chaque User Story
composant le MVP sera préfixé de [MVP] dans son titre.</p>

<h2>US#1 : [MVP] Interface de login</h2>
<p>Au lancement de l'application, on affiche le logo de l'application avec un formulaire accompagné de deux bouttons pour s'authentifier ou créer un compte</p>
<img width="200" height="350" src="https://github.com/hajarmanyani/Project_Flutter_I2A/assets/93662714/afd8227d-7dea-4edb-84a0-0d0965a87bcd">
<p>Le champ de saisie du password est obfusqué</p>
<img width="200" height="350" src="https://github.com/hajarmanyani/Project_Flutter_I2A/assets/93662714/bf518d9e-2ce4-4cac-b328-2fa98e46f828">
<p>Au clic sur le bouton « Se connecter », une vérification en base est réalisée.
Si l’utilisateur existe, celui-ci est redirigé sur la page suivante. Si celui-ci n’existe pas, à minima un log
est affiché dans la console et l’application reste fonctionnelle</p>
<img width="200" height="350" src="https://github.com/hajarmanyani/Project_Flutter_I2A/assets/93662714/a0baaeeb-fb96-4a6f-a347-92d336df9b84">
<p>Au clic sur le bouton « Se connecter » avec les deux champs vides, l’application
doit rester fonctionnelle</p>
<img width="200" height="350" src="https://github.com/hajarmanyani/Project_Flutter_I2A/assets/93662714/0b5779a1-4555-46d2-a88d-4120f5f759ef">


