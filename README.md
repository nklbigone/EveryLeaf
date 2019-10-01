Columns    |Data Type
-----------| ----------
user_id    | integer
First_name | string
Last_name  | string
UserName   | integer
Password   | string 
TimeStamp  |timestamp|


Columns  |Data Type
---------| --------
task_id  | integer
Title    | string
TaskName | string
user_id  | integer
TimeStamp| timestamp


git add -A
git commit -m "init"
git push heroku master
heroku run rake db:migrate
