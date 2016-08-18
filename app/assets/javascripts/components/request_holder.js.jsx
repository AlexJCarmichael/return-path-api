/* globals React */
/* exported RequestHolder */
var RequestHolder = React.createClass({
  getInitialState: function() {
    return {
      displayMode: "empty"
    };
  },

  handleClick: function(event) {
    console.log(event);
  },

  renderControl: function() {

  },

  buttonBar: function() {
      return (
        <div className="row">
          <div className="button two columns" onClick={this.handleClick()}>
            Links
          </div>
          <div className="button three columns" onClick={this.handleClick()}>
            Comments
          </div>
          <div className="button two columns" onClick={this.handleClick()}>
            Votes
          </div>
        </div>
      );
  },

  render: function() {
    return (
      <div>
        <div>
          {this.buttonBar()}
        </div>
        <div className="request-holder">
        </div>
      </div>
    );
  },
});
