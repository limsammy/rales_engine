require 'rails_helper'

describe Invoice do

  it { should belong_to(:merchant) }

  it { should belong_to(:customer) }

end
