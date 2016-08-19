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

  render: function() {
    return (
      <div className="card">
        <p>
          <strong> Comment: </strong>
          {this.props.body}
        </p>
        <div className="row">
          <div className="button u-pull-left" onClick={this.destroyComment}>
            Delete
          </div>
          <p className="u-pull-right">
            <strong>Aggregate Votes: </strong>
            {this.props.votesCount}
          </p>
        </div>
      </div>
    );
  }
});
