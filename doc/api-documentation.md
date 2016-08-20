#API Documentation

`https://return-path-api.herokuapp.com/api`

### Messaging

Every endpoint returns a JSON object. Each object has two nested objects, a response message and the data to be sent for the request.

A request that can not be completed follows the same structure. A response message and a data object that will inform what may be missing to fulfill the request if applicable. An unsuccessful POST for a  link will follow:

```
{
  "response": "Link could not be created",
  "data": {
    "url": [
      "can't be blank"
    ]
  }
}
```
In this example a required field("url") was not submitted.

### Database structure 

This API  access a database which stores the information for a link aggregation site. There are three tables, links, comments, and votes. A link has columns for url and title, which are strings of text.

Comments are associated with a link through a link id and must be provided a link id for creation. Comments have a body column which is a string of text.

Votes can be associated with either a link or a vote, and must be provided with the id of either. In addition a vote must be given a string to indicate if the id is for a link or comment. Votes can be an "up" or "down" vote. This is indicated with the vote_type column on the table.

### Root

The root of the api is name spaced under `/api`.

The root of the project returns an JSON object of all of the Links stored in the database. The links are sorted by an aggregate vote count, with the higher some of "up" and "down" votes being first in the list. The list object comes with an array of all of it's comments which are also sorted by aggregate vote count. An example follows:

```
id: 5,
url: "www.google.com",
title: "Qui numquam illo quia tenetur.",
created_at: "2016-08-19T01:56:55.722Z",
updated_at: "2016-08-19T01:56:55.722Z",
aggregate_vote_count: 2,
sorted_comments: [
	{
		id: 9,
		body: "Ea et enim sed error atque nihil.",
		link_id: 5,
		created_at: "2016-08-19T01:56:55.762Z",
		updated_at: "2016-08-19T01:56:55.762Z",
		aggregate_vote_count: 0
	}
],
comments: [
	{
		id: 9,
		body: "Ea et enim sed error atque nihil.",
		link_id: 5,
		created_at: "2016-08-19T01:56:55.762Z",
		updated_at: "2016-08-19T01:56:55.762Z",
		aggregate_vote_count: 0
		}
	]
},
```

### Links

Links can be accessed under `/api/v1/links`

#### GET

`/api/v1/links` Has the same return as root.

`/api/v1/links/(:id)` Will show the information for the link with the given id number. This includes comments sorted by votes, and sorted by updated time.

For example `/api/v1/links/9` returns:

```
response: "Success",
data: {
id: 9,
url: "www.google.com",
title: "Sed inventore qui libero ut ab reprehenderit recusandae.",
created_at: "2016-08-19T01:56:56.151Z",
updated_at: "2016-08-19T01:56:56.151Z",
aggregate_vote_count: -1,
sorted_comments: [
	{
	id: 15,
	body: "Quidem facilis magni impedit qui quia corrupti.",
	link_id: 9,
	created_at: "2016-08-19T01:56:56.175Z",
	updated_at: "2016-08-19T01:56:56.175Z",
	aggregate_vote_count: -1
	},
	{
	id: 16,
	body: "Totam quo iure magni illum aut rerum.",
	link_id: 9,
	created_at: "2016-08-19T01:56:56.232Z",
	updated_at: "2016-08-19T01:56:56.232Z",
	aggregate_vote_count: -3
	}
],
comments: [
	{
		id: 15,
		body: "Quidem facilis magni impedit qui quia corrupti.",
		link_id: 9,
		created_at: "2016-08-19T01:56:56.175Z",
		updated_at: "2016-08-19T01:56:56.175Z",
		aggregate_vote_count: -1
	},
	{
		id: 16,
		body: "Totam quo iure magni illum aut rerum.",
		link_id: 9,
		created_at: "2016-08-19T01:56:56.232Z",
		updated_at: "2016-08-19T01:56:56.232Z",
	aggregate_vote_count: -3
	}
	]
}
```

#### POST

New links are created by sending a POST request to `/api/v1/links`

POST requests for links must include the title and url for a link in order for the record to be saved. The formatting must be as follows:

```
{
	links: {
		title: "link_title"
		url: "link_url"
	}
}
```

_Note: I used the links instead of link to avoid potential JavaScript issues._

The return value for a successful creation: 

```
{
  "response": "Success",
  "data": {
    "id": 17,
    "url": "Link Url",
    "title": "Link title",
    "created_at": "2016-08-20T16:56:11.051Z",
    "updated_at": "2016-08-20T16:56:11.051Z",
    "aggregate_vote_count": 0,
    "sorted_comments": [],
    "comments": []
  }
}
```

#### DELETE

