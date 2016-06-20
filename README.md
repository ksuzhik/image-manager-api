##TASK:
We are creating a mobile app that allows a user to resize uploaded photos. You need to create a backend server that will provide API for this app.

The main app functions:

* The user can use the mobile app to upload an image and pass resize parameters. In response, they will receive resized image
* User can see a list of their earlier resized images with resizing results and resizing parameters
* User can resize old image one more time passing old image id and new resize parameters
* When new user starts using a mobile app, the app sends a request to the server for a unique key which is used to subscribe user requests.
* API has to return information about all errors in proper format for invalid user inputs.
* All images should be returned as link to image and width and height values.
* We will need to handle different app versions for different clients. That’s why we need an API versioning mechanism.



##API METHODS:
* To create new user auth token: POST /api/user_auth_token
* To create and resize new image: POST /api/images/
	params: source_image, width, height
* To resize existing image: PUT /api/images/:image_id
	params: width, height
* To view all images: GET /api/images/