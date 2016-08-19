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

  showFullInfo: function(event) {
    console.log(event.target);
    $(event.target).parent().parent().find(".full-info").toggleClass("hidden");
  },

  render: function() {
    return (
      <div className="card">
        <div>
          <p className="hover" onClick={this.showFullInfo}>
            <strong> Link: </strong>
            {this.props.title}
          </p>
          <p className="hover" onClick={this.showFullInfo}>
            <strong> Url: </strong>
            {this.props.url}
          </p>
        </div>
        <div className="row">
          <CreateVote voteType={"Link"}
                      voteId={this.props.id}
                      votesCount={this.props.votesCount}/>
        </div>
        <div className="hidden full-info">
        <div onClick={this.destroyLink} className="button">
          Delete Link
        </div>
        </div>
      </div>
    );
  }
});
