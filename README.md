# Parallel Ping

### Clone the project ( assuming u have `Ruby` and `Bundler` already installed )
```shell
git clone https://github.com/xofred/parallel_ping.git
```

### Install `Celluloid` and `Awesome Print`

```shell
bundle install
```

### Replace the `server_list.txt` ( one server per line )
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

### ( Time past... )

### And the result:
```
I, [2016-03-30T21:27:13.828452 #24412]  INFO -- : Celluloid 0.17.2 is running in BACKPORTED mode. [ http://git.io/vJf3J ]
"Parallel Ping using 4 cores, waiting for results..."
"Least loss, then least latency:"
{
         :name => "p2.hk1.bookcoco.com (205.147.105.112)",
    :loss_rate => 0.0,
          :avg => 13.508
}
"Least latency, then least loss:"
{
         :name => "p2.hk3.bookcoco.com (161.202.44.130)",
    :loss_rate => 25.0,
          :avg => 8.616
}
```


