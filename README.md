# Running the demo

```bash
$ make build #build docker image
$ make update #composer update
$ make demo #run
```

Note that the auto-instrumentation is initiated through composer's autoload/files, via `_register.php`.