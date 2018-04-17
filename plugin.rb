# name: discourse-affiliate
# about: Official affiliation plugin for Discourse
# version: 0.2
# authors: Régis Hanol (zogstrip), Sam Saffron
# url: https://github.com/discourse/discourse-affiliate

enabled_site_setting :redirector_enabled

after_initialize do

  require File.expand_path(File.dirname(__FILE__) + '/lib/redirector_processor')

  DiscourseEvent.on(:post_process_cooked) do |doc, post|
    doc.css('a[href]').each do |a|
      a['href'] = AffiliateProcessor.apply(a['href'])
    end
    true
  end

end
