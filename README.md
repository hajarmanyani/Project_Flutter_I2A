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
<p>Firebase authentication</p>
<img width="736" alt="Capture" src="https://github.com/hajarmanyani/Project_Flutter_I2A/assets/93662714/022e8611-9dbe-462e-a457-5a23ec6448c1">

<h2>US#2 : [MVP] Liste des activités</h2>
<p>Une fois connecté, l’utilisateur arrive sur cette page composée du contenu
principal et d’une BottomNavigationBar composée de trois entrées et leurs icones correspondantes :
Activités, Ajout et Profil</p>
<img width="200" height="350" src="https://github.com/hajarmanyani/Project_Flutter_I2A/assets/93662714/7f509604-6aee-44f7-b5be-2aba13cf7d9c">
<p>Cette liste d’activités est récupérée de la base de données</p>
<img width="732" alt="Capture" src="https://github.com/hajarmanyani/Project_Flutter_I2A/assets/93662714/9ebd2674-fa60-4a09-86fd-40e413103c47">

<h2>US#3 : [MVP] Détail d’une activité</h2>
<p>Au clic sur une entrée de la liste, le détail est affiché</p>
<img width="200" height="350" src=https://github.com/hajarmanyani/Project_Flutter_I2A/assets/93662714/7236ffe5-4fcc-4a15-bd19-6743f7d4e392">

<h2>US#4 : [MVP] Filtrer sur la liste des activités</h2>
<p>Par défaut, l’entrée « Tous » est sélectionnée et toutes les activités sont affichés</p>
<img width="200" height="350" src="https://github.com/hajarmanyani/Project_Flutter_I2A/assets/93662714/be74f9c8-1cd0-4cbe-bc6d-5a3ba8964be2">
<p>Au clic sur une des entrées, la liste est filtrée pour afficher seulement les activités correspondantes à la catégorie sélectionnée</p>
<img width="200" height="350" src="https://github.com/hajarmanyani/Project_Flutter_I2A/assets/93662714/ad765fc7-dc06-4036-8268-ba6139abca5f">
<br>
<img width="200" height="350" src="https://github.com/hajarmanyani/Project_Flutter_I2A/assets/93662714/5e0a448e-b4ac-4a8e-bcc0-ab92ad5b043d">

<h2>US#5 : [IA] Ajouter une nouvelle activité</h2>
<p>: Sur la BottomNavigationBar, j’accède à cette page au clic sur l’item « Ajout »</p>
<img width="200" height="350" src="https://github.com/hajarmanyani/Project_Flutter_I2A/assets/93662714/f35fbaf7-6fc1-43cd-bdb0-1123f49692aa">
<img width="200" height="350" src="https://github.com/hajarmanyani/Project_Flutter_I2A/assets/93662714/b6d2874a-8e51-457e-80fb-6bc74df65723">
<p>Un bouton « Enregistrer » permet de sauvegarder les données (en base de données)</p>
<img width="732" alt="Capture" src="https://github.com/hajarmanyani/Project_Flutter_I2A/assets/93662714/9ebd2674-fa60-4a09-86fd-40e413103c47">
<p>Le champ catégorie est non éditable et doit être automatiquement défini à l’upload de l’image (IA)</p>
<h2>Entrainement du modèle IA en utilisant le réseau CNN (Réseau neuronal convolutif)</h2>
<img width="691" alt="Capture" src="https://github.com/hajarmanyani/Project_Flutter_I2A/assets/93662714/246f379a-300d-4c5b-9133-a72fb4b7e679">
<img width="687" alt="Capture2" src="https://github.com/hajarmanyani/Project_Flutter_I2A/assets/93662714/9a853dbb-287d-49fd-be25-658212f1e8c3">

<h2>US#6 : Amélioration</h2>
<p>Ajouter un formulaire pour permettre aux utilisateurs de créer des comptes avec leus propres noms</p>
<img width="200" height="350" src="https://github.com/hajarmanyani/Project_Flutter_I2A/assets/93662714/5205cbfd-1b01-4721-9fa2-5438c621b29f">
<p>Ensuite, l'utilisateur et sauvegardé dans la base de données dans une collection appelée "userrs"</p>
<img width="727" alt="Capture3" src="https://github.com/hajarmanyani/Project_Flutter_I2A/assets/93662714/d6349c56-b4e7-43a0-9636-47451b7df763">

<h1>Les images de test</h1>
<img width="687"  src="https://github.com/hajarmanyani/Project_Flutter_I2A/assets/93662714/c5f5d934-1191-4f2b-8d7b-45ca59e1aedb">
<img width="687"  src="https://github.com/hajarmanyani/Project_Flutter_I2A/assets/93662714/1259763a-7af4-4cdc-a493-1dea26313a1c">

<h1>Conclusion</h1>
<p>Ce TP a été une expérience enrichissante dans le développement d'une application mobile avec Flutter en intégrant des fonctionnalités avancées telles que la reconnaissance automatique des activités à l'aide d'un modèle d'IA basé sur un réseau neuronal convolutif (CNN).</p>
<br>
<p>L'utilisation de Firebase pour l'authentification et le stockage des données a simplifié la gestion des utilisateurs et des activités. Les User Stories, inspirées des méthodologies agiles, ont permis de définir clairement les besoins fonctionnels, facilitant ainsi le processus de développement.</p>
<br>
<p>En résumé, ce TP a permis de mettre en pratique divers concepts de développement d'applications mobiles, de la conception d'une interface utilisateur à l'intégration de technologies avancées, dans le but de créer une application fonctionnelle et innovante.</p>
