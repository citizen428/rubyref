# frozen_string_literal: true

require 'cloudflare'
require 'dotenv/load'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*_test.rb']
end
desc 'Run tests'

namespace :cloudflare do
  desc 'Update Cloudflare CNAMEs'
  task :update_cnames do
    redirects = JSON.parse(File.read('redirects.json'))

    email = ENV.fetch('CLOUDFLARE_EMAIL')
    key = ENV.fetch('CLOUDFLARE_KEY')
    zone_id = ENV.fetch('CLOUDFLARE_ZONE')

    connection = Cloudflare.connect(key: key, email: email)
    zone = connection.zones.find_by_id(zone_id)
    cnames = zone.dns_records.all.select { |dns| dns.record[:type] == 'CNAME' }
    cnames.map! { |cname| cname.record[:name] }

    redirects.each_key do |cname|
      name = "#{cname}.rubyref.net"
      next if cnames.include?(name)

      puts "Setting CNAME: #{name}"
      zone.dns_records.post(
        {
          type: 'CNAME',
          name: name,
          content: 'rubyref.net',
          proxied: true
        }.to_json,
        content_type: 'application/json'
      )
    end
  end
end

task default: :test
