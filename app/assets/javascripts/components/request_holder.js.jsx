/* globals React */
/* exported RequestHolder */
var RequestHolder = React.createClass({
  getInitialState: function() {
    return {
      displayMode: "empty"
    };
  },

  handleClick: function(string) {
    this.setState({displayMode: string});
  },

  renderControl: function() {
    if (this.state.displayMode === "links") {
      return (
        <Index attr="links"/>
      );
    } else if (this.state.displayMode === "comments") {
        return (
          <Index attr="comments"/>
        );
    } else if (this.state.displayMode === "votes") {
        return (
          <Index attr="votes"/>
        );
    } else {
      return (
        <span></span>
      );
    }
  },

  buttonBar: function() {
      return (
        <div className="row">
          <div className="button two columns" onClick={this.handleClick.bind(this, "links")}>
            Links
          </div>
          <div className="button three columns" onClick={this.handleClick.bind(this, "comments")}>
            Comments
          </div>
          <div className="button two columns" onClick={this.handleClick.bind(this, "votes")}>
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
          {this.renderControl()}
        </div>
      </div>
    );
  },
});
