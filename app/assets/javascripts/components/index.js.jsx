/* globals React */
/* exported Index */
var Index = React.createClass({
  getInitialState: function() {
    return {
      allObjects: []
    };
  },

  componentDidMount: function() {
    var that = this;
    var url = "/api/v1/" + this.props.attr;
    $.getJSON(url, function(response) {
      that.setState({allObjects: response.data});
    });
  },

  componentDidUpdate: function() {
    var that = this;
    var url = "/api/v1/" + this.props.attr;
    $.getJSON(url, function(response) {
      that.setState({allObjects: response.data});
    });
  },

  whichMap: function() {
    if (this.props.attr === "links") {
      return (
        this.state.allObjects.map(function(link) {
          return (<LinkDisplay key={link.id}
                               id={link.id}
                               url={link.url}
                               title={link.title}/>);
        })
      );
    } else if (this.props.attr === "comments") {
      return (
        this.state.allObjects.map(function(comment) {
          return (<CommentDisplay key={comment.id}
                                  id={comment.id}
                                  body={comment.body}/>);
        })
      );
    } else if (this.props.attr === "votes") {
      return (
        this.state.allObjects.map(function(vote) {
          return (<VoteDisplay key={vote.id}
                                  id={vote.id}
                                  voteType={vote.vote_type}
                                  objectId={vote.votable_id}
                                  objectType={vote.votable_type}/>);
        })
      );
    }
  },

  render: function() {
    return (
      <div>
        {this.whichMap()}
      </div>
    );
  }
});
