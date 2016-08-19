/* globals React */
/* exported CommentDisplay */
var CommentDisplay = React.createClass({
  destroyComment: function () {
    var that = this;
    $.ajax({
      method: "DELETE",
      url: "/api/v1/comments/" + that.props.id,
      success: function(response) {
        window.location.replace("/");
      }
    });
  },

  parentClassName: function() {
    if (this.props.subLinks === true) {
      return (
        "card inLinks"
      );
    } else {
      return (
        "card"
      );
    }
  },

  render: function() {
    return (
      <div className={this.parentClassName()}>
        <p>
          <strong> Comment: </strong>
          {this.props.body}
        </p>
        <div className="row">
          <CreateVote voteType={"Comment"}
                      voteId={this.props.id}
                      votesCount={this.props.votesCount}/>
        </div>
        <div className>
          <div className="button danger" onClick={this.destroyComment}>
            Delete Comment
          </div>
        </div>
      </div>
    );
  }
});
