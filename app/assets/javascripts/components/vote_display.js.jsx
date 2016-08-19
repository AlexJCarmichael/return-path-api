/* globals React */
/* exported VoteDisplay */
var VoteDisplay = React.createClass({

  destroyVote: function () {
    var that = this;
    $.ajax({
      method: "DELETE",
      url: "/api/v1/votes/" + that.props.id,
      success: function(response) {
        window.location.replace("/");
      }
    });
  },

  render: function() {
    return (
      <div className="card">
        <p>
          <strong> Up or Down: </strong>
          {this.props.voteType}
        </p>
        <p>
          <strong> Object type: </strong>
          {this.props.objectType}
        </p>
        <p>
          <strong> Object id: </strong>
          {this.props.objectId}
        </p>
        <div className="button danger" onClick={this.destroyVote}>
          Delete
        </div>
      </div>
    );
  }
});
