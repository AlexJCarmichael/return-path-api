/* globals React */
/* exported CommentsIndex */
var CommentsIndex = React.createClass({
  getInitialState: function() {
    return {
      allComments: []
    };
  },

  componentDidMount: function() {
    var that = this;
    var url = "/api/v1/comments";
    $.getJSON(url, function(response) {
      that.setState({allComments: response.data});
    });
  },

  render: function() {
    return (
      <div>
        <div id="object-holder">
          {this.state.allComments.map(function(comment) {
            return (<CommentDisplay key={comment.id}
                                    id={comment.id}
                                    body={comment.body}
                                    votesCount={comment.aggregate_vote_count}
                                    subLinks={false}/>);
          })}
        </div>
      </div>
    );
  }
});
