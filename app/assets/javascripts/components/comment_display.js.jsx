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
        <div className="button" onClick={this.destroyComment}>
          Delete
        </div>
      </div>
    );
  }
});
