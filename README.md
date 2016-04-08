# Parallel Ping

System's Ping is good if u want to see the status of **ONE** server. But when u have a list of servers, pinging them one by one is unefficient and annoying. That's why I created this project.

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
Time: 00:00:03 Time: 00:00:03 100.00% Processed: 34 from 34
"The One:"
{
         :name => "p1.hk1.bookcoco.com (103.6.86.141)",
    :loss_rate => 0.0,
          :avg => 47.25
}
```
