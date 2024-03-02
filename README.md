# 42

> Event Bus Driven Final Answer to Life, Universe and Everything that is ERP Basis using RAMA and Cowj
Hence 42.

For more information : [See This Video](https://www.youtube.com/watch?v=5ZLtcTZP2js).

## Pre Req
Cowj is the system used to build it. Here is [cowj](https://github.com/nmondal/cowj/)

## How to Run?
1. Run the gradle file to create the `jar-lib` folder 
2. Issue the command cowj with ` --add-opens java.base/jdk.internal.loader=ALL-UNNAMED` 

and run individual projects - as the cowj manual depicts.

## Uber Design 

Business API are de facto the following:
1. GET ( reporting , R in CRUD ) 
2. PUT/POST/DELETE ( Create, Update, Delete )
3. Relate multiple entities.

(2) becomes an entity storage problem, which is 
maintained in `Storage` that is `versioned` ( S3/AWS ) along with `GraphDB` to produce `KEG` - Knowledge Graph.
(3) Relations are not maintained in the hard way. Verbs/Edges can be created as we go along.

All of these `calls` are maintained in the `enterprise event bus` which is a `RAMA` system.
Read more about how `RAMA` is unconventional [here](https://github.com/nmondal/cowj/blob/main/manual/plugins.md#rama) 
We have events sorted by timestamp at the precision level of 1sec.

This project is the basis for building any `Enterprise Back-End` app, like Ticketing System, ERP, HRMS, and what not.

## Components 

1. Entity Store & APIs  
2. RAMA Event System & APIs
3. Business API layer ( customizable, scriptable ) - this is not provided because this is where you translate
the abstract entity structure into actual business case.

### Entity Storage 

Every entity has an `URN` like `urn:<org_id>:<class>:<random_id>` that uniquely identifies
the entity about:
1. Org
2. Class ( what type of business entity )
3. Random ID that is unique within the Org,Class  

This can be found in [entities](entities) folder.
`org` is omitted from implementation because we would not be working with across org `42` although, we can.


#### Graph Storage 

Neo4j. Stores the unique id for the entity, and minimal properties. In current implementation, 
no properties are stored.
Primary use case is maintaining business relation - in a fairly `soft`, `non-relational-db` way.
It also stores relations, and there `startTime` and `endTime` for a relation is stored.


#### Version Storage

This is the JSON store for the entity. A single JSON with all properties, versioned.
Special field is `author` which must be a valid `urn` to depict who was responsible for the creation, or edit.
0'th version `author` would be the person who authored the entity first time.

### Eventing 

Entire system starts from random business API calls - which produces `events` which needs to be pushed, 
and consumed. A RAMA system is put into place for this reason.

This can be found in [events](events) folder.

#### RAMA Publish

The RAMA endpoint where anyone can push event. 
An event has 
1.  temporal `event-id`
2. along with a `class/type` 
3.  `payload` which is `JSON`  
4. and various `entity-id`s relating via the event.


#### RAMA Consumer 

Batch consumer jobs running at an interval for maximum 1 min to consume all events of last minute.
Enterprise level 1 min is more than good enough, although we can move to even 1 sec consumption.

This consumer finds out what relations are being created between entities and update the Entity Storage.
This would require custom coding based on the `class/type` of event, hence each `event` must have different processors.

Thus, it is natural to have RAMA events such that each `class` gets a different topic.

### Business API Layer
This is the external facing API system which when triggered.
This can be found in [business](business) folder - which does not exist as of now. 


1. Generate events in the system
2. Optionally does CRUD using the `Entity` storage APIs.


