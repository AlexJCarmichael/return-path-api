/* globals React */
/* exported LinksIndex */
var LinksIndex = React.createClass({
  getInitialState: function() {
    return {
      allLinks: []
    };
  },

  componentDidMount: function() {
    var that = this;
    var url = "/api/v1/links";
    $.getJSON(url, function(response) {
      that.setState({allLinks: response.data});
    });
  },

  render: function() {
    return (
      <div>
        <div>
          <LinkForm />
        </div>
        <div id="link-holder">
          {this.state.allLinks.map(function(link) {
            return (<LinkDisplay key={link.id}
                                 id={link.id}
                                 title={link.title}
                                 url={link.url}
                                 votesCount={link.aggregate_vote_count}/>);
          })}
        </div>
      </div>
    );
  }
});
