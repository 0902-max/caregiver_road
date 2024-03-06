# Caregiver_Road

[![Image from Gyazo](https://i.gyazo.com/5927dd5bd279cc4dc23c50f151e4378f.png)](https://gyazo.com/5927dd5bd279cc4dc23c50f151e4378f)


## 【アプリのURL】
### https://www.caregiver-road.com/

## サービス概要
介護福祉士になるための網羅的なサービスです。 自身の学歴等によって受験資格までのルートをスッキリさせて、そのために必要なものや過去問を提供するサービス。

## このサービスへの思い・作りたい理由 
自身が介護福祉士になる際に一からほとんど調べなければならなかった事に加えて後からお得な制度等を知り、勿体なく感じた為。 その過程でめんどくさく感じることも多々あり、時間もかかってしまい挫折する可能性を高めてしまっているように感じる。 同じ職場の方もどうすれば良いのか分からない為、避けてしまっていたりする現状があった為。

## 想定されるユーザー層 
介護してる人、介護をしたいと思っている人です。
利用者と関わっていく上で職員同士の会話や利用者の病気からの推測等、うまく言語化ができなかったり、不適切な発言になりそうで発言しにくかったりしてしまう為、知識をつけたい人

## サービスの利用イメージ 
ログインしてプロフィールを設定することで受験資格までのロードマップを作成でき、助成金等の情報をゲットでき、受験の申し込み期日等の通知を受けられる。
その後は過去問をスマホ等で手軽に行え、用語を単語帳のように見る事ができる。隙間時間で勉強ができ、受験までの手間が簡略化できる。

## サービスの差別化ポイント・推しポイント 
介護福祉士の過去問アプリはあるし、介護福祉士受験の為のロードマップや助成金等のアプリはそれぞれのアプリはあるが、網羅的には見当たらなかった。

## 主な使用技術　
### バックエンド
- Ruby 3.2.2 
- Rails 7.0.4.3 　
- PostgreSQL 
- gem
  - devise
  - Kaminari
  - Capybara
  - Faker 
- API
  - Notifications_API
  - jGrants API（全体的な補助金一覧取得API）
  - FullCalendar API

### フロントエンド
- bootstrap5 

### インフラ
- Heroku

### 開発環境
- Docker 
- github 

## 画面変異図 　
[![Image from Gyazo](https://i.gyazo.com/c146091f190cb676019dc915a725072b.png)](https://gyazo.com/c146091f190cb676019dc915a725072b)

## ER図 　
[![Image from Gyazo](https://i.gyazo.com/95f3bd79e3b701c148dae7ac5137de74.png)](https://gyazo.com/95f3bd79e3b701c148dae7ac5137de74)

## 作成段階での変更
　Google Calender APIを使用予定であったが、思っているものと違い、カスタムがしやすいFullCalendarを使用してカレンダーを実装してイベントの追加と編集を行う。その関係でER図のGoogleCalendarEvantsテーブル名をEventsに変更した。

## サービスの利用イメージ （変更後）
  ログインしてプロフィールを設定することで受験資格に必要なイベントを確認し、自分でイベントを作成することで目的がハッキリすることができる。助成金等の情報をゲットでき、受験の申し込み期日等の通知を受けられる。その後は過去問をスマホ等で手軽に行え、用語を単語帳のように見る事ができる。隙間時間で勉強ができ、受験までの手間が簡略化できる。
