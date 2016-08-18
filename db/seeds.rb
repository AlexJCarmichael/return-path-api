
VOTE_TYPES = ["up", "down"]

10.times do
  link = Link.create!(url: "www.google.com", title: Faker::Lorem.sentence)
  rand(1..4).times do
    Vote.create!(vote_type: VOTE_TYPES.sample, votable_id: link.id, votable_type: "Link")
  end
  rand(1..3).times do
    comment = Comment.create!(body: Faker::Lorem.sentence, link: link)
    rand(1..4).times do
      Vote.create!(vote_type: VOTE_TYPES.sample, votable_id: comment.id, votable_type: "Comment")
    end
  end
end
