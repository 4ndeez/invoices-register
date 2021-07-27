## README
___
### Version
Ruby 2.6.4 & Rails 5.2.6

### Install
```
bundle install
rake db:migrate
rake db:seed
```
___
### Additional information

Added operations model and controller to handle money deposit and transfers

### Problems
User tags are not implemented properly

### TODO
* remaster tags
* refactor specs
* upload on heroku
___

## API
API contain lots of requests but only important ones are described
___

### Users
#### CREATE
`POST /api/v1/user`

Accepting parameters[first_name, last_name, middle_name, id]
###### request
````
curl -d '{"first_name": "Example", "last_name": "Example","id": 123123}'
-H 'Content-Type: application/json' -X POST http://localhost:3000/api/v1/users
````
###### response
````
{"id":123123,"first_name":"Example","last_name":"Example","middle_name":null,
"created_at":"2021-07-27T07:13:45.611Z","updated_at":"2021-07-27T07:13:45.611Z","tag_list":[]}
````
___
### Invoices
#### CREATE
`POST /api/v1/invoice`

Accepting parameters[currency, amount, user_id]
###### request
````
curl -d
'{"currency":"USD", "amount": 100, "user_id":123123}' 
-H 'Content-Type: application/json' -X POST http://localhost:3000/api/v1/invoices

````
###### response
````
{"id":123123236,"currency":"USD","user_id":123123,"amount":100.0,
"created_at":"2021-07-27T09:46:05.056Z","updated_at":"2021-07-27T09:46:05.056Z"}
````

#### DEPOSIT
`POST /api/v1/deposit`

Accepting parameters[currency, amount, receiver_id]
###### request
````
curl -d 
'{"currency": "USD", "amount": 100, "receiver_id":123123}' 
-H 'Content-Type: application/json' -X POST http://localhost:3000/api/v1/deposit
````

###### response
````
{"amount":200.0,"id":123123236,"currency":"USD","user_id":123123,
"created_at":"2021-07-27T09:46:05.056Z","updated_at":"2021-07-27T10:06:38.955Z"}
````

#### TRANSFER
`POST /api/v1/transfer`

Accepting parameters[currency, amount, receiver_id, sender_id]
###### request
````
curl -d 
'{"currency": "USD", "amount": 100, "receiver_id":123123, "sender_id":321321}' 
-H 'Content-Type: application/json' -X POST http://localhost:3000/api/v1/deposit
````

###### response
````
{"amount":200.0,"id":123123236,"currency":"USD","user_id":123123,
"created_at":"2021-07-27T09:46:05.056Z","updated_at":"2021-07-27T10:06:38.955Z"}
````
___
### Reports
#### ALL
`GET /api/v1/report/all`

Accepting parameters[datetime_from, datetime_to, user_id]
###### request
````
curl -X GET -H "Content-type: application/json" -H "Accept: application/json"
-d '{"datetime_from":"2021-07-07", "datetime_to":"2021-07-27"}' "http://localhost:3000/api/v1/report/all"
````
###### response
````
{"USD":[{"id":1,"currency":"USD","receiver_id":15315497,"sender_id":null,"amount":100.0,
"created_at":"2021-07-27T07:05:37.923Z","updated_at":"2021-07-27T07:05:37.923Z"},
"BYN":[{"id":6,"currency":"BYN","receiver_id":15315497,"sender_id":null,"amount":200.0,
"created_at":"2021-07-27T07:05:38.786Z","updated_at":"2021-07-27T07:05:38.786Z"}
````

#### MIN-MAX-AVERAGE
`GET /api/v1/report/min_max_average`

Accepting parameters[datetime_from, datetime_to]

###### request
````
curl -X GET -H "Content-type: application/json" -H "Accept: application/json" 
-d '{"datetime_from":"2021-07-07", "datetime_to":"2021-07-30"}' "http://localhost:3000/api/v1/report/min_max_average"
````

###### response
````
{"min":10.0,"max":200.0,"avg":85.0}
````

#### SUMMARY
`GET /api/v1/report/summary`

Without parameters
###### request
````
curl -i -H 'Accept:application/json' http://localhost:3000/api/v1/report/summary
````

###### response
````
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: 62b13aea-3503-47e2-a5c2-554b4618e781
X-Runtime: 0.005333
Transfer-Encoding: chunked

{"USD":5700.0,"BYN":5000.0}
````
___