# La Haus Brokers
<img width="100%" src="https://angellovc.github.io/lading-haus-brokers/assets/images/banner.png">

[![Download Badge](https://img.shields.io/badge/LaHaus-Download-00d0ae?style=flat-square&logo=&logoColor=white&link=https://docs.google.com/uc?export=download&id=1FHmTTQDliNqGD2fp-bQMOUgQCuJyLIT2)](https://docs.google.com/uc?export=download&id=1FHmTTQDliNqGD2fp-bQMOUgQCuJyLIT2)

---
<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#an-app-for-house-brokers)
* [Value Proposal](#value-proposal)
* [Overview](#overview)
* [Project Design](#project-design)
* [Pattern Design](#pattern-design)
* [Dependencies](#dependencies)
* [Authors](#authors)

## An App for House Brokers

La Haus Brokers App is an application intended for sellers, brokers and property owners who want to promote and sell their properties easily.  Our app is oriented to improve the service offered 
by La Haus Real Estate Company to people interested in selling a house or apartment quickly, smooth and easy, without any burocratic procedure.

## Value proposal
Our application, not only automates and makes easier the task to sell houses, but it also helps users to take better photos using computational vision to improve its quality, retrieves a feedback of what is wrong and how to improve it.

## Mentoring and Teamwork

Project developed at Holberton School Colombia with the mentoring and supervision of La Haus in order to impact the real estate procedures and deals.

## Overview

<div style="display:flex; flex-wrap: wrap">
  <img width="33%" src="https://i.imgur.com/qWmOfRg.jpg">
  <img width="33%" src="https://i.imgur.com/6gTCPzd.jpg">
  <img width="33%" src="https://i.imgur.com/5GN7hR5.jpg">
  <img width="33%" src="https://i.imgur.com/pNZwZfw.jpg">
  <img width="33%" src="https://i.imgur.com/avYLsjI.jpg">
  <img width="33%" src="https://i.imgur.com/SZiCWLe.jpg">
  <img width="33%" src="https://i.imgur.com/g4F14Qv.jpg">
  <img width="33%" src="https://i.imgur.com/ZZ7mxIX.jpg">
  <img width="33%" src="https://i.imgur.com/CQpGh5U.jpg">
</div>



## Project Design

<img width="100%" src="https://i.imgur.com/AncRbKg.jpeg">

#### [lib](./lib)
The application core


#### [lib/src](./lib/src)
App code


#### [lib/src/bloc](./lib/src/bloc)
This project is implementing the bloc pattern, so that all the blocs along with the app bloc provider are suited inside this folder

#### [lib/src/models](./lib/src/models)
Properties abstractions. This folder is used to store the code representation of the properties

#### [lib/src/pages](./lib/src/pages)
This folder represent the UI of the project

#### [lib/src/resources](./lib/src/resources)
Resources folder contain all the code we use to communicate us with our server, external Apis and other internet services

#### [lib/src/resources](./lib/src/resources)
Http requests files

#### [lib/src/widgets](./lib/src/widgets)
All the witgets which are independent to any class of the project and can be used for general purposes

#### [lib/src/routes](./lib/src/routes)
All the routes that our program is manage

#### [lib/src/user_preferences](./lib/src/user_preferences/)
Used to store permanently few important information, preferences and important setting of the user

## Framework
<div style="display:flex">
<img width="50%" src="https://angellovc.github.io/lading-haus-brokers/assets/images/dart.png">
<img width="50%" src="https://angellovc.github.io/lading-haus-brokers/assets/images/flutter-logo.png">
</div>

## Pattern Design

We have decided to use the Bloc pattern, based on the Model View Controller, which make or application organized, scalable and easy to mantain.

<img width="100%" src="https://i.imgur.com/i1IrsOE.jpg">

## dependencies:
  [settings_ui](https://pub.dev/packages/settings_ui)
  [cupertino_icons](https://pub.dev/packages/cupertino_icons)
  [rxdart](https://pub.dev/packages/rxdart)
  [http](https://pub.dev/packages/http)
  [json_annotation](https://pub.dev/packages/json_annotation)
  [shared_preferences](https://pub.dev/packages/shared_preferences)
  [country_icons](https://pub.dev/packages/country_icons)
  [intro_slider](https://pub.dev/packages/intro_slider)
  [image_picker](https://pub.dev/packages/image_picker)
  [imagebutton](https://pub.dev/packages/imagebutton)
  [flutter_swiper](https://pub.dev/packages/flutter_swiper)
  [permission_handler](https://pub.dev/packages/permission_handler)
  [mime_type](https://pub.dev/packages/mime_type)
  [build_runner](https://pub.dev/packages/build_runner)
  [json_serializable](https://pub.dev/packages/json_serializable)

## Authors
#### Angello Villegas - Full Stack Developer
[![Github Badge](https://img.shields.io/badge/-angellovc-1ca0f1?style=flat-square&labelColor=black&logo=Github&logoColor=white&link=https://github.com/angellovc)](https://github.com/angellovc) [![Linkedin Badge](https://img.shields.io/badge/Angello-Villegas-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/angello-villegas/)](https://www.linkedin.com/in/angello-villegas/)
#### Oscar David Henao Hidalgo - Full Stack Developer
[![Github Badge](https://img.shields.io/badge/-davehh1211-1ca0f1?style=flat-square&labelColor=black&logo=Github&logoColor=white&link=https://github.com/davehh1211)](https://github.com/davehh1211) [![Linkedin Badge](https://img.shields.io/badge/David-Henao-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/oscar-david-henao-hidalgo-021b2b1a3/)](https://www.linkedin.com/in/oscar-david-henao-hidalgo-021b2b1a3/)


#### Miguel Palacios - Full Stack Developer
[![Github Badge](https://img.shields.io/badge/-Migel4P4lacios-1ca0f1?style=flat-square&labelColor=black&logo=Github&logoColor=white&link=https://github.com/MiguelP4lacios)](https://github.com/MiguelP4lacios) [![Linkedin Badge](https://img.shields.io/badge/Miguel-Palacios-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/miguel-p4lacios/)](https://www.linkedin.com/in/miguel-p4lacios/)

#### Juan Pablo Yepes Tamayo - Full Stack Developer
[![Github Badge](https://img.shields.io/badge/-PabloYepes27-1ca0f1?style=flat-square&labelColor=black&logo=Github&logoColor=white&link=https://github.com/PabloYepes27)](https://github.com/PabloYepes27) [![Linkedin Badge](https://img.shields.io/badge/Pablo-Yepes-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/pablo-yepes-120495/)](https://www.linkedin.com/in/pablo-yepes-120495/)
