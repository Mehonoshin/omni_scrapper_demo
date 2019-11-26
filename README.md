# Omni Scrapper demo

Very basic demo of [omni_scrapper](https://github.com/Mehonoshin/omni_scrapper)

It illustrates how to create a simple scrapper in several lines of DSL.
This demo uses `gallery` crawler, which implements simple pagination logic through a list of items.


## Usage

Install all dependencies

```
bundle install
```

Start scrapping

```
./start main
```

Keep an eye on stdout for scrapping results.

## Dockerized

* `docker build -t omniscrapper/demo .`
* `docker run omniscrapper/demo`
