# README
This API is designed for vehicles that can register themselves and subsequently update their current location.
The database (postgresql) therefore has two models: vehicles and locations (1:N).

To try it out, simply clone this repository and start the rails server through the terminal. It runs on localhost 3000.

To create a new vehicle, a **POST** request can be made through **http://localhost:3000/vehicles**
PostgreSQL is setup in a way that it takes UUIDs instead of autoincrementing id's and since each vehicle should register with its own UUID, this information needs to be provided in the params, such as **http://localhost:3000/vehicles?id=bac5188f-67c6-4965-81dc-4ef49622e280**
For this POST-Request, no content will be contained in the response body (status 204).

To delete (de-register) a vehicle, a **DELETE** request can be made through **http://localhost:3000/vehicles/:id**
In this example, the just created vehicle could be deleted by making the following request: **http://localhost:3000/vehicles/bac5188f-67c6-4965-81dc-4ef49622e280**
For this DELETE-Request, no content will be contained in the response body (status 204).

Deleting the vehicles would also result in deleting all the corresponding locations. Since this is an undesirable turnout, soft-delete was implemented for both models, vehicles and locations.
Upon delete requests, records will just be hidden but are still available for future analysis purposes
  # call 'really_destroy!' to delete a record from the database
  # call 'only_deleted' to get access to all soft-deleted records
  # call 'restore(id, :recursive => true)' to restore a record with their associated records

This feature was implemented by using the *Paranoid-Gem*. For more information on how to use it please refer to: *https://github.com/rubysherpas/paranoia*

To create a new location for an existing vehicle, a **POST** request can be made through **http://localhost:3000/vehicles/:vehicle_id/locations**
However, to create a new location, latitude and longitude are mandatory instances and need to be provided through the params.
One such request could be the following: **http://localhost:3000/vehicles/bac5188f-67c6-4965-81dc-4ef49622e280/locations?lat=52.543&lng=13.415**
Furthermore, the location will only be considered as valid and therefore be saved to the database, if the distance to the following coordinates is no bigger than 3.5 kilometres (latitude 52.53 and longitude 13.403).
To calculate the distances, the 'geocoder-gem* has been used. Please refer to *https://github.com/alexreisner/geocoder* for more information on the usage.

To display the most current location of a given vehicle, a **GET** request can be made through **http://localhost:3000/vehicles/:id**
For example, the following GET request **http://localhost:3000/vehicles/bac5188f-67c6-4965-81dc-4ef49622e280** would return the following response body with a response status of 200:
```
"{
  "id": "ed32ff9c-597a-46ce-ab74-1c8fc93d130f",
  "lat": 52.543,
  "lng": 13.415,
  "created_at": "2019-08-01T07:37:39.235Z",
  "updated_at": "2019-08-01T07:37:39.235Z",
  "vehicle_id": bac5188f-67c6-4965-81dc-4ef49622e280",
  "address": "Ballhaus Ost, 15, Pappelallee, Helmholtzkiez, Prenzlauer Berg, Pankow,  Berlin, 10437, Germany",
  "deleted_at":null
}"
```

