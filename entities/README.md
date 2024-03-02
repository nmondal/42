# Entities 

## Design 

## Entity Class

Any business entity must be classified into a `class`.
An example would be - modelling a ticketing system.
In there, one class would be `People`.
Another class would be `Issue`.
Another class would be `Comment`.
With these primary `class` we can now keep on building the entire ticketing system.

## Relation - Reference Injection Inversion ( RRI )

Conventional `field` like : `created_by` can be replaced via `author` any ways, 
being said that, other fields stops becoming fields ( reference ) and becomes 
`relation` between entities.
`create_by` is a relationship now as follows: 

```cypher
(p:Person) - [r:Created] -> (t:Ticket)
(t:Ticket) - [r:CreatedBy] -> (p:Person)
```
In this way, one can keep on arbitrarily connect entities.
For information compression, we can chose to keep only one relation, while the inverted
relation is automatic.

Note that, this is an inversion of relation injection.
Conventional wisdom, as `field` as in: `Person.authoredTickets` and `Ticket.createdBy` 
while we invert this injection of `reference`, via converting `relational field` with relationship.

### Mutable Relationships
In a real world relationships mutate. Let's model the problem of `employed-by`. 
Given a single company, relational way to model it would be having a `Person` table, and table where `startDate` and
`endDate` is mentioned against one person. This pose 2 problems.

1. A person can be employed multiple times in an org
2. Making it global, would require to have either one table per org, or an universal table with all companies 
where all data would be references, like `person-id, company-id`. This would mandate unique `employment-id`
which describes the row.

In `RRI` a much simpler solution exists - create a Corp persona and simply create a relationship `employed-by`.
If a person has multiple employment in the same org, then that gets stored automatically in versioned mode.

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


#### Read

Simple RESTFUL:

```shell
curl "localhost:4201/entity/a:22G9ahiRr5m"
```
Produce the body as follows:

```jsonc
{"urn" : "a:22G9ahiRr5m", "author" : "a:admin", 
    "relations" : [ {"name" : "r1", "other" : "a:22G9YwF306J", "is_start" : true} ]
   /*...other properties... */ 
 }
```
As one can see, it returns the relations too.

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
curl -XPOST "localhost:4201/unrelate/r1" -d '{ "src" : "a:22FK3NEDvIc", "dst" : "a:22FK3E8TtzC" , "author" : "a:admin" }' 
```

## Design 

