# README
This API is designed for vehicles that can register themselves and subsequently update their current location.
The database (postgresql) therefore has two models: vehicles and locations (1:N).

To try it out, simply clone this repository and start the rails server through the terminal. It runs on localhost 3000.

To create a new vehicle, a **POST** request can be made through **http://localhost:3000/vehicles**.
PostgreSQL is setup in a way that it takes UUIDs instead of autoincrementing id's and since each vehicle should register with its own UUID, this information needs to be provided in the params, such as **http://localhost:3000/vehicles?id=bac5188f-67c6-4965-81dc-4ef49622e280**
For this POST-Request, no content will be contained in the response body (status 204).

To delete (de-register) a vehicle, a **DELETE** request can be made through **http://localhost:3000/vehicles/:id**.
In this example, the just created vehicle could be deleted by making the following request: **http://localhost:3000/vehicles/bac5188f-67c6-4965-81dc-4ef49622e280**.
For this DELETE-Request, no content will be contained in the response body (status 204).

Deleting the vehicles would also result in deleting all the corresponding locations. Since this is an undesirable turnout, soft-delete was implemented for both models, vehicles and locations.
Upon delete requests, records will just be hidden but are still available for future analysis purposes
  - call 'really_destroy!' to delete a record from the database
  - call 'only_deleted' to get access to all soft-deleted records
  - call 'restore(id, :recursive => true)' to restore a record with their associated records

This feature was implemented by using the *Paranoid-Gem*. For more information on how to use it please refer to: *https://github.com/rubysherpas/paranoia*

To create a new location for an existing vehicle, a **POST** request can be made through **http://localhost:3000/vehicles/:vehicle_id/locations**.
However, to create a new location, latitude and longitude are mandatory instances and need to be provided through the params.
One such request could be the following: **http://localhost:3000/vehicles/bac5188f-67c6-4965-81dc-4ef49622e280/locations?lat=52.543&lng=13.415**.
Furthermore, the location will only be considered as valid and therefore be saved to the database, if the distance to the following coordinates is no bigger than 3.5 kilometres (latitude 52.53 and longitude 13.403).
To calculate the distances, the 'geocoder-gem* has been used. Please refer to *https://github.com/alexreisner/geocoder* for more information on the usage.

To display the most current location of a given vehicle, a **GET** request can be made through **http://localhost:3000/vehicles/:id**.
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

However, if you would like to connect your frontend (e.g. a separate React-Application) to the API, you can subscripe to the *locations_channel*. A connection will be setup through *ActionCable* and locationupdates will be broadcasted as soon as a new locationrecord is saved to the database.
Save the following two endpoints as constants:
  ```
  const API_ROOT = 'http://localhost:3000';
  const API_WS_ROOT = 'ws://localhost:3000/cable';
  ```
Since websockets do not run on the HTTP, but on their own protocol based on TCP, we do have a seperate root which is used for the frontend to establish the connection through websockets.

If you use a react-frontend, run in your terminal *yarn add react-actioncable-provider* (or npm instead of yarn) to install this package. It provides an ActionCable context provider and consumer that allows your application to subscripe to channels (https://www.npmjs.com/package/react-actioncable-provider).
For the complete setup, please follow the steps explained on its webpage.
Furthermore, make sure that your react-application **does not** run on the same local server as the rails api does (localhost:3000).

Also, please feel free to make suggestions. I am still learning so I would be very happy for any feedback that I can get.
