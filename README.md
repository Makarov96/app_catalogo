# app_catalogo

Is a sample project

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Step by Step

### First run

    1. flutter pub get -> for all modules
    2. flutter packages pub run build_runner build --delete-conflicting-outputs -> for core_catalogo_module && app_catalogo
    3. run test into app_catalogo -> flutter test --> Check the terminal you are pointing to app_module

## Apis

### URL BASE

  'https://growing-drake-40.hasura.app/api/rest';

### Get All Categories

  1. Dont Need an argument

  2. Sample URL: [https://growing-drake-40.hasura.app/api/rest/categories]
  3. Method: GET
  4. Response:

  ```
  {
 "product_category": [
  {
   "description": "Shoes",
   "id": 2
  },
  {
   "description": "Jeans",
   "id": 3
  },
  {
   "description": "t-shirt",
   "id": 4
  }
 ]
}
  ```

### URL

'$_urlBase/categories'

### Search By Prodcut Name

  1. Method: GET
  2. Need an argument type String
  3. nike is the argument type String
  4. Sample URL: [https://growing-drake-40.hasura.app/api/rest/search/nike]
  5. Response:

  ```
  {
 "product": [
  {
   "id": 2,
   "is_favorite": false,
   "product_category": 2,
   "product_description": "Nike Air Max 1",
   "product_image": "https",
   "product_name": "Nike Air Max 1",
   "product_price": "$2,300.00",
   "quantity_available": 30,
   "url_more_detail": "https://"
    } 
   ]
}
  ```

### Search By Tag Category

  1. Need an argument type int
  2. 2 is the argument type int
  3. Sample URL: [https://growing-drake-40.hasura.app/api/rest/searchbytag/2]
  4. Method: GET
  5. Response:

  ```
  {
"product": [
{
 "id": 2,
 "is_favorite": false,
 "product_category": 2,
 "product_description": "Nike Air Max 1",
 "product_image": "https",
 "product_name": "Nike Air Max 1",
 "product_price": "$2,300.00",
 "quantity_available": 30,
 "url_more_detail": "https://"
    } 
   ]
}
  ```

### Get All Products

  1. Need two params offset and limit
  2. offset represent current page and limit is cant product get
  3. Sample URL: [https://growing-drake-40.hasura.app/api/rest/products/offset/limit]
  4. Method: GET
  5. Response:

```
{
"product": [
{
 "id": 2,
 "is_favorite": false,
 "product_category": 2,
 "product_description": "Nike Air Max 1",
 "product_image": "https",
 "product_name": "Nike Air Max 1",
 "product_price": "$2,300.00",
 "quantity_available": 30,
 "url_more_detail": "https://"
    }
    ... and more data
   ]
}
  ```

### Set favorite product

 1. Need a json body
 2. Sample URL: [https://growing-drake-40.hasura.app/api/rest/updatefavoriteproduct]
 3. Method: PUT
4: Response body

```
{
 "update_product_by_pk": {
  "id": 2,
  "is_favorite": false
 }
}
```

