/* globals React */
/* exported RequestHolder */
var RequestHolder = React.createClass({
  buttonBar: function() {
      return (
        <div className="row">
          <div className="button two columns">Links</div>
          <div className="button three columns">Comments</div>
          <div className="button two columns">Votes</div>
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
