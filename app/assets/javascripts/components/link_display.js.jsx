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

  holderName: function() {
    return ("#comment-holder" + this.props.id);
  },

  showFullInfo: function(event) {
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
        <div onClick={this.destroyLink} className="button danger">
          Delete Link
        </div>
          <h5 className="small-top-margin">Comments ({this.props.commentsCount}):</h5>
          <div>
            <CommentForm linkId={this.props.id}/>
          </div>
            <div className={this.holderName()}>
            {this.props.commentsArr.map(function(comment) {
              return (<CommentDisplay key={comment.id}
                                      id={comment.id}
                                      body={comment.body}
                                      votesCount={comment.aggregate_vote_count}
                                      subLinks={true}/>);
            })}
          </div>
        </div>
      </div>
    );
  }
});
