# Hotels Data Merge

Hotels Data Merge is a programming exercise implemented with an API Rails app.

## Local Setup

### Ruby version

This application requires [Ruby][ruby] (MRI) 2.5.6.

For Ruby gem installation, make sure you have [bundler][bundler] installed.
Rails 5.2.3 requires Bundler >= 1.3.0.

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

### Delivering the data

* Not implemented:
  * `If-Modified-Since` and `Last-Modified` headers can easily be supported in
  the application if an expiration mechanism is defined.

[ruby]: https://www.ruby-lang.org/en/documentation/installation/
[bundler]: http://bundler.io
[git]: https://git-scm.com/
