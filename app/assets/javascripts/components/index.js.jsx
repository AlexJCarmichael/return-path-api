/* globals React */
/* exported Index */
var Index = React.createClass({
  getInitialState: function() {
    return {
      allObjects: []
    };
  },

  componentDidMount: function() {
    var that = this;
    var url = "/api/v1/" + this.props.attr;
    $.getJSON(url, function(response) {
      that.setState({allObjects: response.data});
    });
  },

  whichMap: function() {
    if (this.props.attr === "links") {
      return (
        this.state.allObjects.map(function(link) {
          return (<LinkDislay key={link.id}
                                 url={link.url}
                                 title={link.title}/>);
        })
      );
    }
  },

  render: function() {
    return (
      <div>
        {this.whichMap()}
      </div>
    );
  }
});
