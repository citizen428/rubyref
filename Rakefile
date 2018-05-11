# frozen_string_literal: true

require 'cloudflare'
require 'dotenv/load'

namespace :cloudflare do
  desc 'Update Cloudflare CNAMEs'
  task :update_cnames do
    redirects = JSON.parse(File.read('data/redirects.json'))

    email = ENV.fetch('CLOUDFLARE_EMAIL')
    key = ENV.fetch('CLOUDFLARE_KEY')
    zone_id = ENV.fetch('CLOUDFLARE_ZONE')

    connection = Cloudflare.connect(key: key, email: email)
    zone = connection.zones.find_by_id(zone_id)
    records = zone.dns_records.all.select { |dns| dns.record[:type] == 'CNAME' }
    cnames = records.map do |cname|
      [cname.record[:name], cname.record[:content]]
    end.to_h

    redirects.each do |cname, redirect|
      name = "#{cname}.rubyref.net"
      next if cnames[cname] == redirect

      puts "Setting CNAME: #{name}"
      zone.dns_records.post(
        {
          type: 'CNAME',
          name: name,
          content: 'redirect',
          proxied: true
        }.to_json,
        content_type: 'application/json'
      )
    end
  end
end

task default: :test
