# Amazon Product Fetcher

This application allows a user to enter an Amazon Product's ASIN and then fetches the category, rank & product dimensions of that product from Amazon product pages.

The application then stores the data related to the request of the page and it's HTTP response (status and body). Upon successful parsing of the product page, the product data is stored relationally in the database and joined to the initial page request record.

#### Screencast

[https://www.screencast.com/t/Ca8O7L2Z1R](https://www.screencast.com/t/Ca8O7L2Z1R)

#### Content Parsing Strategy

The code related to parsing data out of the HTML content is found [here](https://github.com/alkema-ca/amazon_product/tree/master/app/integrations/amazon).

#### Ruby version

2.5.1

#### Database creation

```
cp config/database.example.yml config/database.yml
rake db:create
rake db:migrate
```

#### Test suite

```
rspec
```

#### Linting

```
rubocop
```
