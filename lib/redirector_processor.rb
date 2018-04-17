# frozen_string_literal: true
#
class AffiliateProcessor

 
  def self.rules
    return @rules if @rules


    rule = lambda do |url, uri|
      code = SiteSetting.affiliate_processor_url
      if code.present?
        code url
      else
        url
      end
    end

    rules['all'] = rule
 
    @rules = rules
  end

  def self.apply(url)
    uri = URI.parse(url)

    if uri.scheme == 'http' || uri.scheme == 'https'
      rule = rules['all']
      return rule.call(url, uri) if rule
    end

    url
  rescue
    url
  end

end