Links are deleted by sending a DELETE request to `/api/v1/links/(:id)`. Where (:id) is the id of the link to be deleted. The return of a successful deletion:

```
{
  "response": "Link destroyed"
}
```

Deleting a link will delete all of the votes and comments associated with that link. The deletion of a link's comments will also delete of the votes associated with the link's comments.

### Comments

Comments are accessed with `/api/v1/comments`

#### GET

`/api/v1/comments` Will return all of the comments in the database with the newest comments first and the oldest last. This was done assuming that the most relevant comments would be the newest. A return example follows: 

```
{
  "response": "Success",
  "data": [
    {
      "id": 30,
      "body": "WHERE",
      "link_id": 9,
      "created_at": "2016-08-19T20:01:40.380Z",
      "updated_at": "2016-08-19T20:01:40.380Z",
      "aggregate_vote_count": 0
    },
    {
      "id": 24,
      "body": "Saepe iusto quibusdam porro qui quaerat quae minus aliquam.",
      "link_id": 9,
      "created_at": "2016-08-18T19:03:03.825Z",
      "updated_at": "2016-08-18T19:03:03.825Z",
      "aggregate_vote_count": 2
    },
},
```

`/api/v1/comments/(:id)` Will return a comment with that matches the given (:id). For example `/api/v1/comments/7` returns: 

```
{
  "response": "Success",
  "data": {
    "id": 7,
    "body": "Voluptate officia quasi voluptatem explicabo.",
    "link_id": 3,
    "created_at": "2016-08-18T19:03:03.167Z",
    "updated_at": "2016-08-18T19:03:03.167Z",
    "aggregate_vote_count": -1
  }
}
```

#### POST

New comments are created by sending a POST request to `/api/v1/comments`

POST requests for comments must include the body and link_id(the link must exist) for a comment in order for a record to be saved. The formatting must be as follows:

```
{
	comment: {
		body: "comment_body"
		link_id: "the id of an existing link record"
	}
}
```

The return for a successful POST follows: 
```
{
  "response": "Success",
  "data": {
    "id": 36,
    "body": "Comment body",
    "link_id": 3,
    "created_at": "2016-08-20T17:37:01.716Z",
    "updated_at": "2016-08-20T17:37:01.716Z",
    "aggregate_vote_count": 0
  }
}
```

#### DELETE

Comments are deleted by sending a DELETE request to `/api/v1/comments/(:id)` where (:id) is the id of a comment. The result of a successful delete is:

```
{
  "response": "Comment destroyed"
}
```

Deleting a comment will delete all of the votes associated with that comment.

### Votes

Votes are accessed under `/api/v1/votes`

#### GET

`/api/v1/votes` Will return all of the votes in the database with the newest votes first and the oldest last. This was done assuming that the most relevant votes would be the newest. A return example follows:

```
{
  "response": "Success",
  "data": [
    {
      "id": 121,
      "vote_type": "down",
      "votable_type": "Comment",
      "votable_id": 10,
      "created_at": "2016-08-19T20:17:32.535Z",
      "updated_at": "2016-08-19T20:17:32.535Z"
    },
    {
      "id": 120,
      "vote_type": "down",
      "votable_type": "Comment",
      "votable_id": 10,
      "created_at": "2016-08-19T20:17:31.802Z",
      "updated_at": "2016-08-19T20:17:31.802Z"
    },
  }
```

`/api/v1/votes(:id)` will return a vote with the given (:id). For example `/api/v1/votes/121` will return:

```
{
  "response": "Success",
  "data": {
    "id": 121,
    "vote_type": "down",
    "votable_type": "Comment",
    "votable_id": 10,
    "created_at": "2016-08-19T20:17:32.535Z",
    "updated_at": "2016-08-19T20:17:32.535Z"
  }
}
```

####POST

New votes are create by sending a POST request to `/api/v1/votes`.

POST requests for votes must contain: A vote_type which takes a string of "up" or "down", a votable_type which takes a string of "Link" or "Comment" and a votable_id which must match an existing vote or comment record. An example of a valid POST request:

```
{
	vote: {
		vote_type: "up",
		votable_type: "Link",
		votable_id: "the id matching the Link record"
	}
}
```

The return for a valid POST request follows:

```
{
  "response": "Success",
  "data": {
    "id": 122,
    "vote_type": "up",
    "votable_type": "Comment",
    "votable_id": 10,
    "created_at": "2016-08-20T18:07:17.122Z",
    "updated_at": "2016-08-20T18:07:17.122Z"
  }
}
```

#### DELETE

Votes are deleted by sending a DELETE request to `/api/v1/votes/(:id)` where (:id) is the id of an existing vote. The result of a successful delete is:

```
{
  "response": "Vote destroyed"
}
```