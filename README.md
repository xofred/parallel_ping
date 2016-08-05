# Parallel Ping

Using system `ping` to find out the best server among given list

### Clone the project
```shell
git clone https://github.com/xofred/parallel_ping.git
```

### Install the gems needed
```shell
bundle install
```

### Server list
( one server per line )
```
p1.jp1.bookcoco.com
p2.jp1.bookcoco.com
(And so on...)
```

### Run:
```shell
ruby ping.rb <file_contain_server_list>
```

specify the ping count ( default is 4 )

```shell
ruby ping.rb <file_contain_server_list> 20
```
