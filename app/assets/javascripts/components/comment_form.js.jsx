/* globals React */
/* exported CommentForm */
var CommentForm = React.createClass({
  getInitialState: function() {
    return {
      creation: false,
      body: ""
    };
  },

  handleClick: function() {
    this.setState({
      creation: !this.state.creation
    });
  },

  handleChange: function(element, event) {
    var change = {};
    change[element] = event.target.value;
    this.setState(change);
  },

  postComment: function(){
    var that = this;
    var target = "#comment-holder" + this.props.linkId;
    $.ajax({
    method: "POST",
    url: "/api/v1/comments",
    data: {
        comment: {
            body: this.state.body,
            link_id: this.props.linkId
        }
    },
    success: function(response) {
      console.log(response);
      that.setState({
        creation: !that.state.creation,
        body: ""
      });
        $(target).append(`<div class='card in-links'>
        <p>
            <strong> Body: </strong>` + response.data.body + `
          </p>
        </div>`);
    },
    error: function(response) {
          $("#link-errors").append("<h6 id='error'>" + response.responseText + "</h6>");
    }
});
  },

  renderForm: function() {
    if (this.state.creation === false) {
      return (
        <div className="button" onClick={this.handleClick}>
          New Comment
        </div>
      );
    } else {
      return (
        <div className="card">
          <div className="row">
            <label htmlFor="body" className="two columns">Body:</label>
            <input id="body"
                   className="nine columns"
                   onChange={this.handleChange.bind(this, "body")}/>
          </div>
          <div className="button" onClick={this.postComment}>
            Submit
          </div>
          <div className="button" onClick={this.handleClick}>
            Close
          </div>
        </div>
      );
    }
  },

  render: function() {
    return (
      <div>
        {this.renderForm()}
      </div>
    );
  }
});
