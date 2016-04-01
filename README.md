# Parallel Ping

### Clone the project
```shell
git clone https://github.com/xofred/parallel_ping.git
```

### Install the gems needed
( assuming u have `Ruby` and `Bundler` already installed )

```shell
bundle install
```

### Replace the `server_list.txt`
( one server per line )
```
p1.jp1.bookcoco.com
p2.jp1.bookcoco.com
(And so on...)
```

### Run:
```shell
ruby ping.rb
```

Or u can specify the ping count with another number ( default is 4 ).

```shell
ruby ping.rb 20
```

( Time past... )

### And the result:
```
       user     system      total        real
Parallel Ping using 4 cores, waiting for results...
  0.010000   0.010000   0.260000 (  3.514448)
"The One:"
{
         :name => "p1.hk1.bookcoco.com (103.6.86.141)",
    :loss_rate => 0.0,
          :avg => 27.996
}
```


