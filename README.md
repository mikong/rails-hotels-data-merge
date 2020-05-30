# Hotels Data Merge

Hotels Data Merge is a programming exercise implemented with an API Rails app.

## Local Setup

### Ruby version

This application requires [Ruby][ruby] (MRI) 2.5.7.

For Ruby gem installation, make sure you have [bundler][bundler] installed.
Rails 5.2.4.3 requires Bundler >= 1.3.0.

```bash
$ gem install bundler
```

### Other requirements

* [Git][git]

### Getting Started

Checkout the project with git:

```bash
$ git clone git@github.com:mikong/rails-hotels-data-merge.git
```

Install gems:

```bash
$ cd /path/to/project/rails-hotels-data-merge
$ bundle install
```

Start the Rails server:

```bash
$ rails s
```

Access the site on your browser at http://localhost:3000.

### Endpoint

The endpoint of the server is https://localhost:3000/hotels and accepts either
`hotels` or `destination` parameter.

* by destination: http://localhost:3000/hotels?destination=5432
* by hotels: http://localhost:3000/hotels?hotels=iJhz,SjyX

## Optimizations

### Procuring the data

* If neither hotels nor destination parameters are submitted, skip request to
Suppliers API.
* Only process the requested hotels. When the data is received from the
Suppliers, the results are filtered by hotel ID or destination ID. The Adapter
dynamically uses a different key for hotel ID or destination ID depending on
the Supplier.

* Not implemented:
  * Cache data from Supplier to prevent Supplier request on every hotels
  request.
  * Read timeout for API requests to Supplier wasn't added

### Delivering the data

* Not implemented:
  * `If-Modified-Since` and `Last-Modified` headers can easily be supported in
  the application if an expiration mechanism is defined.

## Data Merging Strategy

### Prioritizing Suppliers

For the following fields:

* `id`
* `destination_id`
* `name`
* `location`
  * `lat`
  * `lng`
  * `address`
  * `city`
  * `country`
* `description`
* `booking_conditions`

a priorities hash defines which suppliers to prioritize:

```ruby
# from app/models/hotel_builder.rb:

  PRIORITIES = {
    id: [:A, :B, :C],
    destination_id: [:A, :B, :C],
    name: [:C, :B, :A],
    description: [:B, :A],
    booking_conditions: [:B],
  }

  LOCATION_PRIORITIES = {
    lat: [:C, :A, :B],
    lng: [:C, :A, :B],
    address: [:B, :A, :C],
    city: [:A],
    country: [:B, :A],
  }
```

The Suppliers are identified as A, B, and C, and the existence of the value is
checked in order of priority. The first value obtained is used.

### Amenities

For Amenities, if a supplier has not categorized its amenities by Room or
General, these are initially assumed to be General by default. The amenities
from all suppliers are then combined. Any duplicate amenities within each
category are removed. Finally, General amenities are compared with Room
amenities. If a General amenity is present in the Room amenities, it is removed
from the General category.

### Images

For images, all images from all suppliers are collected. Duplicates are removed
by comparing the URL of the images.

[ruby]: https://www.ruby-lang.org/en/documentation/installation/
[bundler]: http://bundler.io
[git]: https://git-scm.com/
