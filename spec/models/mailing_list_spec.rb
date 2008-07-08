require File.dirname(__FILE__) + '/../spec_helper'

describe MailingList do
  before(:each) do
    @mailing_list = MailingList.new
  end

  it "should be valid" do
    @mailing_list.should be_valid
  end
end
