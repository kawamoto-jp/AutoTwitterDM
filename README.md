# アプリ名
Twitter自動DMツール

# 概要
名前の通り、TwitterでDMを自動で送ることができるツールです。  
用意するものはDMを送りたいアカウントのリストと送りたいメッセージだけ。  
そのアカウントごとに、用意していただいたメッセージを自動で送ることができます。  
  
# 利用方法  
①ツイッターアカウント名（＠〇〇の部分）を入力します  
②宛名（例：〇〇様へ、など）を入力します  
③文章を入力します  
④一旦その内容を保存します  
⑤保存内容を確認し、送信します  
<img src="auto_twitter_top.png" width="700" height="700">  
↑入力画面です。  
  
  
<img src="auto_twitter_create.png" width="700" height="700">  
↑保存完了画面です。  

# 制作背景
ある企業様から、「大量のアカウントに対してDMを自動で送りたい」というご要望をいただき、このアプリを制作いたしました。  

# 工夫したポイント
工夫したポイントは、APIの時間内の使用制限を回避しサーバーのレスポンスを30秒以内に返させるために、JavaScriptで自動クリックを実装したことです。  
例えば100件のDMを送りたい場合、一回のリクエストで行おうとするとAPIの使用制限を超えてしまい、DMを送れなくなってしまいます。またそれを回避すべくsleepを使い、2分に一回DMを送るというように調整しても、今度は30秒以上レスポンスが返ってこなくなるため、エラーが起きてしまいます。  
そこでJavaScriptで自動クリックを実装し、クライアント側で2分待つようにしました。  
具体的な仕組みはこうです。大元の送信ボタン（親ボタン）と、1アカウントずつに送信するボタン（子ボタン）の二つを用意しておきます。そして親ボタンを押した際に、自動的に子ボタンをクリックするようにし、保存していたデータの内1件のアカウントにメッセージを送信します。そしてその子ボタンは2分後に再度クリックするようにループさせています。  
このようにすることで、サーバー側で待たすようなことをせず連続して自動でDMを送ることに成功しました。

# 使用技術(開発環境)
- フロントエンド（HTML5、CSS3、Ruby、JavaScript）
- バックエンド（Ruby on Rails6.0）
- Webサーバ（Heroku）
- データベース（MySQL）
- 開発環境（MacOS, VScode, Git, GitHub）  

# DB設計
### send_infos テーブル

| Column         | Type    | Options     |
| -------------- | ------- | ----------- |
| name           | string  | null: false |
| atena          | string  | null: false |
| text           | string  | null: false |

