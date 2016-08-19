/* globals React */
/* exported CreateVote */
var CreateVote = React.createClass({
  getInitialState: function() {
    return {
      votesCount: this.props.votesCount
    };
  },

  postVote: function(string) {
    var currentCount = this.state.votesCount;
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
    success: function(response) {
        if (string === "up") {
            currentCount ++;
            that.setState({votesCount: currentCount});
        } else {
          currentCount --;
          that.setState({votesCount: currentCount});
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
          Aggregate Votes: {this.state.votesCount}
        </div>
      </div>
    );
  }
});
