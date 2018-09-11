# Amazon Product Fetcher

This application allows a user to enter an Amazon Product's ASIN and then fetches the category, rank & product dimensions of that product on Amazon.

The application then stores the data related to the request of the page and it's HTTP response (status and body). Upon successful parsing of the product page, the product data is stored relationally in the database and joined to the initial page request record.

#### Screencast

[https://www.screencast.com/t/Ca8O7L2Z1R](https://www.screencast.com/t/Ca8O7L2Z1R)

#### Content Parsing Strategy

The general strategy towards parsing data out of the HTML content is as follows:

1. Load the entire product page into a DOM object.
2. Locate the content sections surrounding the target content e.g. dimensions. See "[locators](https://github.com/alkema-ca/amazon_product/tree/master/app/integrations/amazon/locators)".
3. Parse the inner text of the located DOM node using some regular expressions. See "[extractors](https://github.com/alkema-ca/amazon_product/tree/master/app/integrations/amazon/extractors)"
4. In [some cases](https://github.com/alkema-ca/amazon_product/blob/master/app/integrations/amazon/extractors/primary_category.rb#L33) a fallback is used to scan the entire page if the located page node is empty. This is helpful because Amazon HTML structure can change page to page.

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
