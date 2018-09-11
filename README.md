# Amazon Product Fetcher

This application allows a user to enter an Amazon Product's ASIN and then fetches the category, rank & product dimensions of that product on Amazon.

The application then stores the data related to the request of the page and it's HTTP response (status and body). Upon successful parsing of the product page, the product data is stored relationally in the database and joined to the initial page request record.

#### Content Parsing

The general strategy towards parsing the content out is to:

1. Load the page into a DOM object
2. Locate the content sections surrounding the target content e.g. dimensions
3. Parse the inner text of the located DOM node using some regular expressions
4. In some cases a fallback is used to scan the entire page if the located page node is empty. This is helpful because Amazon HTML structure can change page to page.

#### [Live Demo](https://amazon-product.herokuapp.com/)

#### Ruby version

2.5.1

#### Database creation

```
rake db:create
rake db:migrate
```

#### Test suite

```
rspec
```

#### Linting

```
rubocop -R
```
