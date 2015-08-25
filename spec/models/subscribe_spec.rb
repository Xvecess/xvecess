require 'rails_helper'

describe Subscribe do

  it { should validate_presence_of :user }

  it { should validate_presence_of :question }

  it { should belong_to :user }

  it { should belong_to :question }
end
