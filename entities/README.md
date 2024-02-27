# Entities 

## API

### Node 

#### Create 

Note the type `a` , creates an entity type `a`.
`a` needs to be registered, in the time of boot.
Given:

```shell
curl -XPUT "localhost:4201/entity/a" -d '{ "name" : "aneesh" , "author" : "a:admin" }' 
```

Produces:

```json
{"urn" : "a:22FK3E8TtzC"}
```

#### Update 
Note the use of the `urn` in the url.
Given:

```shell
curl -XPOST "localhost:4201/entity/a:22FK3NEDvIc" -d '{ "apply" : { "pos" : "jobless" } , "author" : "a:admin" }'  
```
Produces:

```json
{"urn" : "a:22FK3NEDvIc"}
```
In case one needs to specify nested property, use `prop/nested` syntax. Read up in `JxPath`. 

### Relations

#### Adding 
Note that it needs `src`, `dst` and the `author` to create a Relation.
Moreover, the type of relation is encoded in the `REST` path: `/r1` .
If successful will produce:

```json
{"message" : "ok", "status" : true}
```

Given:

```shell
curl -XPOST "localhost:4201/relate/r1" -d '{ "src" : "a:22FK3NEDvIc", "dst" : "a:22FK3E8TtzC" , "author" : "a:admin" }'  
```

#### Removing 

```shell
curl -XPOST "localhost:4201/relate/r1" -d '{ "src" : "a:22FK3NEDvIc", "dst" : "a:22FK3E8TtzC" , "author" : "a:admin" }' 
```



## Design 

