/* globals React */
/* exported CreateVote */
var CreateVote = React.createClass({
  getInitialState: function() {
    return {
      votesCount: this.props.votesCount
    };
  },

  postVote: function(string) {
    var that = this;
    $.ajax({
      method: "POST",
      url: "/api/v1/votes/",
      data: {
        vote: {
          votable_id: this.props.voteId,
          votable_type: this.props.voteType,
          vote_type: string
        }
      },
    success: function() {
        if (string === "up") {
            that.setState({votesCount: that.state.votesCount + 1});
        } else {
          that.setState({votesCount: that.state.votesCount - 1});
        }
      }
    });
  },

  render: function() {
    return (
      <div className="row">
        <div className="four columns">
          <p className="button" onClick={this.postVote.bind(this, "up")}>Up Vote</p>
        </div>
        <div className="four columns">
          <p className="button" onClick={this.postVote.bind(this, "down")}>Down Vote</p>
        </div>
        <div className="four columns">
          <strong>Aggregate Votes: </strong> {this.state.votesCount}
        </div>
      </div>
    );
  }
});
