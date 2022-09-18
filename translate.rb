# frozen_string_literal: true

require 'dotenv/load'
require 'net/http'
require 'uri'
require 'securerandom'
require 'json'

# Translate a string from one language to another
class Translate
  def initialize(text, from, to)
    @data = { text: text, from: from, to: to }
    @uri = generate_uri
    @req = config_request
  end

  def translate
    res = Net::HTTP.start(@uri.hostname, @uri.port, use_ssl: @uri.scheme == 'https') do |http|
      http.request(@req)
    end

    handle_response(res.body).first['translations'].first['text']
  end

  private

  def generate_uri
    URI("#{ENV['TRANSLATE_API']}&from=#{@data[:from]}&to=#{@data[:to]}")
  end

  def content(text)
    "[{\"Text\": \"#{text}\"}]"
  end

  def config_request
    req = Net::HTTP::Post.new(@uri)
    req.content_type = 'application/json'
    req.content_length = content(@data[:text]).length
    req['Ocp-Apim-Subscription-Key'] = ENV['KEY']
    req['Ocp-Apim-Subscription-Region'] = ENV['REGION']
    req['X-ClientTraceId'] = SecureRandom.uuid
    req.body = content(@data[:text])

    req
  end

  def handle_response(response)
    JSON.parse(response)
  end
end
