# Events

## API

### Publishing Events 

Note the type `a` , creates an entity type `a`.
`a` needs to be registered, in the time of boot.
Given:

```shell
curl -XPUT "localhost:4202/event/evt_1" -d '{ "author" : "a:admin" , "entities" : [ "a:admin" ] , "data" : { "reason" : "test write" } }' 
```

Produces:

```json
{"status" : true, "message" :  "ok"}
```

