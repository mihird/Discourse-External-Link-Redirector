require 'rails_helper'

describe RedirectorProcessor do

  def r(url)
    RedirectorProcessor.apply(url)
  end

  it 'can apply affiliate code to all' do
    SiteSetting.redirector_processor_url = 'http://goto.ideasquarelab.com/'

    expect(r('http://www.ldlc.com/some_product?xyz=1')).to eq('http://goto.ideasquarelab.com/http://www.ldlc.com/some_product?xyz=1#samsshop')
  end

  it 'can apply codes to post in post processor' do
    SiteSetting.redirector_processor_url = 'http://goto.ideasquarelab.com/'

    post = create_post(raw: 'this is an www.amazon.com/link?testing')
    post.reload

    expect(post.cooked.scan('sams-shop').length).to eq(1)
  end

end
