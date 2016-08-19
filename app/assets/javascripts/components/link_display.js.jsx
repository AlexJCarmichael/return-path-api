/* globals React */
/* exported LinkDisplay */
var LinkDisplay = React.createClass({

  destroyLink: function () {
    var that = this;
    $.ajax({
      method: "DELETE",
      url: "/api/v1/links/" + that.props.id,
      success: function(response) {
        window.location.replace("/");
      }
    });
  },

  render: function() {
    return (
      <div className="card">
        <p>
          <strong> Link: </strong>
          {this.props.title}
        </p>
        <p>
          <strong> Url: </strong>
          {this.props.url}
        </p>
        <div className="row">
          <div className="button u-pull-left" onClick={this.destroyLink}>
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
