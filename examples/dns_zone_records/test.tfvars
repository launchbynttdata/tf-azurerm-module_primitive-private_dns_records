zone_name = "launchexample.nttdata.com"
a_records = {
  "first" = {
    ttl     = 300
    records = ["20.0.0.1"]
    tags    = { "test" = "false" }
  },
  "second" = {
    ttl     = 300
    records = ["20.0.0.2", "20.0.0.3"]
    tags    = { "test" = "true" }
  }
}
cname_records = {
  "first" = {
    ttl    = 100
    record = "www"
    tags   = { "test" = "www" }
  },
  "second" = {
    ttl    = 100
    record = "www.test.com"
    tags   = { "test" = "www.test.com" }
  }
}
txt_records = {
  "first" = {
    ttl     = 100
    records = ["random-text"]
    tags    = { "test" = "random-text" }
  },
  "second" = {
    ttl     = 100
    records = ["random-text-2", "random-text-3"]
    tags    = { "test" = "random-tag" }
  }
}
