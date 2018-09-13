module ApplicationHelper

  def full_title(page_title = '')
    base_title = "Bloo TeeVee"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def currency
    [
      ['USD'],
      ['AUD'],
      ['CAD'],
      ['CHF'],
      ['DKK'],
      ['EUR'],
      ['GBP'],
      ['JPY'],
      ['MXN'],
      ['NOK'],
      ['SEK'],
      ['SGD']
    ]
  end

  def country
    [
      ['US | United States'],
      ['AT | Austria'],
      ['AU | Australia'],
      ['BE | Belgium'],
      ['CA | Canada'],
      ['DE | Germany'],
      ['DK | Denmark'],
      ['ES | Spain'],
      ['FI | Finland'],
      ['FR | France'],
      ['GB | United Kingdom'],
      ['IE | Ireland'],
      ['IT | Italy'],
      ['JP | Japan'],
      ['LU | Luxembourg'],
      ['MX | Mexico'],
      ['NL | Netherlands'],
      ['NO | Norway'],
      ['SE | Sweden']
    ]
  end

end
