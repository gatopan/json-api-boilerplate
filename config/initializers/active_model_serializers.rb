require 'yaml'

# Disable for all serializers (except ArraySerializer)
ActiveModel::Serializer.root = false

# Disable for ArraySerializer
ActiveModel::ArraySerializer.root = false

# Set precision of time to not include miliseconds
ActiveSupport::JSON::Encoding.time_precision = 0
