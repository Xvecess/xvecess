require 'rails_helper'

describe Comment do

  it { should belong_to :user }

  it { should belong_to :commentable }

  it { should validate_presence_of :body }

  it { should validate_presence_of :user_id }

  it { should validate_presence_of :commentable_id }

  it { should validate_presence_of :commentable_type }

end