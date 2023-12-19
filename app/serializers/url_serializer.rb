class UrlSerializer < ActiveModel::Serializer
  attributes :id,:long_url, :short_url
end
