# 42

> Event Bus Driven Final Answer to Life, Universe and Everything that is ERP Basis using RAMA and Cowj
Hence 42.

## Uber Design 

Business API are essentialy:
1. GET ( reporting , R in CRUD ) 
2. PUT/POST ( CUD )

(2) becomes an entity storage problem, which is 
maintained in `Storage` that is `versioned` ( S3/AWS ) along with `GraphDB` to produce `KEG` - Knoweldge Graph.
Relations are not maintained in the hard way. Verbs/Edges can be created as we go along.

All of these `calls` are maintained in the `enterprise event bus` which is a `RAMA` system.

## Components 

1. Entity Store & APIs  
2. RAMA Event System 
3. Business API layer ( customizable, scriptable )

### Entity Storage 

Every entity has an `URN` like `urn:<org_id>:<class>:<random_id>` that uniquely identifies
the entity about:
1. Org
2. Class ( what type of business entity )
3. Random ID that is unique within the Org,Class  

#### Graph Storage 

Neo4j. Stores the unique id for the entity, and minimal properties.
Primary use case is maintaining business relation - in a fairly `soft`, `non-relational-db` way.

#### Version Storage

This is the JSON store for the entity. A single JSON with all properties, versioned.
Special fields are 

1. `_edied_` which stores the responsible person who last edited it
2. `_reson_` which stores the Event ID which prompted it to be edited

0'th version `_edited_` would be the person who authored the entity first time.

### Eventing 

Entire system starts from random business API calls - which produces `events` which needs to be pushed, 
and consumed. A RAMA system is put into place for this reason.

#### RAMA Publish

The RAMA endpoint where anyone can push event. 
An event has 
1.  temporal `event-id`
2. along with a `class/type` 
3.  `payload` which is `JSON`  
4. and various `entity-id`s relating via the event.


#### RAMA Consumer 

A typical batch job running at an interval for maximum 1 min to consume all events of last minute.
Enterprise level 1 min is more than good enough, although we can move to even 1 sec consumption.

This consumer finds out what relations are being created between entities and update the Entity Storage.
This would require custom coding based on the `class/type` of event, hence each `event` must have different processors.

Thus, it is natural to have RAMA events such that each `class` gets a different topic.

### Business API Layer
This is the external facing API system whic when triggered 

1. Generate events in the system
2. Optionally does CRUD using the `Entity` storage APIs.


