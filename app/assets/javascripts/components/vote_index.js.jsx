/* globals React */
/* exported VotesIndex */
var VotesIndex = React.createClass({
  getInitialState: function() {
    return {
      allVotes: []
    };
  },

  componentDidMount: function() {
    var that = this;
    var url = "/api/v1/votes";
    $.getJSON(url, function(response) {
      that.setState({allVotes: response.data});
    });
  },

  render: function() {
    return (
      <div>
        <div id="object-holder">
          {this.state.allVotes.map(function(vote) {
            return (<VoteDisplay key={vote.id}
                                 id={vote.id}
                                 voteType={vote.vote_type}
                                 objectType={vote.votable_type}
                                 objectId={vote.votable_id}/>);
          })}
        </div>
      </div>
    );
  }
});
