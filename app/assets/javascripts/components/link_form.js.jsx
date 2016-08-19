/* globals React */
/* exported LinkForm */
var LinkForm = React.createClass({
  getInitialState: function() {
    return {
      creation: false,
      url: "",
      title: ""
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

  postLink: function(){
    var that = this;
    $.ajax({
    method: "POST",
    url: "/api/v1/links",
    data: {
        links: {
            url: this.state.url,
            title: this.state.title
        }
    },
    success: function(response) {
      that.setState({
        creation: !that.state.creation,
        url: "",
        title: ""
      });
        $("#link-holder").append(`<div class='card'>
        <p>
            <strong> Link: </strong>` + response.data.title + `
          </p>
          <p>
            <strong> Url: </strong>
            ` + response.data.url + `
          </p>
        </div>`);
    },
    error: function(response) {
        $("#error").append("<h6 id='error-field'>" + response.data + "</h6>");
    }
});
  },

  renderForm: function() {
    if (this.state.creation === false) {
      return (
        <div className="button" onClick={this.handleClick}>
          New Link
        </div>
      );
    } else {
      return (
        <div className="card">
          <div className="row">
            <label htmlFor="url" className="two columns">Url:</label>
            <input id="url"
                   className="nine columns"
                   onChange={this.handleChange.bind(this, "url")}/>
          </div>
          <div className="row ">
            <label htmlFor="title" className="two columns">Title:</label>
            <input id="title"
                   className="nine columns"
                   onChange={this.handleChange.bind(this, "title")}/>
          </div>
          <div className="button" onClick={this.postLink}>
            Submit
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
